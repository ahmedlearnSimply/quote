// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/core/widgets/custom_button.dart';
import 'package:quote/feature/onboarding/model/onboradingModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboradingPage extends StatefulWidget {
  const OnboradingPage({super.key});

  @override
  State<OnboradingPage> createState() => _OnboradingPageState();
}

class _OnboradingPageState extends State<OnboradingPage> {
  final PageController _pageController = new PageController();
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          if (pageIndex != 2)
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  AppLocalStorage.cacheData(
                      key: AppLocalStorage.kOnboarding, value: true);
                },
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
                controller: _pageController,
                itemCount: onboradingPages.length,
                onPageChanged: (value) {
                  setState(() {
                    pageIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Spacer(
                        flex: 1,
                      ),
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
                      Spacer(
                        flex: 5,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  SmoothPageIndicator(
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.secondary,
                      dotColor: AppColors.primary,
                      dotWidth: 10,
                      spacing: 5,
                      dotHeight: 10,
                    ),
                    count: onboradingPages.length,
                    controller: _pageController,
                  ),
                  Spacer(),
                  if (pageIndex == 2)
                    CustomButton(
                      width: 100,
                      height: 40,
                      fontsize: 16,
                      text: "هيا بنا",
                      onPressed: () {
                        AppLocalStorage.cacheData(
                            key: AppLocalStorage.kOnboarding, value: true);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
