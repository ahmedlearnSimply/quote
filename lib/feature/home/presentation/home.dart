import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/feature/home/model/quote.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Quote> quotes = [];
  Quote? currentQuote;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    List<Quote> loadedQuotes = await AppLocalStorage.loadQuotes();

    if (loadedQuotes.isEmpty) {
      // If no quotes are found, use default ones
      loadedQuotes = [
        Quote(
            text: "يختلف الناس في سر القهوة وتختلف آراؤهم :",
            author: "مريد البرغوثي"),
        Quote(
            text: "كوب القهوة في الصباح يؤدي مهام كأن يهذب أمزجة البشر",
            author: "نداء بنت زيد"),
      ];
      await AppLocalStorage.saveQuotes(loadedQuotes);
    }

    setState(() {
      quotes = loadedQuotes;
      currentQuote = quotes[Random().nextInt(quotes.length)];
    });
  }

  void _generateNewQuote() {
    setState(() {
      currentQuote = quotes[Random().nextInt(quotes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('أقوال مأثورة')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentQuote != null) ...[
                Text(
                  currentQuote!.text,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text('- ${currentQuote!.author}',
                    style: TextStyle(fontSize: 18)),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateNewQuote,
                child: Text('اقتباس جديد'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
