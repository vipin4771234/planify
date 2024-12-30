// Created by Tayyab Mughal on 26/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GradientGetStartPopUpButton extends StatelessWidget {
  final Function onPress;
  final String icon;
  final String title;

  const GradientGetStartPopUpButton({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress.call(),
      child: Container(
        height: sizes!.heightRatio * 56,
        width: sizes!.widthRatio * 350,
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.mainBlack,
            width: 3,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.mainBlack100,
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(-2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon),
            CommonPadding.sizeBoxWithWidth(width: 10),
            GradientText(
              title,
              style: TextStyle(
                fontSize: sizes!.fontRatio * 16,
                fontWeight: FontWeight.w800,
              ),
              colors: const [
                AppColors.getStartGradientOne,
                AppColors.getStartGradientTwo,
                AppColors.getStartGradientThree,
              ],
            ),
          ],
        ),
      ).get16HorizontalPadding(),
    );
  }
}
