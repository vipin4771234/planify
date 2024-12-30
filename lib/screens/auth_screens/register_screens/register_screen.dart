// Created by Tayyab Mughal on 22/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/network_manager/models.dart';
import 'package:planify/network_manager/new_network_manager.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/auth_screens/auth_export.dart';
import 'package:planify/validations/utilities.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:planify/app_data_models/auth/LoginResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/screens/main_home_screens/main_home_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/push_notification_service/firebase_push_notification_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthProvider authProvider;
  final _logger = Logger();
  // Controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool onUserValidationClick = false;
  bool isLoadingState = false;
  bool isUserAcceptPrivacy = false;
  LoginResponse loginResponse = LoginResponse();
  ErrorResponse errorResponse = ErrorResponse();
  bool isLoadingStateTiktok = false;
  // Password Hidden
  bool _hiddenPassword = true;

  @override
  void initState() {
    super.initState();

    authProvider = AuthProvider();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.init(context: context);

    //Testing Purpose
    NewNetworkManager.instance.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.gradientBlueLinearOne,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      // ),
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
                    text: "Sign up to enjoy the benefits! 🙌",
                    fontFamily: Assets.basement,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite,
                    lines: 2,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 40),
                  _getTextFieldFeedbackWithValidation(
                    heading: "Email",
                    controller: _emailController,
                    hintText: "Jon@exmaple.com",
                    isPassword: false,
                    errorText: onUserValidationClick ? _emailErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.emailAddress,
                    maxLines: 1,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  _getTextFieldPasswordWithValidation(
                    heading: "Password",
                    controller: _passwordController,
                    hintText: "*******",
                    hiddenPassword: _hiddenPassword,
                    errorText:
                        onUserValidationClick ? _passwordErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.text,
                    maxLines: 1,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 30),
                  GetStartButtonWithLoader(
                    title: "Sign Up",
                    isLoadingState: isLoadingState,
                    onPress: () {
                      validateInputUserData();
                    },
                  ),
                  //TODO: Tiktok Login
                  // CommonPadding.sizeBoxWithHeight(height: 20),
                  // _dividerText(),
                  // CommonPadding.sizeBoxWithHeight(height: 20),
                  // _gradientGetStartPopUpButton(
                  //   title: "Continue with Tiktok",
                  //   icon: "assets/png/tiktok_icon.png",
                  //   onPress: () {
                  //     // _showTermsConditionsAlert(context: context);
                  //     //validateInputUserData();
                  //   },
                  // ),
                  CommonPadding.sizeBoxWithHeight(height: 10),
                  GetStartButtonWithLoader(
                      title: "Continue with Tiktok",
                      isLoadingState: isLoadingStateTiktok,
                      onPress: () async {
                        try {
                          setState(() {
                            isLoadingStateTiktok = true;
                          });
                          final result = await TikTokSDK.instance.login(
                            permissions: {
                              TikTokPermissionType.userInfoBasic,
                            },
                          );
                          _logger.i("resultttt: ${result.authCode}");

                          final requestBody = {
                            'client_key': 'aw80fa1woog09gzc',
                            'client_secret': '3f59ee95377b6ff70ad1c3de34a273f6',
                            'code': result.authCode,
                            'grant_type': 'authorization_code',
                            'redirect_uri': 'REDIRECT_URI',
                            // 'code_verifier': 'value2',
                          };
                          _logger.i("resultttt: $requestBody");
                          Map<String, dynamic> header = {
                            "Content-Type": "application/x-www-form-urlencoded",
                            'Cache-Control': 'no-cache',
                          };

                          Response? response =
                              await NewNetworkManager.instance.callPostAPI(
                            url:
                                'https://api.planify.holiday/api/user/tiktokLogin',
                            myHeaders: header,
                            body: requestBody,
                          );
                          // Toasts.getSuccessToast(
                          //     text: 'Backend Authentication Pending');
                          _logger.i("response: $response");

                          ///Response not null
                          if (response != null && response.data != null) {
                            /// Check the status Code
                            if (response.statusCode == 500 ||
                                response.statusCode == 401 ||
                                response.statusCode == 400 ||
                                response.statusCode == 404) {
                              errorResponse = await Models.getModelObject(
                                  Models.errorModel, response.data);
                              _logger.e(
                                  "errorResponse: ${errorResponse.toJson()}");
                              Toasts.getErrorToast(
                                  text: errorResponse.message.toString());
                              // isDataLoaded = false;
                            } else {
                              // Login Response
                              loginResponse = await Models.getModelObject(
                                Models.loginModel,
                                response.data,
                              );

                              if (loginResponse.code == 1) {
                                _logger.i(
                                    "registerResponse: ${loginResponse.toJson()}");
                                var email =
                                    loginResponse.data!.user!.email.toString();

                                /// Initializing Push Notification Service
                                await FirebasePushNotificationService
                                    .initializeNotification(
                                  userTopic: email,
                                );

                                // Toasts.getSuccessToast(text: loginResponse.message.toString());

                                /// Local App Cache
                                await LocalAppDatabase.setLoginResponse(
                                        loginResponse)
                                    .then((_) async {
                                  String firstName = LocalAppDatabase.getString(
                                          Strings.loginFirstName) ??
                                      "";
                                  String lastName = LocalAppDatabase.getString(
                                          Strings.loginLastName) ??
                                      "";
                                  String userChannelType =
                                      LocalAppDatabase.getString(
                                              Strings.userChannelType) ??
                                          "";
                                  String loginEmail =
                                      LocalAppDatabase.getString(
                                              Strings.loginEmail) ??
                                          "";
                                  String savedToken =
                                      LocalAppDatabase.getString(
                                              Strings.loginUserToken) ??
                                          "";
                                  String tripAvailable =
                                      LocalAppDatabase.getString(
                                              Strings.tripAvailable) ??
                                          "";
                                  String userCurrency =
                                      LocalAppDatabase.getString(
                                              Strings.userCurrency) ??
                                          "";

                                  _logger.i(
                                      "firstName: $firstName, lastName: $lastName, userChannelType: $userChannelType, userCurrency: $userCurrency, tripAvailable:$tripAvailable, loginEmail: $loginEmail, savedToken: $savedToken");
                                }).onError((error, stackTrace) {
                                  _logger.e("Save Error: ${error.toString()}");
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainHomeScreen()),
                                    (route) => false);
                                //Checks
                                // isDataLoaded = true;
                              } else {
                                //Checks
                                // isDataLoaded = false;
                                Toasts.getErrorToast(
                                    text: loginResponse.message);
                              }
                            }
                          } else {
                            _logger.e("return Response is: $response");
                          }

                          setState(() {
                            isLoadingStateTiktok = false;
                          });
                        } catch (e) {
                          setState(() {
                            isLoadingStateTiktok = false;
                          });
                          Toasts.getSuccessToast(text: 'Error Occured');
                          _logger.e("onError: ${e.toString()}");
                        }
                      }

                      //   () {
                      //     validateInputUserData(context: context);
                      //     // _showTermsConditionsAlert(context: context);

                      //     // Navigator.pushAndRemoveUntil(
                      //     //     context,
                      //     //     MaterialPageRoute(
                      //     //         builder: (context) => const MainHomeScreen()),
                      //     //     (route) => false);
                      //   },
                      ),

                  CommonPadding.sizeBoxWithHeight(height: 30),

                  RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(
                        color: AppColors.mainWhite,
                        fontSize: sizes!.fontRatio * 16,
                        fontFamily: Assets.aileron,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Login',
                          style: TextStyle(
                            color: AppColors.mainWhite,
                            fontSize: sizes!.fontRatio * 16,
                            fontWeight: FontWeight.w900,
                            fontFamily: Assets.aileron,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                        )
                      ],
                    ),
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 30),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ),
      ),
    );
  }

  // Horizontal Divider
  Widget _dividerText() => Row(
        children: [
          const Expanded(
            child: Divider(
              color: AppColors.gray4Color,
              thickness: 1,
            ),
          ),
          CommonPadding.sizeBoxWithWidth(width: 12),
          const GetGenericText(
            text: "or",
            fontFamily: Assets.aileron,
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: AppColors.mainWhite,
            lines: 1,
          ),
          CommonPadding.sizeBoxWithWidth(width: 12),
          const Expanded(
            child: Divider(
              color: AppColors.gray4Color,
              thickness: 1,
            ),
          ),
        ],
      );

  // Email Error Handler
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
  }

  // Email Error Handler
  String? get _passwordErrorText {
    final text = _passwordController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }

    if (text.length < 8) {
      return "Password length must 8 characters";
    }

    if (!RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)").hasMatch(text)) {
      return "Password must contain alphabets, numbers and special characters";
    }
    // return null if the text is valid
    return null;
  }

  // Validate User Input Data
  void validateInputUserData() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    if (_emailErrorText == null && _passwordErrorText == null) {
      var email = _emailController.value.text.trim().toString();
      var password = _passwordController.value.text.trim().toString();

      _showTermsConditionsAlert(
        email: email,
        password: password,
        context: context,
      );
    }
  }

  /// Register User
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    setState(() {
      isLoadingState = true;
    });

    /// User Register
    await authProvider.userRegister(
      email: email,
      password: password,
      channelType: "Email",
      context: context,
    );
    print({'response': authProvider.isUserRegistered});
    print({'errresponse': authProvider.registerResponse.message});

    /// is User Register
    if (authProvider.isUserRegistered) {
      setState(() {
        isLoadingState = false;
      });
      if (context.mounted) {
        // _showTermsConditionsAlert(context: context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthPersonalInformationScreen(
              userToken: authProvider.registerResponse.data!.accessToken!,
            ),
          ),
        );
      }
    } else {
      setState(() {
        isLoadingState = false;
      });
      Toasts.getErrorToast(
        text: authProvider.registerResponse.message.toString(),
      );
    }
  }

