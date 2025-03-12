import 'dart:convert';

class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  // Convert JSON to Quote object
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'],
      author: json['author'],
    );
  }

  // Convert Quote object to JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
    };
  }
}
