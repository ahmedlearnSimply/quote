// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/app_theme.dart';
import 'package:quote/feature/fav/presentation/favPage.dart';
import 'package:quote/feature/home/presentation/home.dart';
import 'package:quote/feature/home/presentation/test.dart';
import 'package:quote/feature/onboarding/pages/onborading_page.dart';
import 'package:quote/feature/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalStorage.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('ar')],
      locale: Locale('ar'),
      home: Scaffold(
        body: Test(),
      ),
    );
  }
}
