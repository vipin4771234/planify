// Created by Tayyab Mughal on 17/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/pop_ups/pop_ups.dart';
import 'package:planify/screens/user_profile_screens/user_profile_screen.dart';

import '../app_resources/app_resources.dart';
import '../screens/notification_screens/notification_screen.dart';

class MainAppBar {
  // main App Bar
  static AppBar mainAppBar({
    required String email,
    required String token,
    required bool isBadge,
    required BuildContext context,
  }) =>
      AppBar(
        toolbarHeight: sizes!.heightRatio * 50,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.gradientBlueLinearOne,
        elevation: 0,
        title: SvgPicture.asset(
          "assets/svg/planify_logo.svg",
          width: sizes!.widthRatio * 210,
        ),
        titleSpacing: 16,
        centerTitle: false,
        foregroundColor: AppColors.mainWhite,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: sizes!.heightRatio * 6,
              horizontal: sizes!.widthRatio * 16,
            ),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      if (email != "" && token != "") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      } else {
                        PopUps.loginRequiredPopUp(context: context);
                      }
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            color: Colors.transparent,
                            child: SvgPicture.asset(
                              "assets/svg/notification_icon.svg",
                              height: sizes!.heightRatio * 32,
                              width: sizes!.widthRatio * 28,
                            ),
                          ),
                        ),
                        isBadge
                            ? Positioned(
                                right: sizes!.widthRatio * 4,
                                child: Container(
                                  height: sizes!.heightRatio * 10,
                                  width: sizes!.widthRatio * 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    )),
                CommonPadding.sizeBoxWithWidth(width: 12),
                GestureDetector(
                  onTap: () {
                    if (email != "" && token != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserProfileScreen(),
                        ),
                      );
                    } else {
                      PopUps.loginRequiredPopUp(context: context);
                    }
                  },
                  child: Container(
                    height: sizes!.heightRatio * 40,
                    width: sizes!.widthRatio * 40,
                    decoration: BoxDecoration(
                      color: AppColors.mainWhite100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/png/user_avatar.png",
                        height: sizes!.heightRatio * 28,
                        width: sizes!.widthRatio * 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
}
