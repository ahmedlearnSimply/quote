import 'dart:convert';
import 'package:flutter/services.dart';

class Quote {
  String text;
  int? ayah;
  String? surah;

  Quote({
    required this.text,
    required this.surah,
    required this.ayah,
  });

  //* Convert json to Quote object
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json["text"],
      ayah: json["ayah"],
      surah: json["surah"],
    );
  }
  //* Convert Quote object to Json
  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "ayah": ayah,
      "surah": surah,
    };
  }
}

Future<List<Quote>> loadQuotesFromCategory(String category) async {
  try {
    String filePath = 'assets/json/ar/$category.json';
//assets/json/ar/aya.json
    String jsonData = await rootBundle.loadString(filePath);
    List<dynamic> jsonList = json.decode(jsonData);
    return jsonList.map((json) => Quote.fromJson(json)).toList();
  } catch (e) {
    throw Exception("Error loading quotes: $e");
  }
}
