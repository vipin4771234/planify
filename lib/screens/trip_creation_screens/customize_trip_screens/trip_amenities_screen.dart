// Created by Tayyab Mughal on 25/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';

class TripAmenitiesScreen extends StatefulWidget {
  final String relationship;
  final String numberOfMembers;
  final String budget;
  final String budgetType;
  final String moodType;
  final String startingDate;
  final String endDate;
  final String numberOfDays;
  final String destinationLocation;
  final String departureLocation;
  final String country;

  const TripAmenitiesScreen({
    Key? key,
    required this.relationship,
    required this.numberOfMembers,
    required this.budget,
    required this.budgetType,
    required this.moodType,
    required this.startingDate,
    required this.endDate,
    required this.numberOfDays,
    required this.destinationLocation,
    required this.departureLocation,
    required this.country,
  }) : super(key: key);

  @override
  State<TripAmenitiesScreen> createState() => _TripAmenitiesScreenState();
}

class _TripAmenitiesScreenState extends State<TripAmenitiesScreen> {
  // Text Controller

  final _texController = TextEditingController();
  bool onUserValidationClick = false;

  final listOfWith = [
    "None",
    "🏊 Pool",
    "🚘 Parking",
    "🐕‍🦺 Pets Allowed",
    "🍽️ Dinner",
    "📶 Wi-Fi",
  ];

  bool isNone = false;
  bool isPool = false;
  bool isParking = false;
  bool isPetsAllowed = false;
  bool isDinner = false;
  bool isWifi = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _texController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.accent02,
        foregroundColor: AppColors.mainBlack100,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetStartFullBlackButton(
        title: "Continue",
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripStayScreen(
                relationship: widget.relationship,
                numberOfMembers: widget.numberOfMembers,
                budget: widget.budget,
                budgetType: widget.budgetType,
                moodType: widget.moodType,
                startingDate: widget.startingDate,
                endDate: widget.endDate,
                numberOfDays: widget.numberOfDays,
                destinationLocation: widget.destinationLocation,
                departureLocation: widget.departureLocation,
                country: widget.country,
              ),
            ),
          );
        },
      ).get16HorizontalPadding(),
      body: Container(
        height: sizes!.height,
        width: sizes!.width,
        color: AppColors.accent02,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonPadding.sizeBoxWithHeight(height: 30),
                const GetGenericText(
                  text: 'Choose amenities for your trip.',
                  fontFamily: Assets.basement,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite100,
                  lines: 3,
                ),
                CommonPadding.sizeBoxWithHeight(height: 40),

                Lottie.asset(
                  "assets/json/coming_soon.json",
                  height: sizes!.heightRatio * 220,
                  width: sizes!.widthRatio * 220,
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GetChipContainer(
                //       title: listOfWith[0],
                //       isSelected: isNone,
                //       width: 88,
                //       onPress: () {
                //         setState(() {
                //           isNone = !isNone;
                //           // isPool = false;
                //           // isParking = false;
                //           // isPetsAllowed = false;
                //           // isDinner = false;
                //           // isWifi = false;
                //         });
                //       },
                //     ),
                //     CommonPadding.sizeBoxWithWidth(width: 10),
                //     GetChipContainer(
                //       title: listOfWith[1],
                //       isSelected: isPool,
                //       width: 101,
                //       onPress: () {
                //         setState(() {
                //           // isNone = false;
                //           isPool = !isPool;
                //           // isParking = false;
                //           // isPetsAllowed = false;
                //           // isDinner = false;
                //           // isWifi = false;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                // CommonPadding.sizeBoxWithHeight(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GetChipContainer(
                //       title: listOfWith[2],
                //       isSelected: isParking,
                //       width: 132,
                //       onPress: () {
                //         setState(() {
                //           // isNone = false;
                //           // isPool = false;
                //           isParking = !isParking;
                //           // isPetsAllowed = false;
                //           // isDinner = false;
                //           // isWifi = false;
                //         });
                //       },
                //     ),
                //     CommonPadding.sizeBoxWithWidth(width: 10),
                //     GetChipContainer(
                //       title: listOfWith[3],
                //       isSelected: isPetsAllowed,
                //       width: 177,
                //       onPress: () {
                //         setState(() {
                //           // isNone = false;
                //           // isPool = false;
                //           // isParking = false;
                //           isPetsAllowed = !isPetsAllowed;
                //           // isDinner = false;
                //           // isWifi = false;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                // CommonPadding.sizeBoxWithHeight(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GetChipContainer(
                //       title: listOfWith[4],
                //       isSelected: isDinner,
                //       width: 122,
                //       onPress: () {
                //         setState(() {
                //           // isNone = false;
                //           // isPool = false;
                //           // isParking = false;
                //           // isPetsAllowed = false;
                //           isDinner = !isDinner;
                //           // isWifi = false;
                //         });
                //       },
                //     ),
                //     CommonPadding.sizeBoxWithWidth(width: 10),
                //     GetChipContainer(
                //       title: listOfWith[5],
                //       isSelected: isWifi,
                //       width: 110,
                //       onPress: () {
                //         setState(() {
                //           // isNone = false;
                //           // isPool = false;
                //           // isParking = false;
                //           // isPetsAllowed = false;
                //           // isDinner = false;
                //           isWifi = !isWifi;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                // CommonPadding.sizeBoxWithHeight(height: 30),
                // const GetDividerText(),
                // CommonPadding.sizeBoxWithHeight(height: 20),
                // GetTextFieldFeedbackWithValidation(
                //   heading: "Specify yourself (Optional)",
                //   controller: _texController,
                //   hintText: "Type here...",
                //   errorText: onUserValidationClick ? _emailErrorText : null,
                //   setState: setState,
                //   textInputType: TextInputType.text,
                //   maxLines: 1,
                // ),
                // CommonPadding.sizeBoxWithHeight(height: 100),
                //
                // CommonPadding.sizeBoxWithHeight(height: 30),
              ],
            ).get16HorizontalPadding(),
          ),
        ),
      ),
    );
  }
}
