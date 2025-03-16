import 'package:flutter/material.dart';
import 'package:quote/core/utils/appcolors.dart';

//* get title
TextStyle getTitleStyle(
    {Color? color,
    FontStyle? fontStyle,
    double? fontSize = 18,
    FontWeight? fontWeight = FontWeight.bold}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? AppColors.primary,
    fontWeight: fontWeight,
    fontFamily: 'cairo',
    // fontStyle: fontStyle ?? FontStyle.normal,
  );
}

//* get body style
TextStyle getBodyStyle(
        {Color? color,
        FontStyle? fontStyle,
        // Shadow? shadow,
        double? fontSize = 18,
        FontWeight? fontWeight = FontWeight.w400}) =>
    TextStyle(
      fontSize: fontSize,
      color: color ?? AppColors.black,
      fontWeight: fontWeight,
      fontFamily: 'cairo',
      // fontStyle: fontStyle ?? FontStyle.normal,/
      // shadows: [
      //   shadow ??
      //       Shadow(
      //         color: Colors.black,
      //         blurRadius: 20,
      //         offset: Offset(2, 2),
      //       )
      // ],
    );

//* get small style
TextStyle getSmallStyle(
        {Color? color,
        FontStyle? fontStyle,
        double? fontSize = 12,
        FontWeight? fontWeight = FontWeight.w500}) =>
    TextStyle(
      fontSize: fontSize,
      fontFamily: 'cairo',
      color: color ?? AppColors.black,
      fontWeight: fontWeight,
      // fontStyle: fontStyle ?? FontStyle.normal,
    );
