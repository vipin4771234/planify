// Created by Tayyab Mughal on 03/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_data_models/trips/PreviousTripIterationResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/main_home_screens/my_trip_screens/trip_generated_screens/my_trip_generated_provider.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:provider/provider.dart';

class ShowPreviousIterationScreen extends StatefulWidget {
  final String tripId;
  final String iterationId;

  const ShowPreviousIterationScreen({
    Key? key,
    required this.iterationId,
    required this.tripId,
  }) : super(key: key);

  @override
  State<ShowPreviousIterationScreen> createState() =>
      _ShowPreviousIterationScreenState();
}

class _ShowPreviousIterationScreenState
    extends State<ShowPreviousIterationScreen> {
  late CustomizeTripProvider customizeTripProvider;
  late MyTripGeneratedProvider myTripGeneratedProvider;

  bool isOpened = true;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("iterationId: ${widget.iterationId}");

    customizeTripProvider = CustomizeTripProvider();
    customizeTripProvider =
        Provider.of<CustomizeTripProvider>(context, listen: false);
    customizeTripProvider.init(context: context);

    myTripGeneratedProvider = MyTripGeneratedProvider();
    myTripGeneratedProvider =
        Provider.of<MyTripGeneratedProvider>(context, listen: false);
    myTripGeneratedProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load Previous Iteration By ID
      customizeTripProvider.loadPreviousIterationById(
        iterationId: widget.iterationId,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Provider.of<CustomizeTripProvider>(context, listen: true);
    Provider.of<MyTripGeneratedProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainWhiteBg,
        foregroundColor: AppColors.mainBlack100,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            // When there is no data/error it will in center otherwise it will be in start
            mainAxisAlignment: customizeTripProvider.isPreviousLoading == 1 ||
                    customizeTripProvider.isPreviousLoading == 0
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              /// List of FAQ
              customizeTripProvider.isPreviousLoading == 2
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: customizeTripProvider
                            .previousTripIterationResponse
                            .data!
                            .tripItineraries!
                            .length,
                        itemBuilder: (context, index) {
                          //data
                          var data = customizeTripProvider
                              .previousTripIterationResponse
                              .data!
                              .tripItineraries![index];
                          var iterationId = data.id!;
                          var title = data.title.toString();
                          var activities = data.activities!;
                          var day = data.day;

                          return _previousIterationContainer(
                            tripId: widget.tripId,
                            iterationId: iterationId,
                            title: title,
                            activities: activities,
                            iterationNum: "${index + 1} Iteration",
                            index: index,
                            onPress: () {
                              setState(() {
                                isOpened = !isOpened;
                                currentIndex = index;
                              });
                            },
                            isOpened: isOpened,
                            numberOfDays: '$day',
                            //'0${index + 1}',
                            startingDate: "3 Mar 2023",
                            endingDate: '10 Mar 2024',
                          );
                        },
                      ),
                    )
                  : customizeTripProvider.isPreviousLoading == 1
                      ? Center(
                          child: GetGenericText(
                            text: customizeTripProvider
                                    .errorResponse.data?.message ??
                                "",
                            fontFamily: Assets.aileron,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainBlack100,
                            lines: 2,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  // Faq Container
  Widget _previousIterationContainer({
    required String tripId,
    required String iterationId,
    required String title,
    required List<Activities> activities,
    required String iterationNum,
    required String numberOfDays,
    required String startingDate,
    required String endingDate,
    required Function onPress,
    required bool isOpened,
    required int index,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GetGenericText(
                    text: iterationNum,
                    fontFamily: Assets.basement,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainBlack100,
                    lines: 1,
                  ),
                  (index == currentIndex && isOpened == true)
                      ? SvgPicture.asset(
                          "assets/svg/top_arrow_icon.svg",
                          height: sizes!.heightRatio * 24,
                          width: sizes!.widthRatio * 24,
                        )
                      : SvgPicture.asset(
                          "assets/svg/down_arrow_icon.svg",
                          height: sizes!.heightRatio * 24,
                          width: sizes!.widthRatio * 24,
                        ),
                ],
              ),
              Visibility(
                visible: (index == currentIndex && isOpened == true),
                child: CommonPadding.sizeBoxWithHeight(height: 8),
              ),
              Visibility(
                visible: (index == currentIndex && isOpened == true),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizes!.widthRatio * 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Starting Date and Ending Data
                      // Row(
                      //   children: [
                      //     GetGenericText(
                      //       text: startingDate,
                      //       fontFamily: Assets.aileron,
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w700,
                      //       color: AppColors.gray3Color,
                      //       lines: 1,
                      //     ),
                      //     CommonPadding.sizeBoxWithWidth(width: 4),
                      //     Container(
                      //       height: sizes!.heightRatio * 6,
                      //       width: sizes!.widthRatio * 6,
                      //       decoration: const BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: AppColors.gray3Color,
                      //       ),
                      //     ),
                      //     CommonPadding.sizeBoxWithWidth(width: 4),
                      //     GetGenericText(
                      //       text: endingDate,
                      //       fontFamily: Assets.aileron,
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w700,
                      //       color: AppColors.gray3Color,
                      //       lines: 1,
                      //     ),
                      //   ],
                      // ),
                      // CommonPadding.sizeBoxWithHeight(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const GetGenericText(
                                text: "Day",
                                fontFamily: Assets.aileron,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.mainBlack100,
                                lines: 1,
                              ),
                              CommonPadding.sizeBoxWithHeight(height: 4),
                              GetGenericText(
                                text: numberOfDays,
                                fontFamily: Assets.basement,
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryBlueColor,
                                lines: 1,
                              ),
                            ],
                          ),
                          CommonPadding.sizeBoxWithWidth(width: 24),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (var activity in activities)
                                  Column(
                                    children: [
                                      GetGenericText(
                                        text: "${activity.period}:",
                                        fontFamily: Assets.aileron,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.mainBlack100,
                                        lines: 6,
                                        textAlign: TextAlign.start,
                                      ).getAlign(),
                                      CommonPadding.sizeBoxWithHeight(
                                        height: 6,
                                      ),
                                      GetGenericText(
                                        text:
                                            "${activity.title} (estimated cost: ${activity.price} ${activity.currency!.toUpperCase()} per ${activity.per}, commuting time: ${activity.commutingTime})",
                                        //"${activity.title} at price ${activity.price} ${activity.currency!.toUpperCase()}",
                                        fontFamily: Assets.aileron,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.mainBlack100,
                                        lines: 6,
                                        textAlign: TextAlign.start,
                                      ).getAlign(),
                                      CommonPadding.sizeBoxWithHeight(
                                        height: 6,
                                      ),
                                      Linkify(
                                        onOpen: (link) async {
                                          await customizeTripProvider
                                              .openServiceUrl(
                                            serviceUrl: link.url,
                                          );
                                        },
                                        text: activity.url.toString(),
                                        maxLines: 10,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: sizes!.fontRatio * 14,
                                          fontFamily: Assets.aileron,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.mainBlack100,
                                        ),
                                        linkStyle: const TextStyle(
                                          color: AppColors.accent02,
                                        ),
                                        options: const LinkifyOptions(
                                          humanize: true,
                                          removeWww: true,
                                          looseUrl: true,
                                        ),
                                      ).getAlign(),
                                      CommonPadding.sizeBoxWithHeight(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                GradientGetStartHalfPopUpButton(
                                  title: "Reuse",
                                  onPress: () async {
                                    /// Call Reuse Iteration Function
                                    reuseIteration(
                                      tripId: widget.tripId,
                                      iterationId: iterationId,
                                    );
                                    // Toasts.getWarningToast(
                                    //     text: "This feature is in-development");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              const Divider(
                color: AppColors.gray4Color,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
            ],
          ),
        ),
      );

  /// Reuse Iteration
  void reuseIteration({
    required String tripId,
    required String iterationId,
  }) async {
    // Reuse Trip Iteration
    await customizeTripProvider
        .reuseTripIteration(
      tripId: tripId,
      iterationId: iterationId,
      context: context,
    )
        .then((value) {
      myTripGeneratedProvider.getTripInfoById(tripId: tripId);
    });

    // Reuse Iteration
    if (customizeTripProvider.isReuseIteration) {
      if (context.mounted) {
        Toasts.getSuccessToast(text: "Trip Iteration has been updated");
        Navigator.pop(context);
      }
    }
  }
}
