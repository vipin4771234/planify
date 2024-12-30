// Created by Tayyab Mughal on 23/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/project_widgets/get_textfield_create.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';

class TripBudgetScreen extends StatefulWidget {
  final String? relationship;
  final String? numberOfMembers;

  const TripBudgetScreen({
    Key? key,
    this.relationship,
    this.numberOfMembers,
  }) : super(key: key);

  @override
  State<TripBudgetScreen> createState() => _TripBudgetScreenState();
}

class _TripBudgetScreenState extends State<TripBudgetScreen> {
  //Controller
  final _budgetController = TextEditingController();

  //
  var sliderValue = 0;
  bool isManualBudget = false;
  bool onUserValidationClick = false;
  bool isPerPerson = true;
  bool isPerGroup = false;

  var selectCurrency =
      LocalAppDatabase.getString(Strings.userCurrency)?.toUpperCase() ??
          "\$ USD";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
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
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  CommonPadding.sizeBoxWithHeight(height: 40),
                  const GetGenericText(
                    text: 'Let us know about your budget 💰🤔',
                    fontFamily: Assets.basement,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite,
                    lines: 3,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 50),
                  GetTextFieldCreate(
                    heading: "Enter your budget",
                    controller: _budgetController,
                    hintText: "Ex: 5,000",
                    errorText: onUserValidationClick ? _budgetTextError : null,
                    setState: setState,
                    textInputType: TextInputType.number,
                    maxLines: 1,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 12),
                  GetGenericText(
                    text: "Note: your budget will be in $selectCurrency",
                    fontFamily: Assets.aileron,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AppColors.mainWhite,
                    lines: 2,
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  // SizedBox(
                  //   height: sizes!.height / 2.5,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: AppColors.mainBlack100,
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            return AppColors.mainBlack100;
                          }),
                          value: isPerPerson,
                          onChanged: (value) {
                            setState(() {
                              isPerPerson = value!;
                              isPerGroup = false;
                            });
                          },
                        ),
                      ),
                      const GetGenericText(
                        text: "Per Person",
                        fontFamily: Assets.aileron,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainWhite,
                        lines: 1,
                      ),
                      CommonPadding.sizeBoxWithWidth(width: 50),
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: AppColors.mainBlack100,
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            return AppColors.mainBlack100;
                          }),
                          value: isPerGroup,
                          onChanged: (value) {
                            setState(() {
                              isPerGroup = value!;
                              isPerPerson = false;
                            });
                          },
                        ),
                      ),
                      const GetGenericText(
                        text: "Per Group",
                        fontFamily: Assets.aileron,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainWhite,
                        lines: 1,
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ),
      ),
    );
  }

  // Email Error Handler
  String? get _budgetTextError {
    final text = _budgetController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }

    final parsedValue = double.tryParse(text);
    if (parsedValue == null || parsedValue <= 0) {
      return 'Please enter a budget greater than 0';
    }
    // return null if the text is valid
    return null;
  }

  void validateData() async {
    var selectedOption = "Per Person";
    if (isPerGroup) {
      selectedOption = "Per Group";
    } else {
      selectedOption = "Per Person";
    }

    FocusManager.instance.primaryFocus?.unfocus();
    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    if (_budgetTextError == null) {
      var budget = _budgetController.value.text.trim().toString();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TripMoodScreen(
            relationship: widget.relationship!,
            numberOfMembers: widget.numberOfMembers!,
            budget: budget,
            budgetType: selectedOption,
          ),
        ),
      );
    }
  }
}
