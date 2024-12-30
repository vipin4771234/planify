// Created by Tayyab Mughal on 24/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';

class TripTransportScreen extends StatefulWidget {
  const TripTransportScreen({Key? key}) : super(key: key);

  @override
  State<TripTransportScreen> createState() => _TripTransportScreenState();
}

class _TripTransportScreenState extends State<TripTransportScreen> {
  bool isPublicTransport = false;
  bool isPrivateTransport = false;
  bool isBoth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.tripGenColor,
        foregroundColor: AppColors.mainBlack100,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetStartFullBlackButton(
          title: "Continue",
          onPress: () {
            if (isPublicTransport || isPrivateTransport || isBoth) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => TripAmenitiesScreen(),
              //   ),
              // );
            } else {
              Toasts.getWarningToast(text: "Select any option");
            }
          }).get16HorizontalPadding().get16VerticalPadding(),
      body: Container(
        height: sizes!.height,
        width: sizes!.width,
        color: AppColors.tripGenColor,
        child: SafeArea(
          child: Column(
            children: [
              CommonPadding.sizeBoxWithHeight(height: 30),
              const GetGenericText(
                text: 'How do you prefer to commute?',
                fontFamily: Assets.basement,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppColors.mainBlack100,
                lines: 3,
              ),
              CommonPadding.sizeBoxWithHeight(height: 60),
              // Public
              _commuteButton(
                  title: "🚌 Public Transport",
                  isSelected: isPublicTransport,
                  onPress: () {
                    setState(() {
                      isPublicTransport = !isPublicTransport;
                      isPrivateTransport = false;
                      isBoth = false;
                    });
                  }),
              CommonPadding.sizeBoxWithHeight(height: 20),
              // Private
              _commuteButton(
                  title: "🚗 Private Transport",
                  isSelected: isPrivateTransport,
                  onPress: () {
                    setState(() {
                      isPrivateTransport = !isPrivateTransport;
                      isPublicTransport = false;
                      isBoth = false;
                    });
                  }),
              CommonPadding.sizeBoxWithHeight(height: 20),
              // Both
              _commuteButton(
                  title: "😀 Both",
                  isSelected: isBoth,
                  onPress: () {
                    setState(() {
                      isBoth = !isBoth;
                      isPrivateTransport = false;
                      isPublicTransport = false;
                    });
                  }),
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  /// Commute Button
  Widget _commuteButton({
    required String title,
    required bool isSelected,
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          height: sizes!.heightRatio * 52,
          width: sizes!.widthRatio * 360,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.mainWhite : AppColors.tripWithColor,
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(color: AppColors.mainBlack, width: 2)
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
          child: Center(
            child: GetGenericText(
              text: title,
              fontFamily: Assets.aileron,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.mainBlack100,
              lines: 1,
            ),
          ),
        ),
      );
}
