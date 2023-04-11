import 'dart:ui';

import 'package:flutter/material.dart';

class ColorConstants {
  static const themeColor = Colors.blue;
  static const whiteColor = Colors.white;
  static Map<int, Color> swatchColor = {
    50: themeColor.withOpacity(0.1),
    100: themeColor.withOpacity(0.2),
    200: themeColor.withOpacity(0.3),
    300: themeColor.withOpacity(0.4),
    400: themeColor.withOpacity(0.5),
    500: themeColor.withOpacity(0.6),
    600: themeColor.withOpacity(0.7),
    700: themeColor.withOpacity(0.8),
    800: themeColor.withOpacity(0.9),
    900: themeColor.withOpacity(1),
  };
  static const primaryColor = Color(0xff6f61e8);
  static const bgColor = Color.fromARGB(255, 251, 250, 255);
  static const secondaryColor = Color(0xff2b2250);
  static const greyColor = Color(0xffaeaeae);
  static const greyColor2 = Color(0xffE8E8E8);
  // static const primaryColor = Color(0xff6f61e8);
  // static const bgColor = Color(0xff1f1c38);
  // static const secondaryColor = Color(0xff2b2250);
  // static const greyColor = Color(0xffaeaeae);
  // static const greyColor2 = Color(0xffE8E8E8);
}
