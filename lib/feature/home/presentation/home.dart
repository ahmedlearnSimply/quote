// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/functions/naviagation.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/feature/fav/presentation/favPage.dart';
import 'package:quote/feature/home/model/quote.dart';
import 'package:quote/feature/screens/profile.dart';
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
  final Random _random = Random();
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadQuotes(selectedCategory);
    _loadFavorites();
    // quotes = quotes[_random.nextInt(quotes.length)];
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
      final randomQuote = (quotes..shuffle()).first;
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

  List pages = [
    Favpage(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.transparent, // Transparent for floating effect
        // color: Colors.black, // Bar color
        buttonBackgroundColor: AppColors.secondary, // Button highlight color
        height: 60, // Adjust height for better appearance
        animationCurve: Curves.easeInOut, // Smooth animation
        animationDuration: Duration(milliseconds: 400), // Adjust speed
        items: <Widget>[
          Icon(Icons.home, size: 35, color: AppColors.redColor), // Home Icon
          Icon(Icons.favorite,
              size: 35, color: AppColors.redColor), // Favorite Icon
          Icon(Icons.person,
              size: 35, color: AppColors.redColor), // Profile Icon
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      backgroundColor: AppColors.black,
      body: _page == 0
          ? SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: quotes.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                    _loadQuotes(selectedCategory);
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
                              style: getBodyStyle(
                                  fontSize: 30, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            Text(
                              '- ${quote.author}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
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
            )
          : _page == 1
              ? Favpage()
              : Profile(),
    );
  }
}
