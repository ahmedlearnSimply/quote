import 'package:quote/feature/home/model/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppLocalStorage {
  //*variables
  static const String kOnboarding = "onboarding";
  static const String name = "name";
  static const String _favQuotesKey = 'fav_quotes';
  static const String _key = 'saved_quotes';

  //* shared preferences
  static late SharedPreferences _sharedPreferences;

  //* initialize shared preferences
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

  //* Save a list of quotes to SharedPreferences
  static Future<void> saveQuotes(List<Quote> quotes, String key) async {
    List<String> quoteStrings = quotes.map((q) {
      return jsonEncode(q.toJson());
    }).toList();
    await _sharedPreferences.setStringList(key, quoteStrings);
  }

  //* Load a list of quotes from SharedPreferences
  static List<Quote> loadQuotes(String key) {
    List<String>? quoteStrings = _sharedPreferences.getStringList(key);
    if (quoteStrings != null) {
      return quoteStrings.map((q) => Quote.fromJson(jsonDecode(q))).toList();
    } else {
      return []; // Return empty list if no data found
    }
  }

  /// Load favorite quotes
  static List<Quote> loadFavQuotes() {
    return loadQuotes(_favQuotesKey);
  }

  /// Add to favorites (prevents duplicates)
  static Future<void> addToFav(Quote quote) async {
    List<Quote> favorites = loadFavQuotes();

    // Prevent duplicate quotes
    if (!favorites.any((q) => q.text == quote.text)) {
      favorites.add(quote);
      await saveQuotes(favorites, _favQuotesKey);
    }
  }
}
