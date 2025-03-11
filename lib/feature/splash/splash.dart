// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/functions/naviagation.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/core/widgets/custom_button.dart';
import 'package:quote/feature/home/presentation/home.dart';
import 'package:quote/feature/intro/Welcome.dart';
import 'package:quote/feature/onboarding/pages/onborading_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  TextEditingController name = TextEditingController();
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      bool isOnboardingShown =
          AppLocalStorage.getCachedData(key: AppLocalStorage.kOnboarding) ??
              false;
      bool hasEnteredName =
          AppLocalStorage.getCachedData(key: AppLocalStorage.name) != null;
      if (isOnboardingShown && hasEnteredName) {
        pushReplacement(context, Home());
      } else if (isOnboardingShown) {
        pushReplacement(context, WelcomePage());
      } else {
        pushReplacement(context, OnboradingPage());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Image.asset(
          AppAssets.brain,
        ),
      ),
    );
  }
}
