// Created by Tayyab Mughal on 22/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/auth_screens/auth_export.dart';
import 'package:planify/screens/auth_screens/forgot_password_screens/forgot_password_provider.dart';
import 'package:planify/validations/utilities.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgotPasswordProvider forgotPasswordProvider;

  // Controller
  final _emailController = TextEditingController();
  bool onUserValidationClick = false;

  bool isLoadingState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    forgotPasswordProvider = ForgotPasswordProvider();
    forgotPasswordProvider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
    forgotPasswordProvider.init(context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ForgotPasswordProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientBlueLinearOne,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
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
                  CommonPadding.sizeBoxWithHeight(height: 40),
                  SvgPicture.asset(
                    "assets/svg/planify_logo.svg",
                    width: sizes!.widthRatio * 300,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 50),
                  const GetGenericText(
                    text: "Forgot password?",
                    fontFamily: Assets.basement,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite,
                    lines: 2,
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 16),
                  const GetGenericText(
                    text:
                        "Enter your email to change your password. If there is an account associated to this email, you will receive and email with password reset instructions.",
                    fontFamily: Assets.aileron,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainWhite,
                    lines: 6,
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 40),
                  _getTextFieldFeedbackWithValidation(
                    heading: "Email",
                    controller: _emailController,
                    hintText: "Jon@exmaple.com",
                    errorText: onUserValidationClick ? _emailErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.emailAddress,
                    maxLines: 1,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  GetStartButtonWithLoader(
                    title: "Reset Password",
                    isLoadingState: isLoadingState,
                    onPress: () {
                      validateInputUserData(context: context);
                    },
                  ),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ),
      ),
    );
  }

  String? get _emailErrorText {
    final text = _emailController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (!text.validateEmail()) {
      return "Invalid email";
    }
    // return null if the text is valid
    return null;
  } // Email Error Handler

  // Validate User Input Data
  void validateInputUserData({required BuildContext context}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    if (_emailErrorText == null) {
      var email = _emailController.value.text.trim().toString();

      setState(() {
        isLoadingState = true;
      });

      await forgotPasswordProvider.forgotPassword(
        email: email,
        context: context,
      );

      if (forgotPasswordProvider.isSuccess) {
        setState(() {
          isLoadingState = false;
        });
        // Navigate Home Screen
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpCodeScreen(userEmail: email),
            ),
          );
        }
      } else {
        setState(() {
          isLoadingState = false;
        });
      }
    }
  }

  /// Text Field Feedback Container [_getTextFieldFeedbackWithValidation]
  Widget _getTextFieldFeedbackWithValidation({
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
