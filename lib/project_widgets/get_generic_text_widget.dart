// Created by Tayyab Mughal on 03/12/2022.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';

import '../app_resources/app_resources.dart';

class GetGenericText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final int fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final int lines;

  const GetGenericText({
    Key? key,
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.lines,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      maxLines: lines,
      style: TextStyle(
        fontSize: sizes!.fontRatio * fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
