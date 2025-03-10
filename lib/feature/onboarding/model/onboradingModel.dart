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
    title: " ابدأ يومك بحكمة",
    description: "احصل على اقتباس يومي يمنحك الإلهام، مباشرة على هاتفك.",
    image: AppAssets.on1Svg,
  ),
  Onboradingmodel(
    title: "كلمات تغيّر حياتك",
    description:
        "اكتشف أجمل الاقتباسات والحكم الملهمة يوميًا لتبدأ يومك بحكمة وأمل.",
    image: AppAssets.on2Svg,
  ),
  Onboradingmodel(
    title: "جاهز لاكتشاف الكلمات الملهمة؟",
    description: "ابدأ رحلتك في عالم الحكم والاقتباسات واستمتع بجمال الكلمات.",
    image: AppAssets.on2Svg,
  ),
];
