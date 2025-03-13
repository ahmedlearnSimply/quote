import 'package:flutter/material.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/feature/home/model/quote.dart';

class Favpage extends StatefulWidget {
  const Favpage({super.key});

  @override
  State<Favpage> createState() => _FavpageState();
}

class _FavpageState extends State<Favpage> {
  List<Quote> favQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  /// Load favorite quotes from SharedPreferences
  void _loadFavorites() {
    setState(() {
      favQuotes = AppLocalStorage.loadFavQuotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(
          "مرحبا بك ${AppLocalStorage.getCachedData(key: AppLocalStorage.name)}",
          style: getTitleStyle(color: AppColors.primary, fontSize: 28),
        ),
      ),
      body: favQuotes.isEmpty
          ? Center(
              child: Text("لا يوجد اقتباسات مفضلة بعد!",
                  style: getBodyStyle(fontSize: 20, color: Colors.black)))
          : ListView.builder(
              itemCount: favQuotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favQuotes[index].text,
                      style: getBodyStyle(
                        fontSize: 18,
                        color: Colors.black,
                      )),
                );
              },
            ),
    );
  }
}
