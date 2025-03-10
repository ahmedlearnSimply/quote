// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/feature/onboarding/model/onboradingModel.dart';

class OnboradingPage extends StatefulWidget {
  const OnboradingPage({super.key});

  @override
  State<OnboradingPage> createState() => _OnboradingPageState();
}

class _OnboradingPageState extends State<OnboradingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "تخطي",
                style: getBodyStyle(
                  color: AppColors.primary,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              itemCount: onboradingPages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SvgPicture.asset(
                      height: 300,
                      onboradingPages[index].image ?? '',
                    ),
                    Gap(20),
                    Center(
                      child: Text(
                        onboradingPages[index].title ?? '',
                        style: getTitleStyle(
                          color: AppColors.secondary,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(20),
                    Center(
                      child: Text(
                        onboradingPages[index].description ?? '',
                        style: getBodyStyle(
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
