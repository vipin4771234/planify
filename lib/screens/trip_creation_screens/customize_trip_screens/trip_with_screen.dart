// Created by Tayyab Mughal on 24/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/get_textfield_create.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';

class TripWithScreen extends StatefulWidget {
  const TripWithScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TripWithScreen> createState() => _TripWithScreenState();
}

class _TripWithScreenState extends State<TripWithScreen> {
  //controller
  final _numberOfMembersController = TextEditingController();
  bool onUserValidationClick = false;

  //Option List
  final listOfWith = [
    "👨‍👩‍👧‍👦 Family",
    "👭 Friends",
    "🧑 ‍❤‍Partner",
    "👻 Unknown",
    "🧍‍ Solo",
  ];

  // Option Selection
  bool isFamily = true;
  bool isFriends = false;
  bool isPartner = false;
  bool isUnknown = false;
  bool isSolo = false;

  bool isHiddenField = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _numberOfMembersController.dispose();
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
          validateData();
        },
      ).get16HorizontalPadding(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: sizes!.height,
          width: sizes!.width,
          decoration: const BoxDecoration(
            color: AppColors.accent02,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  const GetGenericText(
                    text: 'Who is going with you on this trip?',
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
                        isSelected: isFamily,
                        width: 122,
                        onPress: () {
                          setState(() {
                            isSolo = false;
                            isUnknown = false;
                            isPartner = false;
                            isFriends = false;
                            isFamily = !isFamily;
                            isHiddenField = false;
                          });
                        },
                      ),
                      CommonPadding.sizeBoxWithWidth(width: 10),
                      GetChipContainer(
                        title: listOfWith[1],
                        isSelected: isFriends,
                        width: 132,
                        onPress: () {
                          setState(() {
                            isSolo = false;
                            isUnknown = false;
                            isPartner = false;
                            isFriends = !isFriends;
                            isFamily = false;
                            isHiddenField = false;
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
                        isSelected: isPartner,
                        width: 143,
                        onPress: () {
                          setState(() {
                            isSolo = false;
                            isUnknown = false;
                            isPartner = !isPartner;
                            isFriends = false;
                            isFamily = false;
                            isHiddenField = true;
                          });
                        },
                      ),
                      CommonPadding.sizeBoxWithWidth(width: 10),
                      GetChipContainer(
                        title: listOfWith[3],
                        isSelected: isUnknown,
                        width: 148,
                        onPress: () {
                          setState(() {
                            isSolo = false;
                            isUnknown = !isUnknown;
                            isPartner = false;
                            isFriends = false;
                            isFamily = false;
                            isHiddenField = false;
                          });
                        },
                      ),
                    ],
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 10),
                  GetChipContainer(
                    title: listOfWith[4],
                    isSelected: isSolo,
                    width: 98,
                    onPress: () {
                      setState(() {
                        isSolo = !isSolo;
                        isUnknown = false;
                        isPartner = false;
                        isFriends = false;
                        isFamily = false;
                        isHiddenField = true;
                      });
                    },
                  ),
                  Visibility(
                    visible: !isHiddenField,
                    child: CommonPadding.sizeBoxWithHeight(height: 60),
                  ),
                  Visibility(
                    visible: !isHiddenField,
                    child: GetTextFieldCreate(
                      heading: "Number of members",
                      controller: _numberOfMembersController,
                      hintText: "Ex: 4",
                      errorText: onUserValidationClick
                          ? _numberOfMemberErrorText
                          : null,
                      setState: setState,
                      textInputType: TextInputType.number,
                      maxLines: 1,
                    ),
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 120),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ),
      ),
    );
  }

  //  Error Handler
  String? get _numberOfMemberErrorText {
    final text = _numberOfMembersController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }

    final parsedValue = double.tryParse(text);
    if (parsedValue == null || parsedValue <= 0) {
      return 'Please enter a value greater than 0';
    }

    // return null if the text is valid
    return null;
  }

  void validateData() async {
    var selectedOption = "Family";
    if (isSolo) {
      selectedOption = "Solo";
    } else if (isUnknown) {
      selectedOption = "Unknown";
    } else if (isPartner) {
      selectedOption = "Partner";
    } else if (isFriends) {
      selectedOption = "Friends";
    } else if (isFamily) {
      selectedOption = "Family";
    } else {
      Toasts.getWarningToast(text: "Select any option");
    }

    FocusManager.instance.primaryFocus?.unfocus();
    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    debugPrint("isSolo $isSolo, isPartner $isPartner");
    if (isFamily || isFriends || isUnknown) {
      debugPrint("if-condition");
      if (_numberOfMemberErrorText == null) {
        var numberOfMembers =
            _numberOfMembersController.value.text.trim().toString();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripBudgetScreen(
              numberOfMembers: numberOfMembers,
              relationship: selectedOption,
            ),
          ),
        );
      }
    } else {
      debugPrint("else-condition");
      var numOf = isSolo
          ? "1"
          : isPartner
              ? "2"
              : "1";

      debugPrint("numOf: $numOf");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TripBudgetScreen(
            numberOfMembers: numOf,
            relationship: selectedOption,
          ),
        ),
      );
    }
  }
}
