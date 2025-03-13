// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/feature/home/model/quote.dart';
import 'package:quote/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //* variables
  List<String> categories = ["total"];

  String selectedCategory = "total";
  List<Quote> quotes = [];
  final PageController _pageController = PageController();
  final Random _random = Random();

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
      quotes.shuffle();
    });
  }

  Quote getRandomQuote() {
    if (quotes.isEmpty) {
      return Quote(text: "لا توجد اقتباسات متاحة", author: "غير معروف");
    }
    return quotes[_random.nextInt(quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemCount: quotes.length,
          itemBuilder: (context, index) {
            final quote = getRandomQuote();
            return Container(
              decoration: BoxDecoration(color: AppColors.black),
              alignment: Alignment.center,
              child: Card(
                color: AppColors.black,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 2),
                      Text(
                        quote.text,
                        style: getBodyStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '- ${quote.author}',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      Spacer(flex: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                AppAssets.heart,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
