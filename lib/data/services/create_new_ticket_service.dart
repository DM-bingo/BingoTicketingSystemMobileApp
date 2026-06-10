import 'dart:convert';
import 'package:bingo_ticketing_system_mobile/core/constants/api_constants.dart';
import 'package:bingo_ticketing_system_mobile/core/error/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bingo_ticketing_system_mobile/data/services/auth_storage.dart';

class CreateNewTicketService {
  Future<bool> createTicket({
    required int categoryId,
    required int priority,
    required String title,
    required int locationId,
    required String description,
    List<String>? photosBase64,
  }) async {
    final token = await AuthStorage().getAccessToken();
    final userId = await AuthStorage().getUserId();

    final body = {
      "createdByUserId": userId,
      "categoryId": categoryId,
      "title": title,
      "description": description,
      "priority": priority,
      "photosBase64": photosBase64,
      "locationId": locationId
    };

    final response = await http.post(
      Uri.parse(ApiConstants.createNewTicket),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );


    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");


    handleApiResponse(response.statusCode, response.body);

    return response.statusCode == 200;
  }
}
