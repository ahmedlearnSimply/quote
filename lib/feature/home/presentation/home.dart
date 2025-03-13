// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/feature/home/model/quote.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //* variables
  Set<String> likedQuotes = {}; // Store liked quotes separately
  List<String> categories = ["total"];
  String selectedCategory = "total";
  List<Quote> quotes = [];
  final PageController _pageController = PageController();
  int currentIndex = 0; // Track the current quote index

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
      currentIndex = 0; // Always start from the first quote
    });
  }

  void toggleLike(String quoteText) {
    setState(() {
      if (likedQuotes.contains(quoteText)) {
        likedQuotes.remove(quoteText);
      } else {
        likedQuotes.add(quoteText);
      }
    });
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
          onPageChanged: (index) {
            setState(() {
              currentIndex = index; // Update current index when scrolling
            });
          },
          itemBuilder: (context, index) {
            final quote =
                quotes[index]; // Show the correct quote based on index
            bool isLiked = likedQuotes.contains(quote.text); // Check if liked

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
                          IconButton(
                            onPressed: () {
                              toggleLike(
                                  quote.text); // Like/Unlike only this quote
                            },
                            icon: SizedBox(
                              width: 50,
                              height: 50,
                              child: isLiked
                                  ? Image.asset(AppAssets.heart)
                                  : Image.asset(AppAssets.like),
                            ),
                          ),
                          Gap(40),
                          IconButton(
                            onPressed: () {
                              Share.share(quote.text);
                            },
                            icon: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset(AppAssets.upload),
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
