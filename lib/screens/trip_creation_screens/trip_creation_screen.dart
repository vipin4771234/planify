// Created by Tayyab Mughal on 23/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';

import 'customize_export.dart';

class TripCreationScreen extends StatefulWidget {
  const TripCreationScreen({Key? key}) : super(key: key);

  @override
  State<TripCreationScreen> createState() => _TripCreationScreenState();
}

class _TripCreationScreenState extends State<TripCreationScreen> {
  bool isSurpriseMe = false;
  bool isCustomize = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.tripCreationGradientLinearOne,
        foregroundColor: AppColors.mainBlack100,
      ),
      body: SafeArea(
        child: Container(
          height: sizes!.height,
          width: sizes!.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.tripCreationGradientLinearOne,
                AppColors.tripCreationGradientLinearTwo,
                // AppColors.gradientBlueLinearTwo
              ],
            ),
          ),
          child: Column(
            children: [
              CommonPadding.sizeBoxWithHeight(height: 40),
              const GetGenericText(
                text: 'Let’s create your dream trip 😍✈️',
                fontFamily: Assets.basement,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppColors.mainBlack100,
                lines: 3,
              ),
              CommonPadding.sizeBoxWithHeight(height: 128),
              _surpriseButton(
                isSelected: isSurpriseMe,
                onPress: () {
                  setState(() {
                    isSurpriseMe = !isSurpriseMe;
                    isCustomize = false;
                  });
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 24),

              /// Customize Button
              _customizeButton(
                onPress: () {
                  setState(() {
                    isSurpriseMe = false;
                    isCustomize = !isCustomize;
                  });
                },
                isSelected: isCustomize,
              ),

              const Spacer(),

              /// Continue Button
              GetStartFullBlackButton(
                title: "Continue",
                onPress: () {
                  if (isCustomize) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TripBudgetScreen()),
                    );
                  } else {
                    Toasts.getWarningToast(text: "Try it later");
                  }
                },
              ),

              CommonPadding.sizeBoxWithHeight(height: 30)
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  /// Surprise Button
  Widget _surpriseButton(
          {required Function onPress, required bool isSelected}) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          height: sizes!.heightRatio * 72,
          width: sizes!.widthRatio * 360,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? AppColors.mainWhite : AppColors.lowBlackColor,
            border: isSelected
                ? Border.all(
                    color: AppColors.mainBlack,
                    width: 3,
                  )
                : null,
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: AppColors.mainBlack100,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(-4, 4), // changes position of shadow
                    ),
                  ]
                : null,
          ),
          child: const Center(
            child: GetGenericText(
              text: "Surprise me 😜",
              fontFamily: Assets.aileron,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.mainBlack,
              lines: 1,
            ),
          ),
        ),
      );

  /// Customize Button
  Widget _customizeButton({
    required Function onPress,
    required bool isSelected,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          height: sizes!.heightRatio * 72,
          width: sizes!.widthRatio * 360,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.mainWhite : AppColors.lowBlackColor,
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(
                    color: AppColors.mainBlack,
                    width: 3,
                  )
                : null,
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: AppColors.mainBlack100,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(-4, 4), // changes position of shadow
                    ),
                  ]
                : null,
          ),
          child: const Center(
            child: GetGenericText(
              text: "I want to customize my trip 😃",
              fontFamily: Assets.aileron,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.mainBlack,
              lines: 1,
            ),
          ),
        ),
      );
}
