// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/core/widgets/custom_button.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Column(
                  children: [
                    Text(
                      "كلمة واحدة قد تغيّر يومك",
                      style: getTitleStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ).copyWith(
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(10),
                    Text(
                      "او حياتك",
                      style: getTitleStyle(
                        fontSize: 50,
                        color: AppColors.secondary,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 30,
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        width: 200,
                        AppAssets.brain,
                      ),
                    ),
                  ],
                ),
                Gap(60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "ما هو اسمك؟",
                            style: getTitleStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "   لنُخصص الاقتباسات لك",
                            style: getTitleStyle(
                              fontSize: 18,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "من فضلك ادخل اسمك";
                          }
                          return null;
                        },
                        controller: name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          fillColor: Colors.white,
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
                    ),
                    Gap(20),
                    Center(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        child: CustomButton(
                          color: AppColors.secondary,
                          width: 160,
                          height: 50,
                          text: "هيا بنا",
                          textColor: Colors.white,
                          fontsize: 22,
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
