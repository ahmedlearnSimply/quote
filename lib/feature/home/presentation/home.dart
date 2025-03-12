import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quote/feature/home/model/quote.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categories = ["total"];

  String selectedCategory = "total"; // Default category
  List<Quote> quotes = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadQuotes(selectedCategory);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadQuotes(String category) async {
    List<Quote> loadedQuotes = await loadQuotesFromCategory(category);
    setState(() {
      quotes = loadedQuotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('أقوال مأثورة')),
      body: Column(
        children: [
          // Dropdown for selecting categories
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
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
          ),
          // PageView to show one quote per page
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                final quote = quotes[index];
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            quote.text,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            '- ${quote.author}',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
