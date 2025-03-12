import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quote/feature/home/model/quote.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categories = [
    'total',
  ];

  String selectedCategory = "total"; // Default category
  List<Quote> quotes = [];
  Quote? currentQuote;

  @override
  void initState() {
    super.initState();
    _loadQuotes(selectedCategory);
  }

  Future<void> _loadQuotes(String category) async {
    List<Quote> loadedQuotes = await loadQuotesFromCategory(category);
    setState(() {
      quotes = loadedQuotes;
      if (quotes.isNotEmpty) {
        currentQuote = quotes[Random().nextInt(quotes.length)];
      }
    });
  }

  void _generateNewQuote() {
    if (quotes.isNotEmpty) {
      setState(() {
        currentQuote = quotes[Random().nextInt(quotes.length)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('أقوال مأثورة')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newCategory) {
                if (newCategory != null) {
                  setState(() {
                    selectedCategory = newCategory;
                  });
                  _loadQuotes(newCategory);
                }
              },
            ),
            SizedBox(height: 20),
            if (currentQuote != null) ...[
              Text(
                currentQuote!.text,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text('- ${currentQuote!.author}', style: TextStyle(fontSize: 18)),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateNewQuote,
              child: Text('اقتباس جديد'),
            ),
          ],
        ),
      ),
    );
  }
}
