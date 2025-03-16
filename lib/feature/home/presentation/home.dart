import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: AppColors.white,
        content: Center(
          child: Text('تم النسخ', style: getBodyStyle()),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      {required IconData icon, required Color color, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(15),
        child: Icon(icon, size: 30, color: color),
      ),
    );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 67, 67, 67),
        onPressed: () {
          push(context, Favpage());
        },
        child: Icon(
          Icons.favorite,
          size: 30,
          color: const Color.fromARGB(255, 255, 65, 65),
        ),
      ), // ),
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
                    // _loadQuotes(selectedCategory);
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
                                  fontFamily: 'dancing',
                                  fontSize: 30,
                                  color: Colors.white),
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
                                fontFamily: 'cairo',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          Spacer(flex: 1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(
                                icon: isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    isLiked ? AppColors.redColor : Colors.white,
                                onTap: () => toggleLike(quote),
                              ),
                              _buildActionButton(
                                  icon: Icons.copy,
                                  color: Colors.white,
                                  onTap: () => _copyToClipboard(quote.text)),
                              _buildActionButton(
                                  icon: Icons.share,
                                  color: Colors.white,
                                  onTap: () => Share.share(quote.text)),
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
