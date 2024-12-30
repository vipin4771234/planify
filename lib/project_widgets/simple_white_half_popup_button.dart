// Created by Tayyab Mughal on 18/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';

import 'get_generic_text_widget.dart';

class SimpleWhiteHalfPopUpButton extends StatelessWidget {
  final String title;
  final Function onPress;

  const SimpleWhiteHalfPopUpButton(
      {Key? key, required this.title, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress.call(),
      child: Container(
        height: sizes!.heightRatio * 52,
        width: sizes!.widthRatio * 125,
        decoration: BoxDecoration(
          color: AppColors.mainPureWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: GetGenericText(
            text: title,
            fontFamily: Assets.basement,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.mainBlack100,
            lines: 1,
          ),
        ),
      ),
    );
  }
}
