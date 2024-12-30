// Created by Tayyab Mughal on 17/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/main_home_screens/main_home_screen.dart';
import 'package:planify/screens/notification_screens/notification_screen.dart';
import 'package:planify/screens/setting_screens/setting_export.dart';
import 'package:planify/screens/subscription_screens/subscription_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  late SettingProvider settingProvider;

  String firstName =
      LocalAppDatabase.getString(Strings.loginFirstName) ?? "Jon";
  String lastName = LocalAppDatabase.getString(Strings.loginLastName) ?? "Doe";
  String userChannelType =
      LocalAppDatabase.getString(Strings.userChannelType) ?? "Null";

  var email = LocalAppDatabase.getString(Strings.loginEmail) ?? "";
  var token = LocalAppDatabase.getString(Strings.loginUserToken) ?? "";

  final listOfCurrency = ["\$ USD", "€ EURO"];
  var selectCurrency = "\$ USD";

  @override
  void initState() {
    super.initState();

    settingProvider = SettingProvider();
    settingProvider = Provider.of<SettingProvider>(context, listen: false);
    settingProvider.init(context: context);
    debugPrint("settingProvidertripspsp ${settingProvider.isAvailable}");
    // If user is login-in
    email != "" && token != "" ? settingProvider.checkAvailableTrip() : null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SettingProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainWhiteBg,
        elevation: 0,
        foregroundColor: AppColors.mainBlack100,
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.mainWhiteBg,
          child: ListView(
            children: [
              CommonPadding.sizeBoxWithHeight(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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

                  /// Earn $ with us
                  GestureDetector(
                    onTap: () async {
                      await openServiceUrl(
                        serviceUrl: "https://planifyholiday.tolt.io/",
                      );
                    },
                    child: Container(
                      height: sizes!.heightRatio * 50,
                      width: sizes!.widthRatio * 160,
                      decoration: BoxDecoration(
                        color: AppColors.mainWhite,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 3,
                          color: AppColors.mainBlack100,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.mainBlack100,
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: Offset(-2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/json/money_bag.json",
                            // height: sizes!.heightRatio * 30,
                            // width: sizes!.widthRatio * 30,
                          ),
                          const GetGenericText(
                            text: "Earn \$ with us",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mainBlack100,
                            lines: 1,
                          ),
                          CommonPadding.sizeBoxWithWidth(width: 6),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              CommonPadding.sizeBoxWithHeight(height: 16),
              GetGenericText(
                text: "$firstName $lastName",
                fontFamily: Assets.basement,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.mainBlack100,
                lines: 1,
              ).getAlign(),
              CommonPadding.sizeBoxWithHeight(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SubscriptionScreen(),
                    ),
                  ).then((value) {
                    settingProvider.checkAvailableTrip();
                  });
                },
                child: Container(
                  height: sizes!.heightRatio * 64,
                  width: sizes!.widthRatio * 362,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.subscriptionGradientColorOne,
                          AppColors.subscriptionGradientColorTwo,
                          AppColors.subscriptionGradientColorThree,
                        ]),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 3,
                      color: AppColors.mainBlack100,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.mainBlack100,
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: Offset(-4, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      settingProvider.isTripAvailable == 2
                          ? Text(
                              "${settingProvider.isAvailable > 5 ? "Unlimited" : settingProvider.isAvailable} Trips left -",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: Assets.aileron,
                                fontSize: sizes!.fontRatio * 16,
                                color: AppColors.mainPureWhite,
                              ),
                            )
                          : settingProvider.isTripAvailable == 1
                              ? Text(
                                  "${settingProvider.isAvailable} Trips left -",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: Assets.aileron,
                                    fontSize: sizes!.fontRatio * 16,
                                    color: AppColors.mainPureWhite,
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                    height: sizes!.heightRatio * 10,
                                    width: sizes!.widthRatio * 10,
                                    child: const CircularProgressIndicator(
                                      color: AppColors.mainWhite100,
                                    ),
                                  ),
                                ),
                      CommonPadding.sizeBoxWithWidth(width: 8),
                      Text(
                        "Get More Dream Trips",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: Assets.aileron,
                          fontSize: sizes!.fontRatio * 16,
                          color: AppColors.mainPureWhite,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CommonPadding.sizeBoxWithHeight(height: 24),
              Container(
                height: sizes!.heightRatio * 64,
                width: sizes!.widthRatio * 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: AppColors.gray5Color,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const GetGenericText(
                      text: "Linked Account",
                      fontFamily: Assets.aileron,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainBlack100,
                      lines: 1,
                    ),
                    GetGenericText(
                      text: userChannelType.toUpperCase(),
                      fontFamily: Assets.aileron,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainBlack100,
                      lines: 1,
                    ),
                  ],
                ).get16HorizontalPadding(),
              ),
              CommonPadding.sizeBoxWithHeight(height: 24),

              getSettingRow(
                icon: "assets/svg/support_icon.svg",
                title: "Give Feedback", //"Support",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SupportScreen(),
                    ),
                  );
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainWhiteDivider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              getSettingRow(
                icon: "assets/svg/notify_icon.svg",
                title: "Notifications",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainWhiteDivider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              getSettingRow(
                icon: "assets/svg/setting_icon.svg",
                title: "Profile Settings",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalInformationScreen(),
                    ),
                  );
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainWhiteDivider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              getSettingRow(
                icon: "assets/svg/wallet_icon.svg",
                title: "Billing",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BillingScreen(),
                    ),
                  );
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainWhiteDivider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              getSettingRow(
                icon: "assets/svg/currency_icon.svg",
                title: "Currency Settings",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CurrencySettingScreen(),
                    ),
                  );
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainWhiteDivider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              getSettingRow(
                icon: "assets/svg/about_icon.svg",
                title: "About",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              // const Divider(
              //   color: AppColors.mainWhiteDivider,
              //   thickness: 1,
              // ),
              // CommonPadding.sizeBoxWithHeight(height: 10),
              // getSettingRow(
              //   icon: "assets/svg/language_icon.svg",
              //   title: "Language",
              //   onPress: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const LanguageScreen(),
              //       ),
              //     );
              //   },
              // ),
              // CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainWhiteDivider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              getSettingRow(
                icon: "assets/svg/faq_icon.svg",
                title: "FAQ",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FaqScreen(),
                    ),
                  );
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainWhiteDivider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              getSettingRow(
                icon: "assets/svg/delete_user.svg",
                title: "Delete Account",
                onPress: () {
                  /// Delete account Alert
                  _showDeleteAccountAlert(context: context);
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainWhiteDivider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              getSettingRow(
                icon: "assets/svg/logout_icon.svg",
                title: "Logout",
                onPress: () {
                  /// Logout Alert
                  _showLogoutAlert(context: context);
                },
              ),
              CommonPadding.sizeBoxWithHeight(height: 20),
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  /// Get Setting Row
  Widget getSettingRow({
    required String title,
    required String icon,
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                icon,
                height: sizes!.heightRatio * 24,
                width: sizes!.widthRatio * 24,
              ),
              CommonPadding.sizeBoxWithWidth(width: 8),
              GetGenericText(
                  text: title,
                  fontFamily: Assets.aileron,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainBlack100,
                  lines: 1),
              const Spacer(),
              SvgPicture.asset(
                "assets/svg/arrow_forward_icon.svg",
                height: sizes!.heightRatio * 24,
                width: sizes!.widthRatio * 24,
              ),
            ],
          ),
        ),
      );

  /// Show Logout Alert
  Future<void> _showLogoutAlert({
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
                    height: sizes!.heightRatio * 180,
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
                          // Close Icon
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

                          const GetGenericText(
                              text: "Are you sure you want to log out?",
                              fontFamily: Assets.aileron,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainBlack100,
                              lines: 2),
                          CommonPadding.sizeBoxWithHeight(height: 24),
                          // Gradient Get Start PopUp Button

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SimpleWhiteHalfPopUpButton(
                                onPress: () => Navigator.pop(context),
                                title: 'No',
                              ),
                              GradientGetStartHalfPopUpButton(
                                title: 'Logout',
                                onPress: () async {
                                  /// Logout
                                  await settingProvider.userLogout(
                                    context: context,
                                  );

                                  if (settingProvider.isLogoutSuccess) {
                                    /// Delete Local Caches
                                    await LocalAppDatabase.clearPreferences();

                                    /// Navigate to Main-Home-Screen
                                    if (context.mounted) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainHomeScreen(),
                                          ),
                                          (route) => false);
                                    }
                                  }
                                },
                              ),
                            ],
                          ).get16HorizontalPadding(),
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

  /// Show Logout Alert
  Future<void> _showDeleteAccountAlert({
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
                    // height: sizes!.heightRatio * 180,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Close Icon
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

                          const GetGenericText(
                            text:
                                "Are you sure you want to delete your account?",
                            fontFamily: Assets.aileron,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainBlack100,
                            lines: 4,
                            textAlign: TextAlign.center,
                          ),
                          CommonPadding.sizeBoxWithHeight(height: 10),

                          const GetGenericText(
                            text:
                                "All your data will be deleted (Trips included).",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainBlack100,
                            lines: 4,
                            textAlign: TextAlign.center,
                          ),

                          CommonPadding.sizeBoxWithHeight(height: 24),
                          // Gradient Get Start PopUp Button

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SimpleWhiteHalfPopUpButton(
                                onPress: () => Navigator.pop(context),
                                title: 'No',
                              ),
                              GradientGetStartHalfPopUpButton(
                                title: 'Delete',
                                onPress: () async {
                                  /// Delete Account
                                  await settingProvider.userDeleteAccount(
                                    context: context,
                                  );
                                  if (settingProvider.isAccountDelete) {
                                    /// Delete Local Caches
                                    await LocalAppDatabase.clearPreferences();

                                    /// Navigate to Main-Home-Screen
                                    if (context.mounted) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainHomeScreen(),
                                          ),
                                          (route) => false);
                                    }
                                  }
                                },
                              ),
                            ],
                          ).get16HorizontalPadding(),
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

  // Show Gift Sharing Box
  // Future<void> _showGiftBox({
  //   required BuildContext context,
  // }) async {
  //   // show the dialog
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Material(
  //                 color: Colors.transparent,
  //                 child: Container(
  //                   width: sizes!.width,
  //                   height: sizes!.heightRatio * 325,
  //                   margin: const EdgeInsets.all(16),
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                     color: AppColors.mainWhite,
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.symmetric(
  //                       vertical: sizes!.heightRatio * 12,
  //                       horizontal: sizes!.widthRatio * 12,
  //                     ),
  //                     child: Column(
  //                       children: [
  //                         // Close Icon
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             GestureDetector(
  //                               onTap: () => Navigator.pop(context),
  //                               child: Container(
  //                                 color: Colors.transparent,
  //                                 child: SvgPicture.asset(
  //                                   "assets/svg/close-pop.svg",
  //                                   height: sizes!.heightRatio * 24,
  //                                   width: sizes!.widthRatio * 24,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         CommonPadding.sizeBoxWithHeight(height: 20),
  //
  //                         const GetGenericText(
  //                           text: "Your Video is Successfully Generated",
  //                           fontFamily: Assets.basement,
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.w800,
  //                           color: AppColors.mainBlack100,
  //                           lines: 3,
  //                           textAlign: TextAlign.center,
  //                         ).get16HorizontalPadding(),
  //
  //                         CommonPadding.sizeBoxWithHeight(height: 12),
  //                         const GetGenericText(
  //                           text: "Share it with your friends 😃",
  //                           fontFamily: Assets.aileron,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w400,
  //                           color: AppColors.mainBlack100,
  //                           lines: 4,
  //                           textAlign: TextAlign.center,
  //                         ).get16HorizontalPadding(),
  //
  //                         CommonPadding.sizeBoxWithHeight(height: 30),
  //
  //                         // Gradient Get Start PopUp Button
  //                         GradientGetStartPopUpButton(
  //                           title: 'Share on Tiktok',
  //                           icon: "assets/png/tiktok_icon.png",
  //                           onPress: () {
  //                             Toasts.getWarningToast(text: "Try it later");
  //                           },
  //                         ),
  //
  //                         CommonPadding.sizeBoxWithHeight(height: 16),
  //
  //                         // Gradient Get Start PopUp Button
  //                         GradientGetStartPopUpButton(
  //                           title: 'Share on Instagram',
  //                           icon: "assets/png/instagram_icon.png",
  //                           onPress: () {
  //                             Toasts.getWarningToast(text: "Try it later");
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  /// Open Service Url
  Future<void> openServiceUrl({required String serviceUrl}) async {
    final Uri url = Uri.parse(serviceUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Toasts.getErrorToast(text: "Could not launch $url");
      throw Exception('Could not launch $url');
    }
  }
}
