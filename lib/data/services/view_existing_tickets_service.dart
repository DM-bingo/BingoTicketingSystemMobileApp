import 'dart:convert';
import 'package:bingo_ticketing_system_mobile/core/constants/api_constants.dart';
import 'package:bingo_ticketing_system_mobile/core/error/exceptions.dart';
import 'package:bingo_ticketing_system_mobile/data/models/ticket_model.dart';
import 'package:bingo_ticketing_system_mobile/data/services/auth_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<dynamic> parseJson(String body) {
  return jsonDecode(body) as List<dynamic>;
}

class ViewExistingTicketsService {
  final _storage = AuthStorage();

  Future<List<TicketModel>> fetchTickets() async {
    final token = await _storage.getAccessToken();

    final response = await http.get(
      Uri.parse(ApiConstants.fetchTickets),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    handleApiResponse(response.statusCode, response.body);

    final List data = await compute(parseJson, response.body);

    return data.map((e) => TicketModel.fromJson(e)).toList();
  }
}