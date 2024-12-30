// Created by Tayyab Mughal on 18/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/setting_screens/support_screens/support_provider.dart';
import 'package:provider/provider.dart';

import 'support_submitted_screens/support_submitted_screen.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late SupportProvider supportProvider;

  // Controller
  final feedbackController = TextEditingController();
  bool onUserValidationClick = false;

  String firstName =
      LocalAppDatabase.getString(Strings.loginFirstName) ?? "Jon";

  final appBar = AppBar(
    foregroundColor: AppColors.mainBlack100,
    backgroundColor: AppColors.mainWhiteBg,
    elevation: 0,
  );

  @override
  void initState() {
    super.initState();

    supportProvider = SupportProvider();
    supportProvider = Provider.of<SupportProvider>(context, listen: false);
    supportProvider.init(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SupportProvider>(context, listen: true);
    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetStartFullBlackButton(
        // Validate Input User Data
        onPress: () async => validateInputUserData(),
        title: "Send Feedback",
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
                    text: "Feedback",
                    fontFamily: Assets.basement,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.greyScale1000,
                    lines: 2,
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 12),
                  GetGenericText(
                    text:
                        "Hello $firstName! We appreciate every single piece of feedback and we love to get our users involved to improve the experience of using Planify.holiday.",
                    fontFamily: Assets.aileron,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.pastelsGreyTwoColor,
                    lines: 4,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 40),
                  Lottie.asset(
                    "assets/json/support_check.json",
                    fit: BoxFit.cover,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 40),
                  getTextFieldFeedbackWithValidation(
                    heading: "Tell us anything",
                    controller: feedbackController,
                    hintText: "Enter your feedback",
                    errorText:
                        onUserValidationClick ? _feedbackErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.text,
                    maxLines: 8,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 90),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ),
      ),
    );
  }

  // Email Error Handler
  String? get _feedbackErrorText {
    final text = feedbackController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  // Validate User Input Data
  void validateInputUserData() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    if (_feedbackErrorText == null) {
      var feedback = feedbackController.value.text.trim().toString();

      // Support Message
      await supportProvider.postSupportMessage(
        message: feedback,
        context: context,
      );

      // Is Support Submitted
      if (supportProvider.isSupportSubmitted) {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SupportSubmittedScreen()),
          );
        }
      }
    }
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
            text: "Tell us anything",
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
            //When Keyboard will appear, text field will move up
            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
            style: const TextStyle(
              color: AppColors.pastelsGreyFourColor,
              fontFamily: Assets.aileron,
              fontSize: 16,
              fontWeight: FontWeight.w400,
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
                    const BorderSide(color: AppColors.redTwoColor, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.mainBlack100, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.redTwoColor, width: 2),
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
