// Created by Tayyab Mughal on 25/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:provider/provider.dart';

class TripStayScreen extends StatefulWidget {
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

  const TripStayScreen({
    Key? key,
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
    required this.country,
  }) : super(key: key);

  @override
  State<TripStayScreen> createState() => _TripStayScreenState();
}

class _TripStayScreenState extends State<TripStayScreen> {
  late CustomizeTripProvider customizeTripProvider;

  bool isGenerating = true;

  @override
  void initState() {
    // TODO: implement initState

    customizeTripProvider = CustomizeTripProvider();
    customizeTripProvider =
        Provider.of<CustomizeTripProvider>(context, listen: false);
    customizeTripProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CustomizeTripProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.accent02,
        foregroundColor: AppColors.mainBlack100,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          // isGenerating ?
          GetStartFullBlackButton(
        title: "Generate Now!!!",
        onPress: () async {
          // setState(() {
          //   isGenerating = false;
          // });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => TripLoadScreen(
                  relationship: widget.relationship,
                  numberOfMembers: widget.numberOfMembers,
                  budget: widget.budget,
                  budgetType: widget.budgetType,
                  moodType: widget.moodType,
                  startingDate: widget.startingDate,
                  endDate: widget.endDate,
                  numberOfDays: widget.numberOfDays,
                  destinationLocation: widget.destinationLocation,
                  departureLocation: widget.departureLocation,
                  country: widget.country,
                ),
              ),
              ModalRoute.withName("/TripLoader"));

          // await customizeTripProvider.createdNewTrip(
          //   country: widget.country,
          //   numberOfDays: widget.numberOfDays,
          //   budget: widget.budget,
          //   numberOfMembers: widget.numberOfMembers,
          //   relationship: widget.relationship,
          //   budgetType: widget.budgetType,
          //   mood: widget.moodType,
          //   fromDate: widget.startingDate,
          //   toDate: widget.endDate,
          //   destinationLocation: widget.destinationLocation,
          //   departureLocation: widget.departureLocation,
          //   context: context,
          // );
          //
          // if (customizeTripProvider.isTripCreated) {
          //   setState(() {
          //     isGenerating = true;
          //   });
          //   // Context -> Trip Load Screen
          //   if (context.mounted) {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const TripLoadScreen()),
          //     );
          //   }
          // } else {
          //   setState(() {
          //     isGenerating = true;
          //   });
          // }
        },
      ).get16HorizontalPadding(),
      // : const CircularProgressIndicator(
      //     color: AppColors.mainWhite100,
      //   ),
      body: Container(
        height: sizes!.height,
        width: sizes!.width,
        color: AppColors.accent02,
        child: SafeArea(
          child: Column(
            children: [
              CommonPadding.sizeBoxWithHeight(height: 30),
              const GetGenericText(
                text: 'Where would you like to stay?',
                fontFamily: Assets.basement,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppColors.mainWhite100,
                lines: 3,
              ),
              CommonPadding.sizeBoxWithHeight(height: 60),
              Lottie.asset(
                "assets/json/coming_soon.json",
                height: sizes!.heightRatio * 220,
                width: sizes!.widthRatio * 220,
              ),
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }
}
