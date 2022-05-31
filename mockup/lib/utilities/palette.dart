import 'package:flutter/material.dart';

class Palette {
  static const Color lightBlue = Color.fromRGBO(202, 223, 236, 1);
  static const Color medGreen = Color.fromRGBO(75, 136, 138, 1);
  static const Color darkGreen = Color.fromRGBO(1, 73, 70, 1);
  static const Color lightGreen = Color.fromRGBO(155, 186, 187, 1);
  static const Color darkred = Color.fromRGBO(113, 28, 42, 1);
  static const Color darkOffWhite = Color.fromRGBO(214, 214, 214, 1);
  static const Color lightOffWhite = Color.fromRGBO(227, 227, 227, 1);
  static const Color altOffWhite = Color.fromRGBO(247, 247, 249, 1);

  static const MaterialColor matDarkGreen = MaterialColor(
    0x014946, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff80a4a3), //10%
      100: Color(0xff679290), //20%
      200: Color(0xff4d807e), //30%
      300: Color(0xff346d6b), //40%
      400: Color(0xff1a5b59), //50%
      500: Color(0xff014946), //60%
      600: Color(0xff01423f), //70%
      700: Color(0xff013a38), //80%
      800: Color(0xff013331), //90%
      900: Color(0xff012c2a), //100%
    },
  );
}
