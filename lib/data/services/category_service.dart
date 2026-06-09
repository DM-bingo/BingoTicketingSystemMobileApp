import 'dart:convert';

import 'package:bingo_ticketing_system_mobile/core/constants/api_constants.dart';
import 'package:bingo_ticketing_system_mobile/core/error/exceptions.dart';
import 'package:bingo_ticketing_system_mobile/data/models/category_model.dart';
import 'package:bingo_ticketing_system_mobile/data/services/auth_storage.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    final storage = AuthStorage();
    final token = await storage.getAccessToken();
    final response = await http.get(
      Uri.parse(ApiConstants.categoriesUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    handleApiResponse(response.statusCode, response.body);

    final List data = jsonDecode(response.body);
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }
}
