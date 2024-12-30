// Created by Tayyab Mughal on 19/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/auth_screens/auth_export.dart';
import 'package:planify/screens/main_home_screens/main_home_screen.dart';
import 'package:provider/provider.dart';

class AuthPersonalInformationScreen extends StatefulWidget {
  final String userToken;

  const AuthPersonalInformationScreen({
    Key? key,
    required this.userToken,
  }) : super(key: key);

  @override
  State<AuthPersonalInformationScreen> createState() =>
      _AuthPersonalInformationScreenState();
}

class _AuthPersonalInformationScreenState
    extends State<AuthPersonalInformationScreen> {
  //Provider

  late AuthProvider authProvider;

  // Text Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool onUserValidationClick = false;

  bool isLoadingState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Provider Initializing
    authProvider = AuthProvider();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.init(context: context);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientBlueLinearOne,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetStartButtonWithLoader(
        title: "Confirm Updates",
        isLoadingState: isLoadingState,
        onPress: () {
          validateInputUserData();
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => const MainHomeScreen()),
          //     (route) => false);
        },
      ).get16HorizontalPadding(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: sizes!.height,
          width: sizes!.width,
          color: AppColors.gradientBlueLinearOne,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const GetGenericText(
                    text: "Personal\nInformation",
                    fontFamily: Assets.basement,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite,
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

  // First Name Error Text
  String? get _firstNameErrorText {
    final text = _firstNameController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // if (!text.validateUserName()) {
    //   return "Must be text";
    // }
    // return null if the text is valid
    return null;
  } // Email Error Handler

  // Last Name Error
  String? get _lastNameErrorText {
    final text = _lastNameController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }

    // if (!text.validateUserName()) {
    //   return "Must be text";
    // }
    // return null if the text is valid
    return null;
  }

  // Validate User Input Data
  void validateInputUserData() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);
    // _emailErrorText == null &&
    if (_firstNameErrorText == null && _lastNameErrorText == null) {
      var firstName = _firstNameController.value.text.trim().toString();
      var lastName = _lastNameController.value.text.trim().toString();

      setState(() {
        isLoadingState = true;
      });

      // User Profile Update
      await authProvider.userProfileUpdate(
        firstName: firstName,
        lastName: lastName,
        userToken: widget.userToken,
        context: context,
      );

      /// User Register
      if (authProvider.isUserRegistered) {
        setState(() {
          isLoadingState = false;
        });

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainHomeScreen(),
              ),
              (route) => false);
        }
      } else {
        setState(() {
          isLoadingState = false;
        });
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
            color: AppColors.mainWhite,
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
              color: AppColors.mainWhite,
              fontFamily: Assets.aileron,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.mainWhite.withOpacity(0.5),
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
                    const BorderSide(color: AppColors.mainWhite, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.redTwoColor, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.mainWhite, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      );
}
