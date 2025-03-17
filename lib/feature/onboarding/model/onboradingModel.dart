import 'package:quote/core/utils/app_assets.dart';

class Onboradingmodel {
  final String? title;
  final String? description;
  final String? image;

  Onboradingmodel({
    required this.title,
    required this.description,
    required this.image,
  });
}

//* list of onboradingmodel
List<Onboradingmodel> onboradingPages = [
  //* first page
  Onboradingmodel(
    title: " اِقْرَأْ بِاسْمِ رَبِّكَ",
    description: "ابدأ رحلتك مع كلمات الله",
    image: AppAssets.on1Svg,
  ),
  Onboradingmodel(
    title: "تَدَبُّرٌ وَفَهْمٌ",
    description: "تأمل وتفهم المعاني العميقة.",
    image: AppAssets.on2Svg,
  ),
  Onboradingmodel(
    title: "حِفْظٌ وَعَمَلٌ",
    description: "اجعل القرآن منهج حياتك",
    image: AppAssets.on3Svg,
  ),
];