// Appears on when the home screen loaded
  Future<void> _showTermsConditionsAlert({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
// show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: Container(
                    width: sizes!.width,
                    height: sizes!.heightRatio * 380,
                    margin: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.mainWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: sizes!.heightRatio * 12,
                        horizontal: sizes!.widthRatio * 12,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    "assets/svg/close-pop.svg",
                                    height: sizes!.heightRatio * 24,
                                    width: sizes!.widthRatio * 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CommonPadding.sizeBoxWithHeight(height: 20),
                          RichText(
                            text: TextSpan(
                              text:
                                  'By entering the app I acknowledge and agree to the',
                              style: TextStyle(
                                fontFamily: Assets.aileron,
                                fontSize: sizes!.fontRatio * 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.mainBlack100,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(
                                    fontFamily: Assets.aileron,
                                    fontSize: sizes!.fontRatio * 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryBlueColor,
                                  ),
                                ),
                                const TextSpan(text: ' \nand'),
                                TextSpan(
                                  text: ' Privacy Policy.',
                                  style: TextStyle(
                                    fontFamily: Assets.aileron,
                                    fontSize: sizes!.fontRatio * 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryBlueColor,
                                  ),
                                ),
                              ],
                            ),
                          ).get16HorizontalPadding(),
                          CommonPadding.sizeBoxWithHeight(height: 24),

                          gradientGetStartPopUpButton(
                            onPress: () async {
                              setState(() {
                                isUserAcceptPrivacy = true;
                              });

                              if (context.mounted) {
                                Navigator.pop(context);
                              }

                              await registerUser(
                                email: email,
                                password: password,
                              );
                            },
                          ),

                          CommonPadding.sizeBoxWithHeight(height: 16),

                          /// Disagree -> Close the popUp
                          _simpleWhitePopUpButton(
                            onPress: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

// Gradient Get Start PopUp Button
  Widget gradientGetStartPopUpButton({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          height: sizes!.heightRatio * 56,
          width: sizes!.widthRatio * 350,
          decoration: BoxDecoration(
            color: AppColors.mainWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.mainBlack,
              width: 3,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.mainBlack100,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(
                  -4,
                  4,
                ), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: GradientText(
              "I Agree",
              style: TextStyle(
                fontSize: sizes!.fontRatio * 18,
                fontWeight: FontWeight.w800,
              ),
              colors: const [
                AppColors.getStartGradientOne,
                AppColors.getStartGradientTwo,
                AppColors.getStartGradientThree,
              ],
            ),
          ),
        ).get16HorizontalPadding(),
      );

// Simple White Button
  Widget _simpleWhitePopUpButton({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          height: sizes!.heightRatio * 54,
          width: sizes!.widthRatio * 330,
          decoration: BoxDecoration(
            color: AppColors.mainPureWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: GetGenericText(
              text: "I Disagree",
              fontFamily: Assets.basement,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.mainBlack100,
              lines: 1,
            ),
          ),
        ).get16HorizontalPadding(),
      );

  /// Text Field Feedback Container [_getTextFieldFeedbackWithValidation]
  Widget _getTextFieldFeedbackWithValidation({
    required String heading,
    required TextEditingController controller,
    required String hintText,
    @required String? errorText,
    required Function setState,
    required TextInputType textInputType,
    required int maxLines,
    required bool isPassword,
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
            obscureText: isPassword,
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

  /// Text Field Feedback Container [_getTextFieldFeedbackWithValidation]
  Widget _getTextFieldPasswordWithValidation({
    required String heading,
    required TextEditingController controller,
    required String hintText,
    @required String? errorText,
    required Function setState,
    required TextInputType textInputType,
    required int maxLines,
    required bool hiddenPassword,
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
  void clickIcon() {
    setState(() {
      _hiddenPassword = !_hiddenPassword;
    });
  }
}
