import 'package:flutter/material.dart';

class AppColors {
  /// Create Flow
  static const accent02 = Color.fromRGBO(247, 98, 95, 1);
  static const rangePickerColor = Color.fromRGBO(223, 214, 255, .5);

  /// Blue
  static const mainBlue500 = Color.fromRGBO(100, 70, 251, 1);
  static const mainBlue400 = Color.fromRGBO(110, 70, 251, 1);

  static const inActiveStateColor = Color.fromRGBO(53, 53, 53, 1);
  static const activeStateColor = Color.fromRGBO(22, 22, 22, 1);
  static const billingColor = Color.fromRGBO(217, 216, 236, 1);

  /// White Colors
  static const mainWhite = Color.fromRGBO(247, 246, 244, 1);
  static const mainPureWhite = Color.fromRGBO(255, 255, 255, 1);
  static const mainWhite100 = Color.fromRGBO(224, 232, 244, 1);
  static const mainWhiteBg = Color.fromRGBO(249, 249, 249, 1);
  static const mainWhiteDivider = Color.fromRGBO(224, 224, 224, 1);
  static const mainGray4Divider = Color.fromRGBO(189, 189, 189, 1);
  static const mainGray5Divider = Color.fromRGBO(211, 218, 237, 1);
  static const iconColor = Color.fromRGBO(41, 45, 50, 1);
  static const lowBlackColor = Color.fromRGBO(0, 0, 0, 0.1);
  static const lowWhiteColor = Color.fromRGBO(255, 255, 255, 0.75);
  static const bookOnColor = Color.fromRGBO(230, 230, 243, 1);

  static const tripWithColor = Color.fromRGBO(32, 32, 31, 0.1);

  //Old Trip Genereate Color
  static const tripGenColor = Color.fromRGBO(15, 219, 250, 1);
  static const textFieldPlaceholderColor = Color.fromRGBO(178, 158, 247, 1);

  // Text Field Gradient
  static const textFieldGradientColorOne = Color.fromRGBO(110, 70, 251, 1);
  static const textFieldGradientColorTwo = Color.fromRGBO(113, 208, 245, 1);
  static const textFieldGradientColorThree = Color.fromRGBO(245, 176, 19, 1);

  static const greenColor = Color.fromRGBO(128, 211, 74, 1);
  static const greenTwoColor = Color.fromRGBO(15, 186, 83, 1);

  static const gray5Color = Color.fromRGBO(224, 224, 224, 1);
  static const gray3Color = Color.fromRGBO(130, 130, 130, 1);
  static const gray4Color = Color.fromRGBO(189, 189, 189, 1);
  static const gray6Color = Color.fromRGBO(134, 141, 164, 1);
  static const gray7Color = Color.fromRGBO(205, 190, 255, 1);

  static const redOneColor = Color.fromRGBO(255, 216, 216, 1);
  static const redTwoColor = Color.fromRGBO(239, 32, 32, 1);

  static const overlayColor = Color.fromRGBO(29, 27, 37, 0.8);

  /// Get Start Color Gradient
  static const getStartGradientOne = Color.fromRGBO(110, 70, 251, 1);
  static const getStartGradientTwo = Color.fromRGBO(18, 118, 157, 1);
  static const getStartGradientThree = Color.fromRGBO(186, 133, 12, 1);

  static const pastelsGreyColor = Color.fromRGBO(236, 236, 236, 1);
  static const pastelsGreyTwoColor = Color.fromRGBO(79, 79, 79, 1);
  static const pastelsGreyThreeColor = Color.fromRGBO(44, 36, 28, 1);
  static const pastelsGreyEightColor = Color.fromRGBO(43, 43, 43, 1);

  static const pastelsGreyFourColor = Color.fromRGBO(130, 130, 130, 1);
  static const pastelsGreyFiveColor = Color.fromRGBO(51, 51, 51, 1);
  static const pastelsGreySixColor = Color.fromRGBO(87, 85, 92, 1);
  static const pastelsGreySevenColor = Color.fromRGBO(94, 101, 123, 1);

  static const bottomBarUnSelectColor = Color.fromRGBO(126, 126, 126, 1);
  static const savingColor = Color.fromRGBO(233, 255, 225, 1);

  static const subscriptionGradientColorOne = Color.fromRGBO(245, 176, 19, 1);
  static const subscriptionGradientColorTwo = Color.fromRGBO(110, 70, 251, 1);
  static const subscriptionGradientColorThree =
      Color.fromRGBO(113, 205, 245, 1);

  /// Counter Container
  static const counterGradientColorOne = Color.fromRGBO(244, 209, 203, 1);
  static const counterGradientColorTwo = Color.fromRGBO(225, 129, 128, 1);

  /// Black
  static const mainBlack = Color.fromRGBO(0, 0, 0, 1);
  static const mainBlack100 = Color.fromRGBO(32, 27, 48, 1);
  static const mainBlack200 = Color.fromRGBO(30, 27, 57, 1);

  static const accent3 = Color.fromRGBO(174, 65, 95, 1);

  static const primaryBlueColor = Color.fromRGBO(110, 70, 251, 1);
  static const greyScale1000 = Color.fromRGBO(37, 42, 58, 1);
  static const greyScale900 = Color.fromRGBO(51, 51, 51, 1);

  // Blue
  static const gradientBlueLinearOne = Color.fromRGBO(96, 50, 255, 1);
  static const gradientBlueLinearTwo = Color.fromRGBO(255, 255, 255, 1);

  static const tripCreationGradientLinearOne = Color.fromRGBO(245, 236, 19, 1);
  static const tripCreationGradientLinearTwo = Color.fromRGBO(113, 208, 245, 1);

  // Brown
  static const gradientBrownLinearOne = Color.fromRGBO(188, 137, 126, 1);
  static const gradientBrownLinearTwo = Color.fromRGBO(255, 255, 255, 1);
}

class HexColor extends Color {
  HexColor({required final String hexColor})
      : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
