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

  /// Remove quote from favorites
  void _removeFromFavorites(Quote quote) {
    setState(() {
      favQuotes.remove(quote);
      // AppLocalStorage.removeFromFav(quote);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم إزالة الاقتباس من المفضلة"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(
          "مرحبا بك ${AppLocalStorage.getCachedData(key: AppLocalStorage.name)}",
          style: getTitleStyle(color: AppColors.primary, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: favQuotes.isEmpty
          ? Center(
              child: Text(
                "لا يوجد اقتباسات مفضلة بعد!",
                style: getBodyStyle(fontSize: 20, color: Colors.black),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: favQuotes.length,
              itemBuilder: (context, index) {
                final quote = favQuotes[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.only(bottom: 12),
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      quote.text,
                      style: getBodyStyle(fontSize: 18, color: Colors.black),
                      textAlign: TextAlign.right, // Arabic alignment
                    ),
                    subtitle: Text(
                      "- ${quote.surah}",
                      style: getBodyStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.right,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        _removeFromFavorites(quote);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
