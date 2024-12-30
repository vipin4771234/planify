// Created by Tayyab Mughal on 24/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';

class TripMoodScreen extends StatefulWidget {
  final String relationship;
  final String numberOfMembers;
  final String budget;
  final String budgetType;

  const TripMoodScreen({
    Key? key,
    required this.relationship,
    required this.numberOfMembers,
    required this.budget,
    required this.budgetType,
  }) : super(key: key);

  @override
  State<TripMoodScreen> createState() => _TripMoodScreenState();
}

class _TripMoodScreenState extends State<TripMoodScreen> {
  // List
  final listOfWith = [
    "💼 Work",
    "🌄 Adventurous",
    "💞 Romantic",
    "😌 Relax",
    "🤠 Common",
    "🌏 Experimental",
    "🤷‍♂️ I don’t care",
  ];

  bool isWork = true;
  bool isAdventurous = false;
  bool isRomantic = false;
  bool isRelax = false;
  bool isCommon = false;
  bool isExperimental = false;
  bool isCare = false;

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
          validateData();
        },
      ).get16HorizontalPadding(),
      body: Container(
        height: sizes!.height,
        width: sizes!.width,
        decoration: const BoxDecoration(
          color: AppColors.accent02,
        ),
        child: SafeArea(
          child: Column(
            children: [
              CommonPadding.sizeBoxWithHeight(height: 30),
              const GetGenericText(
                text: 'Choose your mood for this trip',
                fontFamily: Assets.basement,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppColors.mainWhite,
                lines: 3,
              ),
              CommonPadding.sizeBoxWithHeight(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetChipContainer(
                    title: listOfWith[0],
                    isSelected: isWork,
                    width: 113,
                    onPress: () {
                      setState(() {
                        isWork = !isWork;
                        isAdventurous = false;
                        isRomantic = false;
                        isRelax = false;
                        isCommon = false;
                        isExperimental = false;
                        isCare = false;
                      });
                    },
                  ),
                  CommonPadding.sizeBoxWithWidth(width: 10),
                  GetChipContainer(
                    title: listOfWith[1],
                    isSelected: isAdventurous,
                    width: 178,
                    onPress: () {
                      setState(() {
                        isWork = false;
                        isAdventurous = !isAdventurous;
                        isRomantic = false;
                        isRelax = false;
                        isCommon = false;
                        isExperimental = false;
                        isCare = false;
                      });
                    },
                  ),
                ],
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetChipContainer(
                    title: listOfWith[2],
                    isSelected: isRomantic,
                    width: 148,
                    onPress: () {
                      setState(() {
                        isWork = false;
                        isAdventurous = false;
                        isRomantic = !isRomantic;
                        isRelax = false;
                        isCommon = false;
                        isExperimental = false;
                        isCare = false;
                      });
                    },
                  ),
                  CommonPadding.sizeBoxWithWidth(width: 10),
                  GetChipContainer(
                    title: listOfWith[3],
                    isSelected: isRelax,
                    width: 112,
                    onPress: () {
                      setState(() {
                        isWork = false;
                        isAdventurous = false;
                        isRomantic = false;
                        isRelax = !isRelax;
                        isCommon = false;
                        isExperimental = false;
                        isCare = false;
                      });
                    },
                  ),
                ],
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetChipContainer(
                    title: listOfWith[4],
                    isSelected: isCommon,
                    width: 140,
                    onPress: () {
                      setState(() {
                        isWork = false;
                        isAdventurous = false;
                        isRomantic = false;
                        isRelax = false;
                        isCommon = !isCommon;
                        isExperimental = false;
                        isCare = false;
                      });
                    },
                  ),
                  CommonPadding.sizeBoxWithWidth(width: 10),
                  GetChipContainer(
                    title: listOfWith[5],
                    isSelected: isExperimental,
                    width: 176,
                    onPress: () {
                      setState(() {
                        isWork = false;
                        isAdventurous = false;
                        isRomantic = false;
                        isRelax = false;
                        isCommon = false;
                        isExperimental = !isExperimental;
                        isCare = false;
                      });
                    },
                  ),
                ],
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              GetChipContainer(
                title: listOfWith[6],
                isSelected: isCare,
                width: 161,
                onPress: () {
                  setState(() {
                    isWork = false;
                    isAdventurous = false;
                    isRomantic = false;
                    isRelax = false;
                    isCommon = false;
                    isExperimental = false;
                    isCare = !isCare;
                  });
                },
              ),
              //const Spacer(),

              // CommonPadding.sizeBoxWithHeight(height: 30),
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  void validateData() async {
    var selectedOption = "Work";
    if (isWork) {
      selectedOption = "Work";
    } else if (isAdventurous) {
      selectedOption = "Adventurous";
    } else if (isRomantic) {
      selectedOption = "Romantic";
    } else if (isRelax) {
      selectedOption = "Relax";
    } else if (isCommon) {
      selectedOption = "Common";
    } else if (isExperimental) {
      selectedOption = "Experimental";
    } else if (isCare) {
      selectedOption = "I don't care";
    } else {
      Toasts.getWarningToast(text: "Select any option");
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripDateScreen(
          relationship: widget.relationship,
          numberOfMembers: widget.numberOfMembers,
          budget: widget.budget,
          budgetType: widget.budgetType,
          moodType: selectedOption,
        ),
      ),
    );
  }
}
