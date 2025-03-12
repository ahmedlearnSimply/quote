import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quote/feature/home/model/quote.dart';

class QuoteRepository {
  Future<List<Quote>> loadQuotesFromCategory(String category) async {
    try {
      String filePath = 'ar/$category.json';
      String jsonData = await rootBundle.loadString(filePath);
      List<dynamic> jsonList = json.decode(jsonData);
      return jsonList.map((json) => Quote.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error loading quotes: $e");
    }
  }
}
