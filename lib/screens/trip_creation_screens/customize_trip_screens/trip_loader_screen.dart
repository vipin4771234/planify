// Created by Tayyab Mughal on 25/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/main_home_screens/main_home_screen.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:provider/provider.dart';

class TripLoadScreen extends StatefulWidget {
  final String relationship;
  final String numberOfMembers;
  final String budget;
  final String budgetType;
  final String moodType;
  final String startingDate;
  final String endDate;
  final String numberOfDays;
  final String destinationLocation;
  final String departureLocation;
  final String country;

  const TripLoadScreen(
      {Key? key,
      required this.relationship,
      required this.numberOfMembers,
      required this.budget,
      required this.budgetType,
      required this.moodType,
      required this.startingDate,
      required this.endDate,
      required this.numberOfDays,
      required this.destinationLocation,
      required this.departureLocation,
      required this.country})
      : super(key: key);

  @override
  State<TripLoadScreen> createState() => _TripLoadScreenState();
}

class _TripLoadScreenState extends State<TripLoadScreen> {
  late CustomizeTripProvider customizeTripProvider;

  bool isClick = false;
  bool isFailLoad = false;

  // var status = "Please Wait Your Trip is being generated.";
  // var status =
  //     "Please wait, redirecting to the main screen, you will get notification, when the trip is ready.";

  // var status = "Please wait, It will take 2 to 3 minutes.";
  var status =
      "Your Trip generation is in Progress. We will notify you when it's done.";

  @override
  void initState() {
    super.initState();
    timerLoader();

    customizeTripProvider = CustomizeTripProvider();
    customizeTripProvider =
        Provider.of<CustomizeTripProvider>(context, listen: false);
    customizeTripProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      generateTrip();
    });
  }

  //Generate Trip
  Future<void> generateTrip() async {
    timerLoader();

    await customizeTripProvider.createdNewTrip(
      country: widget.country,
      numberOfDays: widget.numberOfDays,
      budget: widget.budget,
      numberOfMembers: widget.numberOfMembers,
      relationship: widget.relationship,
      budgetType: widget.budgetType,
      mood: widget.moodType,
      fromDate: widget.startingDate,
      toDate: widget.endDate,
      destinationLocation: widget.destinationLocation,
      departureLocation: widget.departureLocation,
      context: context,
    );

    // if (customizeTripProvider.isTripCreated) {
    //   setState(() {
    //     isClick = true;
    //   });
    //
    //   // Context -> Trip Load Screen
    //   if (context.mounted) {
    //     //Next Screen
    //   }
    // } else {
    //   setState(() {
    //     isClick = false;
    //     isFailLoad = true;
    //     // status = customizeTripProvider.errorResponse.data!.message.toString();
    //     status = "Sorry, we are overloaded right now, try again!";
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CustomizeTripProvider>(context, listen: true);

    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.accent02,
            foregroundColor: AppColors.mainBlack100,
            automaticallyImplyLeading: false,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: isFailLoad == true
              ? Visibility(
                  visible: isFailLoad,
                  child: GetStartFullBlackButton(
                    title: "Return Home",
                    onPress: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainHomeScreen()),
                          (route) => false);
                    },
                  ).get16HorizontalPadding(),
                )
              : Visibility(
                  visible: isClick,
                  child: GetStartFullBlackButton(
                    title: "LET'S SEE IT!",
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TripGeneratedItineraryScreen(),
                        ),
                      );
                    },
                  ).get16HorizontalPadding(),
                ),
          body: Container(
            height: sizes!.height,
            width: sizes!.width,
            color: AppColors.accent02,
            child: SafeArea(
              child: Column(
                children: [
                  CommonPadding.sizeBoxWithHeight(height: 30),

                  Lottie.asset(
                    'assets/json/fire_flame.json',
                    //height: sizes!.heightRatio * 48,
                    //width: sizes!.widthRatio * 48,
                    fit: BoxFit.cover,
                  ),

                  // isClick
                  //     ? Lottie.asset(
                  //         'assets/json/confetti_pop.json',
                  //         //height: sizes!.heightRatio * 48,
                  //         //width: sizes!.widthRatio * 48,
                  //         fit: BoxFit.cover,
                  //       )
                  //     : isFailLoad == true
                  //         ? Lottie.asset(
                  //             "assets/json/fail_load.json",
                  //             fit: BoxFit.cover,
                  //           )
                  //         : Lottie.asset(
                  //             'assets/json/fire_flame.json',
                  //             //height: sizes!.heightRatio * 48,
                  //             //width: sizes!.widthRatio * 48,
                  //             fit: BoxFit.cover,
                  //           ),
                  CommonPadding.sizeBoxWithHeight(height: 40),

                  GetGenericText(
                    text: status,
                    fontFamily: Assets.basement,
                    fontSize: isFailLoad == true ? 28 : 28,
                    //34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite100,
                    lines: 4,
                    textAlign: TextAlign.center,
                  ),

                  // isClick
                  //     ? const GetGenericText(
                  //         text: "Trip Successfully Generated.",
                  //         fontFamily: Assets.basement,
                  //         fontSize: 34,
                  //         fontWeight: FontWeight.w800,
                  //         color: AppColors.mainWhite100,
                  //         lines: 3,
                  //         textAlign: TextAlign.center,
                  //       )
                  //     : GetGenericText(
                  //         text: status,
                  //         fontFamily: Assets.basement,
                  //         fontSize: isFailLoad == true ? 28 : 34,
                  //         fontWeight: FontWeight.w800,
                  //         color: AppColors.mainWhite100,
                  //         lines: 4,
                  //         textAlign: TextAlign.center,
                  //       ),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ));
  }

  // Timer Loader
  void timerLoader() {
    Future.delayed(const Duration(seconds: 6), () {
      // setState(() {
      //   isClick = false; //true;
      //   isFailLoad = false;
      // });

      /// Main Home Screen
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainHomeScreen()),
          (route) => false);
    });
  }
}
