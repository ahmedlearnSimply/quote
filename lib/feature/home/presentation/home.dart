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
  List<String> categories = ["aya"];
  String selectedCategory = "aya";
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
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: AppColors.secondary,
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        items: <Widget>[
          Icon(Icons.home, size: 35, color: AppColors.redColor),
          Icon(Icons.favorite, size: 35, color: AppColors.redColor),
          Icon(Icons.person, size: 35, color: AppColors.redColor),
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.black, Colors.black87],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(flex: 2),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            child: Text(
                              quote.text,
                              key: ValueKey(quote.text),
                              style: getBodyStyle(
                                  fontSize: 30, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.redColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '- ${quote.surah} -',
                              style: getBodyStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Spacer(flex: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  toggleLike(quote);
                                },
                                icon: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    key: ValueKey(isLiked),
                                    color: isLiked
                                        ? AppColors.redColor
                                        : Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                              Gap(40),
                              IconButton(
                                onPressed: () {
                                  Share.share(quote.text);
                                },
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                          Spacer(flex: 1),
                        ],
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
