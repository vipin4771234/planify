// Created by Tayyab Mughal on 16/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/pop_ups/pop_ups.dart';
import 'package:planify/project_widgets/get_generic_text_widget.dart';
import 'package:planify/screens/main_home_screens/explore_screens/explore_screen.dart';
import 'package:planify/screens/main_home_screens/main_home_provider.dart';
import 'package:planify/screens/main_home_screens/my_trip_screens/my_trip_screen.dart';
import 'package:planify/screens/subscription_screens/subscription_screen.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'explore_screens/explore_provider.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late CustomizeTripProvider customizeTripProvider;
  late MainHomeProvider mainHomeProvider;
  late ExploreProvider exploreProvider;

  var email = LocalAppDatabase.getString(Strings.loginEmail);
  var token = LocalAppDatabase.getString(Strings.loginUserToken);
  bool isNewBadge = false;

  // int selectedIndex = 0;

  bool isIOS = Platform.isIOS;

  static const List<Widget> _widgetOptions = <Widget>[
    ExploreScreen(),
    MyTripScreen()
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }

  bool isLoadingState = false;

  @override
  void initState() {
    super.initState();

    customizeTripProvider = CustomizeTripProvider();
    customizeTripProvider =
        Provider.of<CustomizeTripProvider>(context, listen: false);
    customizeTripProvider.init(context: context);

    mainHomeProvider = MainHomeProvider();
    mainHomeProvider = Provider.of<MainHomeProvider>(context, listen: false);
    mainHomeProvider.init(context: context);

    exploreProvider = ExploreProvider();
    exploreProvider = Provider.of<ExploreProvider>(context, listen: false);
    //exploreProvider.init(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ExploreProvider>(context, listen: true);
    Provider.of<MainHomeProvider>(context, listen: true);
    Provider.of<ExploreProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: _floatingActionButton(
            isLoadingState: isLoadingState,
            onPress: () async {
              //Check Is User Login

              if (email != "" && token != "") {
                setState(() {
                  isLoadingState = true;
                });

                //Check User's Available Trips
                await customizeTripProvider.checkAvailableTrip(
                    context: context);
                if (customizeTripProvider.isAvailable > 0) {
                  setState(() {
                    isLoadingState = false;
                  });
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TripWithScreen()),
                    );
                  }
                } else {
                  setState(() {
                    isLoadingState = false;
                  });

                  // Showing Premium Screen
                  if (context.mounted) {
                    _showPremiumAlert(context: context);
                  }
                }
              } else {
                PopUps.loginRequiredPopUp(context: context);
              }
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 2, color: AppColors.mainBlack),
            ),
          ),
          child: BottomAppBar(
            height: Platform.isIOS
                ? sizes!.heightRatio * 60
                : sizes!.heightRatio * 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomNavBarButton(
                  title: "Explore",
                  icon: mainHomeProvider.selectedIndex == 0
                      ? "assets/svg/explore_icon.svg"
                      : "assets/svg/unselect_explore_icon.svg",
                  onPress: () {
                    mainHomeProvider.onItemTapped(0);
                  },
                  index: 0,
                ),
                Stack(
                  // alignment: Alignment.rig,
                  children: [
                    _bottomNavBarButton(
                      title: "My Trips",
                      icon: mainHomeProvider.selectedIndex == 1
                          ? "assets/svg/my_trip_icon.svg"
                          : "assets/svg/unselect_my_trip_icon.svg",
                      onPress: () {
                        mainHomeProvider.onItemTapped(1);
                        exploreProvider.isNewBadgeState();
                      },
                      index: 1,
                    ),
                    exploreProvider.isNewNotificationShowBadge
                        ? Positioned(
                            top: sizes!.heightRatio * 10,
                            right: sizes!.widthRatio * 10,
                            // left: sizes!.widthRatio * 4,
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
                ),
              ],
            ).get16HorizontalPadding(),
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(mainHomeProvider.selectedIndex),
      ),
    );
  }

  // Custom Floating Action Button
  Widget _floatingActionButton({
    required bool isLoadingState,
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: sizes!.heightRatio * 50,
              width: sizes!.widthRatio * 55,
              decoration: BoxDecoration(
                color: AppColors.primaryBlueColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.mainBlack,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(
                      -3.33,
                      3.33,
                    ), // changes position of shadow
                  ),
                ],
              ),
              child: isLoadingState == false
                  ? const Center(
                      child: Icon(
                        Icons.add,
                        color: AppColors.mainWhite,
                        size: 32,
                      ),
                    )
                  : SizedBox(
                      height: sizes!.heightRatio * 2,
                      width: sizes!.widthRatio * 2,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainBlack100,
                        ),
                      ),
                    ),
            ),
            CommonPadding.sizeBoxWithHeight(height: 6),
            const GetGenericText(
              text: "Create",
              fontFamily: Assets.aileron,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryBlueColor,
              lines: 1,
            ),
            CommonPadding.sizeBoxWithHeight(height: 6),
          ],
        ),
      );

  // Bottom Nav Bar Button
  Widget _bottomNavBarButton({
    required String title,
    required String icon,
    required Function onPress,
    required int index,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: sizes!.heightRatio * 20,
                width: sizes!.widthRatio * 20,
              ),
              CommonPadding.sizeBoxWithHeight(height: 6),
              GetGenericText(
                text: title,
                fontFamily: Assets.aileron,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: index == mainHomeProvider.selectedIndex
                    ? AppColors.mainBlack100
                    : AppColors.bottomBarUnSelectColor,
                lines: 1,
              ),
            ],
          ),
        ),
      );

  // Appears on when the home screen loaded
  Future<void> _showPremiumAlert({
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
                    height: Platform.isIOS
                        ? sizes!.heightRatio * 350
                        : sizes!.heightRatio * 360,
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
                            text:
                                "You have consumed your Free Available\nTrip.",
                            fontFamily: Assets.basement,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 3,
                            textAlign: TextAlign.center,
                          ).get16HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 12),
                          const GetGenericText(
                            text:
                                "Hint: if you received a GIFT from another user, you might have a surprise in the next screen!",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainBlack100,
                            lines: 4,
                            textAlign: TextAlign.center,
                          ).get16HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 20),
                          // Gradient Get Start PopUp Button

                          _gradientGetStartPopUpButton(
                            onPress: () {
                              /// If user Agree with -> Navigate to Main Home Screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SubscriptionScreen(), //SubscriptionScreen
                                ),
                              ).then((value) => Navigator.pop(context));
                            },
                          ),

                          CommonPadding.sizeBoxWithHeight(height: 16),
                          // Simple White Button
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
  } // Appears on when the home screen loaded

  // Gradient Get Start PopUp Button
  Widget _gradientGetStartPopUpButton({
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
                  -8,
                  8,
                ), // changes position of shadow
              ),
            ],
          ),
          child: Center(
              child: GradientText(
            "Get More Dream Trips",
            style: TextStyle(
              fontSize: sizes!.fontRatio * 18,
              fontWeight: FontWeight.w800,
            ),
            colors: const [
              AppColors.getStartGradientOne,
              AppColors.getStartGradientTwo,
              AppColors.getStartGradientThree,
            ],
          )),
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
              text: "Cancel",
              fontFamily: Assets.basement,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.mainBlack100,
              lines: 1,
            ),
          ),
        ).get16HorizontalPadding(),
      );
}
