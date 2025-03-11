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
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // 🔹 Aligns top and bottom sections
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100), // 🔹 Replaces `Positioned` for spacing
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Gap(20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "من فضلك ادخل اسمك";
                    } else {
                      return null;
                    }
                  },
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    fillColor: AppColors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "احمد",
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: getSmallStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.person,
                        color: AppColors.secondary,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        80), // 🔹 Matches the previous `Positioned` bottom spacing
              ],
            ),
          ],
        ),
      ),
    );
  }
}
