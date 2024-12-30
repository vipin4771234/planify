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
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  final String verificationToken;

  const NewPasswordScreen({Key? key, required this.verificationToken})
      : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  late ForgotPasswordProvider forgotPasswordProvider;

  // Controllers
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool onUserValidationClick = false;

  // Password Hidden
  bool _newHiddenPassword = true;
  bool _confirmHiddenPassword = true;

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
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
                    text: "Change Password",
                    fontFamily: Assets.basement,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite,
                    lines: 2,
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 40),
                  getTextFieldPasswordWithValidation(
                    heading: "New Password",
                    controller: _newPasswordController,
                    hintText: "*******",
                    hiddenPassword: _newHiddenPassword,
                    clickIcon: newClickIcon,
                    errorText:
                        onUserValidationClick ? _newPasswordErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.text,
                    maxLines: 1,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  getTextFieldPasswordWithValidation(
                    heading: "Confirm Password",
                    controller: _confirmPasswordController,
                    hintText: "*******",
                    hiddenPassword: _confirmHiddenPassword,
                    clickIcon: confirmClickIcon,
                    errorText: onUserValidationClick
                        ? _confirmPasswordErrorText
                        : null,
                    setState: setState,
                    textInputType: TextInputType.text,
                    maxLines: 1,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  GetStartFullBlackButton(
                    title: "Reset Password",
                    onPress: () {
                      validateInputUserData();
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

// Email Error Handler
  String? get _newPasswordErrorText {
    final text = _newPasswordController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }

    if (text.length < 8) {
      return "Password length must 8 characters";
    }
    // return null if the text is valid
    return null;
  }

  // Email Error Handler
  String? get _confirmPasswordErrorText {
    final text = _confirmPasswordController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }

    if (text.length < 8) {
      return "Password length must 8 characters";
    }
    // return null if the text is valid
    return null;
  }

  // Validate User Input Data
  void validateInputUserData() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    if (_newPasswordErrorText == null && _confirmPasswordErrorText == null) {
      var newPassword = _newPasswordController.value.text.trim().toString();
      var confirmPassword =
          _confirmPasswordController.value.text.trim().toString();

      if (newPassword == confirmPassword) {
        // Add New Password
        await forgotPasswordProvider.addNewPassword(
            password: newPassword,
            verificationToken: widget.verificationToken,
            context: context);
        if (context.mounted) {
          // Navigator Login Screen
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        }
      } else {
        Toasts.getErrorToast(text: "The password is not matched");
      }
    } else {
      Toasts.getErrorToast(text: "The field is required");
    }
  }

  /// Text Field Feedback Container [_getTextFieldFeedbackWithValidation]
  Widget getTextFieldPasswordWithValidation({
    required String heading,
    required TextEditingController controller,
    required String hintText,
    @required String? errorText,
    required Function setState,
    required TextInputType textInputType,
    required int maxLines,
    required bool hiddenPassword,
    required Function clickIcon,
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
            obscureText: hiddenPassword,
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
              suffixIcon: IconButton(
                icon: Icon(
                  hiddenPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.mainWhite100,
                ),
                onPressed: () => clickIcon.call(),
              ),
            ),
          ),
        ],
      );

  // Click Icon
  void newClickIcon() {
    setState(() {
      _newHiddenPassword = !_newHiddenPassword;
    });
  } // Click Icon

  void confirmClickIcon() {
    setState(() {
      _confirmHiddenPassword = !_confirmHiddenPassword;
    });
  }
}
