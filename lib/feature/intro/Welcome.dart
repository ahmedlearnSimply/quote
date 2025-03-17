import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote/core/functions/naviagation.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/app_assets.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/core/widgets/custom_button.dart';
import 'package:quote/feature/home/presentation/home.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade Animation
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    // 🌟 Header Section
                    Column(
                      children: [
                        Text(
                          "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                          style: GoogleFonts.amiri(
                            fontSize: 32,
                            color: AppColors.secondary,
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
                        const Gap(20),
                        Text(
                          "مرحبًا بك في رحلتك مع القرآن",
                          style: GoogleFonts.tajawal(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(20),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 30,
                                color: AppColors.secondary.withOpacity(0.3),
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            AppAssets.on1Svg,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                    const Gap(40),

                    // 📝 Name Input Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "ما هو اسمك؟",
                                style: GoogleFonts.tajawal(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " لنُخصص تجربتك مع القرآن",
                                style: GoogleFonts.tajawal(
                                  fontSize: 18,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
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
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "من فضلك ادخل اسمك";
                              }
                              return null;
                            },
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
                              hintText: "ادخل اسمك",
                              hintTextDirection: TextDirection.rtl,
                              hintStyle: GoogleFonts.tajawal(
                                color: Colors.grey,
                                fontSize: 18,
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
                        const Gap(30),

                        // 🚀 Start Button
                        Center(
                          child: CustomButton(
                            width: 200,
                            height: 50,
                            text: "ابدأ الآن",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AppLocalStorage.cacheData(
                                  key: AppLocalStorage.name,
                                  value: _nameController.text,
                                );
                                pushReplacement(context, Home());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
