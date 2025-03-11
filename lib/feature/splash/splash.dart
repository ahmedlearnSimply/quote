import 'package:flutter/material.dart';
import 'package:quote/core/functions/naviagation.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/feature/home/presentation/home.dart';
import 'package:quote/feature/intro/Welcome.dart';
import 'package:quote/feature/onboarding/pages/onborading_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Colors.white.withOpacity(0.3),
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AppAssets.brain,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                "كن مستعدًا لتغيير حياتك! ✨",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
