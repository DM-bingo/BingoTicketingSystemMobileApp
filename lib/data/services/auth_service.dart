import 'dart:convert';
import 'package:http/http.dart' as http;


class AuthService {
  
    Future<Map<String, dynamic>?> activateUser(String otp) async {
  final response = await http.post(
    Uri.parse("http://172.23.207.81:5000/api/Auth/activate-user"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "activationCode": otp,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }
  return null;
}
  
}

