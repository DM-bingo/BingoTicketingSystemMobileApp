import 'dart:convert';
import 'package:bingo_ticketing_system_mobile/core/constants/api_constants.dart';
import 'package:bingo_ticketing_system_mobile/core/error/exceptions.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


class AuthService {
  Future<Map<String, dynamic>> activateUser(String otp) async {
    final response = await http.post(
      Uri.parse(ApiConstants.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "activationCode": otp,
      }),
    );

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    handleApiResponse(response.statusCode, response.body);

    return jsonDecode(response.body);
  }
}