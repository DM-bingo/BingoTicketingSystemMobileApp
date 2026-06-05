import 'dart:convert';
import 'package:bingo_ticketing_system_mobile/core/constants/api_constants.dart';
import 'package:bingo_ticketing_system_mobile/data/models/ticket_model.dart';
import 'package:bingo_ticketing_system_mobile/data/services/auth_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ViewExistingTicketsService {
  final _storage = AuthStorage();

  Future<List<TicketModel>> fetchTickets() async {
    final token = await _storage.getAccessToken();
    final userId = await _storage.getUserId();

    final response = await http.get(
      Uri.parse("${ApiConstants.fetchTickets}?userId=$userId"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => TicketModel.fromJson(e)).toList();
    } else {
      throw Exception("Greška pri fetchu ticketa");
    }
  }
}