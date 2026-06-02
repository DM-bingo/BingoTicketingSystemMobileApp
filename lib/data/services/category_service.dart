import 'dart:convert';

import 'package:bingo_ticketing_system_mobile/core/constants/api_constants.dart';
import 'package:bingo_ticketing_system_mobile/data/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(
      Uri.parse(ApiConstants.categoriesUrl)
    );

    if(response.statusCode == 200){
      final List data = jsonDecode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    }

    throw Exception("Ne mogu ucitatt ove kategorijee alooo");
  }
}