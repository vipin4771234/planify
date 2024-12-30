// Created by Tayyab Mughal on 18/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GetStartFullBlackButton extends StatelessWidget {
  final String title;
  final Function onPress;

  const GetStartFullBlackButton({
    Key? key,
    required this.title,
    required this.onPress,
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
              offset: Offset(-4, 4), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: GradientText(
          title,
          style: TextStyle(
            fontSize: sizes!.fontRatio * 18,
            fontWeight: FontWeight.w800,
            //fontFamily: "Basement-Bold",
          ),
          colors: const [
            AppColors.getStartGradientOne,
            AppColors.getStartGradientTwo,
            AppColors.getStartGradientThree,
          ],
        )),
      ),
    );
  }
}
