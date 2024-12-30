// Created by Tayyab Mughal on 19/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/setting_screens/setting_provider.dart';
import 'package:provider/provider.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  // Provider
  late SettingProvider settingProvider;

  // Controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  bool onUserValidationClick = false;

  ///Local User Data
  String firstName = LocalAppDatabase.getString(Strings.loginFirstName) ?? "";
  String lastName = LocalAppDatabase.getString(Strings.loginLastName) ?? "";

  final appBar = AppBar(
    foregroundColor: AppColors.mainBlack100,
    backgroundColor: AppColors.mainWhiteBg,
    elevation: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    settingProvider = SettingProvider();
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    settingProvider.init(context: context);

    _firstNameController = TextEditingController(text: firstName);
    _lastNameController = TextEditingController(text: lastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingProvider>(context, listen: true);
    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetStartFullBlackButton(
        title: "Confirm Updates",
        onPress: () async => validateInputUserData(),
      ).get16HorizontalPadding(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          color: AppColors.mainWhiteBg,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  CommonPadding.sizeBoxWithHeight(height: 10),
                  const GetGenericText(
                    text: "Personal\nInformation",
                    fontFamily: Assets.basement,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainBlack100,
                    lines: 2,
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 14),
                  Stack(
                    children: [
                      Container(
                        height: sizes!.heightRatio * 140,
                        width: sizes!.widthRatio * 140,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Container(
                        height: sizes!.heightRatio * 135,
                        width: sizes!.widthRatio * 135,
                        decoration: BoxDecoration(
                          color: AppColors.mainWhite100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/png/user_avatar_two.png",
                            height: sizes!.heightRatio * 70,
                            width: sizes!.widthRatio * 70,
                          ),
                        ),
                      ),
                    ],
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  getTextFieldFeedbackWithValidation(
                    heading: "First name",
                    controller: _firstNameController,
                    hintText: "Ex: Jon",
                    errorText:
                        onUserValidationClick ? _firstNameErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.text,
                    maxLines: 1,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  getTextFieldFeedbackWithValidation(
                    heading: "Last name",
                    controller: _lastNameController,
                    hintText: "Ex: Doe",
                    errorText:
                        onUserValidationClick ? _lastNameErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.text,
                    maxLines: 1,
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

  String? get _firstNameErrorText {
    final text = _firstNameController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  } // Email Error Handler

  String? get _lastNameErrorText {
    final text = _lastNameController.value.text.trim().toString();

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

    if (_firstNameErrorText == null && _lastNameErrorText == null) {
      var firstName = _firstNameController.value.text.trim().toString();
      var lastName = _lastNameController.value.text.trim().toString();

      await settingProvider.updateUserProfile(
          firstName: firstName, lastName: lastName, context: context);

      if (settingProvider.isSuccess) {
        if (context.mounted) {
          Navigator.pop(context);
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
          GetGenericText(
            text: heading,
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
