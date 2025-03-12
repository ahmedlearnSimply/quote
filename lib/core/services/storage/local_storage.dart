import 'package:quote/feature/home/model/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppLocalStorage {
  //*variables
  static const String kOnboarding = "onboarding";
  static const String name = "name";

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
  static Future<void> saveQuotes(List<Quote> quotes) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> quoteStrings =
        quotes.map((q) => jsonEncode(q.toJson())).toList();
    await prefs.setStringList(_key, quoteStrings);
  }

  // Load list of quotes from SharedPreferences
  static Future<List<Quote>> loadQuotes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? quoteStrings = prefs.getStringList(_key);

    if (quoteStrings != null) {
      return quoteStrings.map((q) => Quote.fromJson(jsonDecode(q))).toList();
    } else {
      return []; // Return empty list if no data found
    }
  }
}
