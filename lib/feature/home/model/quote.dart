import 'dart:convert';
import 'package:flutter/services.dart';

class Quote {
  String text;
  String author;
  Quote({
    required this.text,
    required this.author,
  });

  //* Convert json to Quote object
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json["text"],
      author: json["author"],
    );
  }
  //* Convert Quote object to Json
  Map<String, dynamic> toJson() {
    return {"text": text, "author": author};
  }
}

Future<List<Quote>> loadQuotesFromCategory(String category) async {
  try {
    String filePath =
        'assets/json/ar/$category.json'; //assets/json/ar/beauty.json
    String jsonData = await rootBundle.loadString(filePath);
    List<dynamic> jsonList = json.decode(jsonData);
    return jsonList.map((json) => Quote.fromJson(json)).toList();
  } catch (e) {
    throw Exception("Error loading quotes: $e");
  }
}
