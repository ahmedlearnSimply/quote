// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote/core/widgets/custom_app_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:quote/core/functions/naviagation.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/feature/fav/presentation/favPage.dart';
import 'package:quote/feature/home/model/quote.dart';
import 'package:quote/feature/screens/profile.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  // Variables
  Set<String> likedQuotes = {};
  List<String> categories = [
    "aya",
  ];
  String selectedCategory = "aya";
  List<Quote> quotes = [];
  final Random _random = Random();
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final PageController _pageController = PageController();
  int currentIndex = 0;
  final List<Widget> _navPages = [Favpage(), Profile()];

  @override
  void initState() {
    super.initState();
    _loadQuotes(selectedCategory);
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<Quote> favorites = AppLocalStorage.loadFavQuotes();
    setState(() => likedQuotes = favorites.map((q) => q.text).toSet());
  }

  Future<void> _loadQuotes(String category) async {
    List<Quote> loadedQuotes = await loadQuotesFromCategory(category);
    setState(() {
      quotes = loadedQuotes;
      if (quotes.isNotEmpty) currentIndex = _random.nextInt(quotes.length);
    });
  }

  void toggleLike(Quote quote) async {
    if (!likedQuotes.contains(quote.text)) {
      setState(() => likedQuotes.add(quote.text));
      await AppLocalStorage.addToFav(quote);
    }
  }

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(selectedDate: _selectedDate),
      bottomNavigationBar: _buildFancyNavigationBar(),
      backgroundColor: AppColors.black,
      body: _page == 0 ? _buildQuoteScreen() : _navPages[_page - 1],
    );
  }

  Widget _buildQuoteScreen() {
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(seconds: 1),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(AppColors.secondary, Colors.black, 0.2)!,
                Color.lerp(AppColors.redColor, Colors.black, 0.7)!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemCount: quotes.length,
          onPageChanged: (index) => setState(() => currentIndex = index),
          itemBuilder: (context, index) => _buildQuoteCard(quotes[index]),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Chip(
            backgroundColor: AppColors.redColor.withOpacity(0.8),
            label: Text(selectedCategory.toUpperCase(),
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteCard(Quote quote) {
    bool isLiked = likedQuotes.contains(quote.text);
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    3,
                    (i) => Icon(Icons.star,
                        color: Colors.white.withOpacity(0.3), size: 20)),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 800),
                  child: Text(
                    quote.text,
                    key: ValueKey(quote.text),
                    style: getBodyStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? AppColors.redColor : Colors.white,
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
            ],
          ),
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

  CurvedNavigationBar _buildFancyNavigationBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: AppColors.secondary,
      color: AppColors.redColor.withOpacity(0.8),
      height: 60,
      animationCurve: Curves.easeInOutBack,
      animationDuration: Duration(milliseconds: 600),
      items: [
        Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.home, color: Colors.white),
        ]),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.favorite, color: Colors.white),
        ]),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.person, color: Colors.white),
        ]),
      ],
      onTap: (index) => setState(() => _page = index),
    );
  }

  // void _showCategorySelector() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [AppColors.black, AppColors.secondary],
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //       ),
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(20),
  //             child: Text('Select Category',
  //                 style: GoogleFonts.poppins(
  //                     fontSize: 20,
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold)),
  //           ),
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: categories.length,
  //               itemBuilder: (context, index) => ListTile(
  //                 title: Text(categories[index].toUpperCase(),
  //                     style: GoogleFonts.poppins(color: Colors.white)),
  //                 trailing:
  //                     Icon(Icons.arrow_forward_ios, color: Colors.white70),
  //                 onTap: () {
  //                   setState(() => selectedCategory = categories[index]);
  //                   _loadQuotes(categories[index]);
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Center(
            child: Text('تم النسخ',
                style: GoogleFonts.poppins(color: Colors.white))),
      ),
    );
  }
}
