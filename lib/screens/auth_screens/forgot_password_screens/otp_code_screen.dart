// Created by Tayyab Mughal on 22/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/auth_screens/auth_export.dart';
import 'package:planify/screens/auth_screens/forgot_password_screens/forgot_password_provider.dart';
import 'package:provider/provider.dart';

class OtpCodeScreen extends StatefulWidget {
  final String userEmail;

  const OtpCodeScreen({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<OtpCodeScreen> createState() => _OtpCodeScreenState();
}

class _OtpCodeScreenState extends State<OtpCodeScreen> {
  late ForgotPasswordProvider forgotPasswordProvider;

  final _otpCodeController = TextEditingController();
  bool onUserValidationClick = false;

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();

    forgotPasswordProvider = ForgotPasswordProvider();
    forgotPasswordProvider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
    forgotPasswordProvider.init(context: context);
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ForgotPasswordProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientBlueLinearOne,
        // backgroundColor: AppColors.tripGenColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetStartFullBlackButton(
        title: "Verify",
        onPress: () {
          validateInputUserData();
        },
      ).get16HorizontalPadding(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: sizes!.heightRatio * 700,
          width: sizes!.width,
          color: AppColors.gradientBlueLinearOne,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  CommonPadding.sizeBoxWithHeight(height: 30),
                  const GetGenericText(
                    text: "Change your password",
                    fontFamily: Assets.basement,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite,
                    lines: 2,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 14),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: 'Enter the 4 digit code we’ve sent to\n',
                      style: TextStyle(
                        fontFamily: Assets.aileron,
                        fontSize: sizes!.fontRatio * 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainWhite,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.userEmail,
                          style: TextStyle(
                            fontFamily: Assets.aileron,
                            fontSize: sizes!.fontRatio * 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainWhite,
                          ),
                        ),
                      ],
                    ),
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 85),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizes!.widthRatio * 60,
                      ),
                      child: PinCodeTextField(
                        appContext: context,
                        animationType: AnimationType.fade,
                        length: 4,
                        onChanged: (String value) {},
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: sizes!.heightRatio * 48,
                          fieldWidth: sizes!.widthRatio * 48,
                          activeFillColor: AppColors.mainWhite,
                          selectedColor: AppColors.mainWhite,
                          inactiveColor: AppColors.mainWhite,
                        ),
                        cursorColor: AppColors.mainBlack100,
                        animationDuration: const Duration(milliseconds: 300),
                        errorAnimationController: errorController,
                        controller: _otpCodeController,
                        keyboardType: TextInputType.number,
                        textStyle: const TextStyle(
                          color: AppColors.mainWhite,
                        ),
                      ),
                    ),
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 10),
                  RichText(
                    // textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Haven’t received a code? ',
                      style: TextStyle(
                        fontFamily: Assets.aileron,
                        fontSize: sizes!.fontRatio * 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainWhite,
                      ),
                      children: [
                        TextSpan(
                          text: 'Send again',
                          style: TextStyle(
                            fontFamily: Assets.aileron,
                            fontSize: sizes!.fontRatio * 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainWhite,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await forgotPasswordProvider.resendForgotPassword(
                                email: widget.userEmail,
                                context: context,
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  //CommonPadding.sizeBoxWithHeight(height: 200),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ),
      ),
    );
  }

  // Error Handler
  String? get _otpCodeErrorText {
    final text = _otpCodeController.value.text.trim().toString();

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

    if (_otpCodeErrorText == null) {
      var otpCode = _otpCodeController.value.text.trim();
      var num = int.parse(otpCode);
      await forgotPasswordProvider.verifyOTPCode(
          email: widget.userEmail, code: num, context: context);

      if (forgotPasswordProvider.isOTPSuccess) {
        var verificationToken = forgotPasswordProvider
            .verifyOtpCodeResponse.data!.verificationToken
            .toString();
        // Navigate to New Password Screen
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPasswordScreen(
                verificationToken: verificationToken,
              ),
            ),
          );
        }
      }
    }
  }
}
