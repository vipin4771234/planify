// Created by Tayyab Mughal on 03/05/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

// Appears on when the home screen loaded
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/auth_screens/auth_export.dart';

import '../screens/trip_creation_screens/customize_export.dart';

class PopUps {
  /// Show Logout Alert
  static Future<void> loginRequiredPopUp({
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
                    height: sizes!.heightRatio * 185,
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
                          // CommonPadding.sizeBoxWithHeight(height: 20),

                          const GetGenericText(
                            text: "Login Required!",
                            fontFamily: Assets.aileron,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainBlack100,
                            lines: 2,
                          ),

                          CommonPadding.sizeBoxWithHeight(height: 8),

                          const GetGenericText(
                            text:
                                "Please login to access all the features of Planify.",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainBlack100,
                            lines: 2,
                            textAlign: TextAlign.center,
                          ),
                          CommonPadding.sizeBoxWithHeight(height: 16),
                          // Gradient Get Start PopUp Button

                          GetStartFullBlackButton(
                            onPress: () async {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            },
                            title: 'Login Now!',
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

  static Future<void> showLoginAlertBox({
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
                    height: sizes!.heightRatio * 200,
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
                          CommonPadding.sizeBoxWithHeight(height: 4),

                          const GetGenericText(
                            text: "Video successfully saved!",
                            fontFamily: Assets.aileron,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainBlack100,
                            lines: 1,
                          ).get20HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 4),
                          const GetGenericText(
                            text:
                                "Click on the button below to create your own trip 😃",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainBlack100,
                            lines: 2,
                            textAlign: TextAlign.center,
                          ).get20HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 20),
                          GetStartFullBlackButton(
                            title: "Create Now!!!",
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TripWithScreen(),
                                ),
                              ).then((value) => Navigator.pop(context));
                            },
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
}
