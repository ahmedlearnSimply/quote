// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned(
            top: 240,
            right: 25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "كلمة واحدة قد تغيّر يومك",
                  style: getTitleStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "او حياتك",
                  style: getTitleStyle(
                    fontSize: 50,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 200,
            right: 25,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "ما هو اسمك؟",
                        style: getTitleStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "   لنُخصص الاقتباسات لك",
                        style: getTitleStyle(
                          fontSize: 16,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
