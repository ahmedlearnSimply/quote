import 'package:flutter/material.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.fontWeight,
      this.textColor,
      this.width,
      this.height,
      this.color,
      this.fontsize,
      this.radius});
  //* variables
  final FontWeight? fontWeight;
  final Color? textColor;
  final String text;
  final Color? color;
  final double? fontsize;
  final Function() onPressed;
  final double? width;
  final double? radius;
  final double? height;

  //* widget
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color ?? AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 15))),
          onPressed: onPressed,
          child: Text(
            text,
            style: getBodyStyle(
              color: textColor ?? AppColors.white,
              fontSize: fontsize ?? 16,
              fontWeight: fontWeight ?? FontWeight.bold,
            ),
          )),
    );
  }
}
