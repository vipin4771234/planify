// Created by Tayyab Mughal on 18/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/main_home_screens/main_home_screen.dart';
import 'package:planify/validations/utilities.dart';

class SupportSubmittedScreen extends StatefulWidget {
  const SupportSubmittedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SupportSubmittedScreen> createState() => _SupportSubmittedScreenState();
}

class _SupportSubmittedScreenState extends State<SupportSubmittedScreen> {
  final feedbackController = TextEditingController();
  bool onUserValidationClick = false;

  final appBar = AppBar(
    foregroundColor: AppColors.mainBlack100,
    backgroundColor: AppColors.mainWhiteBg,
    elevation: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetStartFullBlackButton(
        onPress: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainHomeScreen()),
              (route) => false);
        },
        title: "Return to Home",
      ).get16HorizontalPadding(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          color: AppColors.mainWhiteBg,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const GetGenericText(
                    text: "Support",
                    fontFamily: Assets.basement,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.greyScale1000,
                    lines: 2,
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 90),
                  Lottie.asset(
                    'assets/json/thank_you.json',
                    height: sizes!.heightRatio * 250,
                    width: sizes!.widthRatio * 250,
                    fit: BoxFit.cover,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  const GetGenericText(
                    text: "Thank you!\nYour feedback is much appreciated.",
                    fontFamily: Assets.aileron,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainBlack,
                    lines: 2,
                    textAlign: TextAlign.center,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 30),
                  CommonPadding.sizeBoxWithHeight(height: 60),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ),
      ),
    );
  }

  // Email Error Handler
  String? get _emailErrorText {
    final text = feedbackController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (!text.validateEmail()) {
      return "Please enter valid email";
    }
    // return null if the text is valid
    return null;
  }

  /// Text Field Feedback Container [getTextFieldFeedbackWithValidation]
  Widget getTextFieldFeedbackWithValidation({
    required String heading,
    required TextEditingController controller,
    required String hintText,
    @required String? errorText,
    required Function setState,
    required TextInputType textInputType,
    required int maxLines,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GetGenericText(
            text: "Describe your issue",
            fontFamily: Assets.aileron,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.pastelsGreyThreeColor,
            lines: 1,
          ),
          CommonPadding.sizeBoxWithHeight(height: 8),
          TextFormField(
            onChanged: (_) => setState(() {}),
            autocorrect: true,
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
            style: const TextStyle(
              color: AppColors.pastelsGreyFourColor,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.pastelsGreyFourColor,
                fontFamily: Assets.aileron,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.only(
                bottom: sizes!.heightRatio * 15,
                top: sizes!.heightRatio * 15,
                right: sizes!.widthRatio * 10,
                left: sizes!.widthRatio * 10,
              ),
              errorText: errorText,
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.mainBlack100, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.mainBlack100, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.mainBlack100, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.mainBlack100, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      );
}
