import 'package:flutter/material.dart';

class TextStyles {
  static const textTheme = TextTheme(
    headline1: headline1,
    headline2: headline2,
    headline3: headline3,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,
    bodyText1: body,
    bodyText2: bodyBold,
    caption: caption,
    button: button,
    overline: overline,
  );

  static const headline1 = TextStyle(
    fontSize: 44.0,
    height: 1.27, // 56.0
    fontWeight: FontWeight.w800,
  );

  static const headline2 = TextStyle(
    fontSize: 32.0,
    height: 1.44, // 46.0
    fontWeight: FontWeight.w800,
  );

  static const headline3 = TextStyle(
    fontSize: 26.0,
    height: 1.31, // 34.0
    fontWeight: FontWeight.w800,
    wordSpacing: 0.35,
  );

  static const headline4 = TextStyle(
    fontSize: 20.0,
    height: 1.4, // 28.0
    fontWeight: FontWeight.w700,
  );

  static const headline4ExtraBold = TextStyle(
    fontSize: 20.0,
    height: 1.4, // 28.0
    fontWeight: FontWeight.w800,
  );

  static const headline5 = TextStyle();
  static const headline6 = TextStyle();

  static const navigationBarTitle = TextStyle(
    fontSize: 17.0,
    height: 1.3, // 22.0
    fontWeight: FontWeight.w600,
  );

  static const uppercase = TextStyle(
    fontSize: 14.0,
    height: 1.4, // 20.0
    fontWeight: FontWeight.w700,
  );

  static const body = TextStyle(
    fontSize: 16.0,
    height: 1.5, // 24.0
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  static const textInput = TextStyle(
    fontSize: 16.0,
    height: 1.5, // 24.0
    fontWeight: FontWeight.w400,
  );

  static const bodyBold = TextStyle(
    fontSize: 16.0,
    height: 1.5, // 24.0
    fontWeight: FontWeight.w700,
  ); // body bold

  static const bodyBoldGrey = TextStyle(
    fontSize: 16.0,
    height: 1.5, // 24.0
    fontWeight: FontWeight.w700,
  ); // body bold

  static const bodySemiBold = TextStyle(
    fontSize: 16.0,
    height: 1.5, // 24.0
    fontWeight: FontWeight.w600,
  ); // body bold

  static const caption = TextStyle(
    fontSize: 12.0,
    height: 1.33, // 16.0
    fontWeight: FontWeight.w400,
  );

  static const captionBold = TextStyle(
    fontSize: 12.0,
    height: 1.33, // 16.0
    fontWeight: FontWeight.w700,
  );

  static const captionSemiBold = TextStyle(
    fontSize: 12.0,
    height: 1.33, // 16.0
    fontWeight: FontWeight.w600,
  );

  static const captionSmallSemiBold = TextStyle(
    fontSize: 10.0,
    height: 1.2, // 12.0
    fontWeight: FontWeight.w700,
  );

  static const button = TextStyle(
    fontSize: 16.0,
    height: 1.5, // 24.0
    fontWeight: FontWeight.w700,
  );

  static const smallButton = TextStyle(
    fontSize: 14.0,
    height: 1.43, // 20.0
    fontWeight: FontWeight.w700,
  );

  static const textButton = TextStyle(
    fontSize: 17.0,
    height: 1.0, // 17.0
    fontWeight: FontWeight.w700,
  );

  static const overline = TextStyle(
    fontSize: 14.0,
    height: 1.43, // 20.0
    fontWeight: FontWeight.w700,
  ); // uppercase

  static const label = TextStyle(
    fontSize: 12.0,
    height: 1.33, // 16.0
    fontWeight: FontWeight.w400,
  );

  static const textFieldStyle = TextStyle(
    fontSize: 16.0,
    height: 1.25, // 20.0
    fontWeight: FontWeight.w600,
  );

  static const hint = TextStyle(
    fontSize: 16.0,
    height: 1.25, // 20.0
    fontWeight: FontWeight.w600,
  );
}
