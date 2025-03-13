import 'package:quote/feature/home/model/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppLocalStorage {
  //*variables
  static const String kOnboarding = "onboarding";
  static const String name = "name";
  static const String _favQuotesKey = 'fav_quotes';

  //* shared preferences
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //* caching data
  static cacheData({required String key, required dynamic value}) {
    if (value is String) {
      _sharedPreferences.setString(key, value);
    } else if (value is int) {
      _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      _sharedPreferences.setDouble(key, value);
    } else {
      _sharedPreferences.setStringList(key, value);
    }
  }

  //* getting cached data
  static dynamic getCachedData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static const String _key = 'saved_quotes';

  // Save list of quotes to SharedPreferences
  static Future<void> saveQuotes(List<Quote> quotes, String key) async {
    List<String> quoteStrings =
        quotes.map((q) => jsonEncode(q.toJson())).toList();
    await _sharedPreferences.setStringList(_key, quoteStrings);
  }

  // Load list of quotes from SharedPreferences
  static List<Quote> loadQuotes(String key) {
    List<String>? quoteStrings = _sharedPreferences.getStringList(key);

    if (quoteStrings != null) {
      return quoteStrings.map((q) => Quote.fromJson(jsonDecode(q))).toList();
    } else {
      return []; // Return empty list if no data found
    }
  }

  static List<Quote> loadFavQuotes() {
    return loadQuotes(_favQuotesKey);
  }

  //* add to favorites  Quotes
  static Future<void> addToFav(Quote quote) async {
    List<Quote> favorites = await loadQuotes(_favQuotesKey);
    favorites.add(quote);
    await saveQuotes(favorites, _favQuotesKey);
  }
}
