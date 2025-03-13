import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/functions/naviagation.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/feature/fav/presentation/favPage.dart';
import 'package:quote/feature/home/model/quote.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //* Variables
  Set<String> likedQuotes = {};
  List<String> categories = ["total"];
  String selectedCategory = "total";
  List<Quote> quotes = [];
  Random _random = Random();
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadQuotes(selectedCategory);
    _loadFavorites();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Load favorite quotes from SharedPreferences
  Future<void> _loadFavorites() async {
    List<Quote> favorites = AppLocalStorage.loadFavQuotes();
    setState(() {
      likedQuotes = favorites.map((q) => q.text).toSet();
    });
  }

  Future<void> _loadQuotes(String category) async {
    List<Quote> loadedQuotes = await loadQuotesFromCategory(category);
    setState(() {
      quotes = loadedQuotes;
      if (quotes.isNotEmpty) {
        currentIndex = _random.nextInt(quotes.length);
      }
    });
  }

  /// Toggle Like (Add to Favorites)
  void toggleLike(Quote quote) async {
    if (!likedQuotes.contains(quote.text)) {
      setState(() {
        likedQuotes.add(quote.text);
      });
      await AppLocalStorage.addToFav(quote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await push(context, Favpage());
          _loadFavorites(); // Refresh favorites when returning from Favpage
        },
        child: Icon(Icons.favorite, color: Colors.white),
        backgroundColor: Colors.red,
      ),
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
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final quote = quotes[index];
            bool isLiked = likedQuotes.contains(quote.text);

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
                        style: getBodyStyle(fontSize: 30, color: Colors.white),
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
                              toggleLike(quote);
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
