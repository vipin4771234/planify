import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'res.dart';

final currentTimeNow = DateTime.now(); //.subtract(const Duration(minutes: 15));

extension AppSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get blockHeight => height / 100;

  double get blockWidth => width / 100;

  double get textMultiplier => blockHeight;

  double get imageSizeMultiplier => blockWidth;

  double get heightMultiplier => blockHeight;

  double get widthMultiplier => blockWidth;
}

extension GetAppTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
//use : context.width or context.height *0.2
}

extension ConsoleDebugPrint on String {
  consoleMessage() {
    return debugPrint(this);
  }
}

extension AlignExtension on Widget {
  Widget getAlign() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Widget get30HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 30.0),
      child: this,
    );
  }

  Widget get32HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 32.0),
      child: this,
    );
  }

  Widget get35HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 35.0),
      child: this,
    );
  }

  Widget get25HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 25.0),
      child: this,
    );
  }

  Widget get20HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 20.0),
      child: this,
    );
  }

  Widget get16HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 16.0),
      child: this,
    );
  }

  Widget get10HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 10.0),
      child: this,
    );
  }

  Widget get10VerticalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizes!.heightRatio * 10.0),
      child: this,
    );
  }

  Widget get16VerticalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizes!.heightRatio * 16.0),
      child: this,
    );
  }

  Widget get5VerticalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizes!.heightRatio * 5.0),
      child: this,
    );
  }

  Widget get24HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 24.0),
      child: this,
    );
  }

  Widget get15HorizontalPadding() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 15.0),
      child: this,
    );
  }

  Widget getChildCenter() {
    return Center(
      child: this,
    );
  }
}

extension Paddings on Widget {
  SizedBox getPaddingHeight({required double height}) {
    return SizedBox(
      height: sizes!.heightRatio * height,
    );
  }

  SizedBox getPaddingWidth({required double width}) {
    return SizedBox(
      width: sizes!.widthRatio * width,
    );
  }
}

extension StringExtension on String {
  /// Truncate a string if it's longer than [maxLength] and add an [ellipsis].
  String getShortString(int maxLength, [String ellipsis = "…"]) =>
      length > maxLength
          ? '${substring(0, maxLength - ellipsis.length)}$ellipsis'
          : this;

  String getShortStringWithoutDots(int maxLength, [String ellipsis = ""]) =>
      length > maxLength ? substring(0, maxLength - ellipsis.length) : this;

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String getTimeAgoString({required DateTime timeNow}) {
    // currentTimeNow
    return "${timeago.format(timeNow, locale: 'en_short')} ago";
  }
}
