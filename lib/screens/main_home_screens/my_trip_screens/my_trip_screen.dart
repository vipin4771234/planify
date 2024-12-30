// Created by Tayyab Mughal on 17/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/app_animations/slide_right.dart';
import 'package:planify/app_data_models/trips/GetMyTripResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/auth_screens/auth_export.dart';
import 'package:planify/screens/main_home_screens/explore_screens/explore_provider.dart';
import 'package:planify/screens/main_home_screens/my_trip_screens/my_trip_provider.dart';
import 'package:planify/screens/main_home_screens/my_trip_screens/trip_generated_screens/my_trip_generated_itinerary_screen.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:planify/screens/trip_itinerary_detail_screens/trip_itinerary_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:planify/pop_ups/pop_ups.dart';
import 'package:planify/screens/main_home_screens/explore_screens/explore_screen.dart';
import 'package:planify/screens/main_home_screens/main_home_provider.dart';
import 'package:planify/screens/main_home_screens/my_trip_screens/my_trip_screen.dart';
import 'package:planify/screens/subscription_screens/subscription_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MyTripScreen extends StatefulWidget {
  const MyTripScreen({Key? key}) : super(key: key);

  @override
  State<MyTripScreen> createState() => _MyTripScreenState();
}

class _MyTripScreenState extends State<MyTripScreen> {
  final _tripCodeController = TextEditingController();
  late CustomizeTripProvider customizeTripProvider;
  late MyTripProvider myTripProvider;
  late ExploreProvider exploreProvider;

  //User Data
  var username = LocalAppDatabase.getString(Strings.loginFirstName) ?? "";
  var email = LocalAppDatabase.getString(Strings.loginEmail) ?? "";
  var token = LocalAppDatabase.getString(Strings.loginUserToken) ?? "";

  // Is Trip Selected
  bool isTripSelected = true;
  final listOfTrips = ["Created by me", "Saved by me", "Shared with me"];
  var selectTripSort = "Created by me";

  //Placeholder Video
  var placeholderVideo =
      "https://res.cloudinary.com/deqca5vnt/video/upload/eo_27,so_0/v1687245081/_UTF-8_B_UGxhY2Vob2xkZXIgUGxhbmlmeSAtIFNvbmlkby1EaXNwb3Np___UTF-8_B_dGl2b3MgQXBwbGUgSEQgKGNhbGlkYWQgbWHMgXhpbWEpLm00dg___dy43zf.mp4";

  //App Links
  var appleAppShorterLink = "https://apple.co/3CklEaK";
  var googleAppShorterLink = "https://bit.ly/3qwGlh4";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    customizeTripProvider = CustomizeTripProvider();
    customizeTripProvider =
        Provider.of<CustomizeTripProvider>(context, listen: false);
    customizeTripProvider.init(context: context);
    myTripProvider = MyTripProvider();
    myTripProvider = Provider.of<MyTripProvider>(context, listen: false);
    myTripProvider.init(context: context);

    exploreProvider = ExploreProvider();
    exploreProvider = Provider.of<ExploreProvider>(context, listen: false);
    exploreProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      email != "" && token != ""
          ? myTripProvider.getMyTrips(sortType: "created")
          : null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tripCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MyTripProvider>(context, listen: true);
    Provider.of<ExploreProvider>(context, listen: true);

    return Scaffold(
      appBar: MainAppBar.mainAppBar(
        email: email,
        token: token,
        isBadge: exploreProvider.isNewNotificationShowBadge,
        context: context,
      ),
      body: Container(
        color: AppColors.gradientBlueLinearOne,
        child: email != "" && token != ""
            ? Column(
                children: [
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GetGenericText(
                        text: "My Trips 🔥",
                        fontFamily: Assets.basement,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.mainWhite,
                        lines: 1,
                      ),
                      Container(
                        height: sizes!.heightRatio * 32,
                        width: sizes!.widthRatio * 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColors.mainWhite, width: 2),
                        ),
                        child: Center(
                            child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(10),
                          icon: Padding(
                            padding:
                                EdgeInsets.only(right: sizes!.widthRatio * 8),
                            child: SvgPicture.asset(
                              "assets/svg/dropmenu_icon.svg",
                              height: sizes!.heightRatio * 12,
                              width: sizes!.widthRatio * 12,
                            ),
                          ),
                          hint: Padding(
                            padding: EdgeInsets.only(
                              left: sizes!.widthRatio * 8,
                            ),
                            child: GetGenericText(
                              text: selectTripSort,
                              fontFamily: Assets.aileron,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainWhite,
                              lines: 1,
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: Assets.aileron,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainBlack100,
                          ),
                          underline: const SizedBox(),
                          isExpanded: true,
                          items: listOfTrips.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: GetGenericText(
                                text: value,
                                fontFamily: Assets.aileron,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainBlack100,
                                lines: 1,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            setState(() {
                              selectTripSort = value!;
                              myTripProvider.selectDropdownOption(
                                selectTripSort: selectTripSort,
                              );
                            });
                          },
                        )),
                      ),
                    ],
                  ),

                  CommonPadding.sizeBoxWithHeight(height: 20),
                  _getTextFieldFeedbackWithValidation(
                    heading: "Enter Trip Code to collaborate on Shared Trips",
                    controller: _tripCodeController,
                    hintText: "Ex: AHD72",
                    // errorText: onUserValidationClick ? _emailErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.emailAddress,
                    maxLines: 1,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),

                  /// Trip List Builder
                  myTripProvider.isTripLoading == 2
                      ? Expanded(
                          child: LiquidPullToRefresh(
                              height: 50,
                              showChildOpacityTransition: false,
                              springAnimationDurationInMilliseconds: 100,
                              color: AppColors.mainBlue500,
                              onRefresh: _handleRefresh,
                              child: myTripProvider
                                      .getMyTripResponse.data!.trips!.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: myTripProvider
                                              .getMyTripResponse
                                              .data
                                              ?.trips
                                              ?.length ??
                                          1,
                                      itemBuilder: (context, index) {
                                        var data = myTripProvider
                                            .getMyTripResponse
                                            .data!
                                            .trips![index];
                                        var tripId = data.id!;
                                        var userName =
                                            "${data.owner?.firstName ?? "Test"} ${data.owner?.lastName ?? "One"}";
                                        var location = data.destination!;
                                        var createdAtAgo = DateTime.parse(
                                            data.createdAt.toString());

                                        var distance = data.distance.toString();
                                        var savedBy = data.savedBy.toString();
                                        var isSavedBy = data.isSavedByMe!;
                                        var shareCode =
                                            data.shareCode.toString();

                                        //Video
                                        var videoLink = data.video?.link ??
                                            placeholderVideo;
                                        var videoCreditList =
                                            data.video?.creators;

                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: sizes!.heightRatio * 10,
                                          ),
                                          child: GetTripContainer(
                                            key: Key("$index"),
                                            numberOfSaves: savedBy,
                                            isFavouriteTrip: isSavedBy,
                                            createdAtAgo: createdAtAgo,
                                            kiloMeterAway: distance,
                                            videoLink: videoLink,
                                            tripLocation: location,
                                            userName: userName,
                                            onCreditPress: () {
                                              /// Video Credit List is not empty show pop-up
                                              if (videoCreditList!.isNotEmpty) {
                                                _creditListPopUp(
                                                  context: context,
                                                  creators: videoCreditList,
                                                );
                                              } else {
                                                Toasts.getWarningToast(
                                                  text: "No Credit Found",
                                                );
                                              }
                                            },
                                            onFavouritePress: () async {
                                              // mark Trip Favorite
                                              await favoritePress(
                                                tripId: tripId,
                                                isUserLike: isSavedBy,
                                              );
                                            },
                                            onSharePress: () async {
                                              debugPrint(
                                                  "shareCode: $shareCode");
                                              await Share.share(
                                                "${username.toUpperCase()} has shared with you their DREAM TRIP. Please add this code: $shareCode on My Trips tab or click the link below. \n\n iOS App Link: \n $appleAppShorterLink \n\n Android App Link: \n $googleAppShorterLink",
                                              );
                                            },
                                            onTripPress: () {
                                              if (selectTripSort ==
                                                  "Created by me") {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyTripGeneratedItineraryScreen(
                                                      tripId: tripId,
                                                      tripVideoTitle: location,
                                                      videoLink: videoLink,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TripItineraryDetailScreen(
                                                      isMyTrips: true,
                                                      userName: userName,
                                                      tripId: tripId,
                                                      videoLink: videoLink,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  : ListView(
                                      children: const [
                                        Center(
                                          child: GetGenericText(
                                            text: "No Trips!",
                                            fontFamily: Assets.aileron,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.mainWhite,
                                            lines: 2,
                                          ),
                                        ),
                                      ],
                                    )),
                        )
                      : myTripProvider.isTripLoading == 1
                          ? Center(
                              child: GetGenericText(
                                text: myTripProvider.errorResponse.data!.message
                                    .toString()
                                    .toString(),
                                fontFamily: Assets.aileron,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.mainWhite,
                                lines: 2,
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            )
                ],
              ).get16HorizontalPadding()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  const GetGenericText(
                    text: "My Trips 🔥",
                    fontFamily: Assets.basement,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite,
                    lines: 1,
                  ),
                  const Spacer(),
                  const GetGenericText(
                    text: "Please login to view the Trips you saved",
                    fontFamily: Assets.basement,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite,
                    lines: 2,
                    textAlign: TextAlign.center,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  GetStartFullBlackButton(
                    title: "Login",
                    onPress: () {
                      Navigator.pushReplacement(
                        context,
                        SlideRightRoute(
                          page: const LoginScreen(),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                ],
              ).get16HorizontalPadding(),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await myTripProvider.getMyTrips(sortType: "created");
  }

  ///Favorite Press
  Future<void> favoritePress({
    required String tripId,
    required bool isUserLike,
  }) async {
    // setState
    setState(() {
      isUserLike = !isUserLike;
      debugPrint("isUserLike: $isUserLike");
    });

    // mark Trip Favorite
    await myTripProvider.markTripFavorite(
      isLike: isUserLike,
      tripId: tripId,
      context: context,
    );

    /// Trip Saved
    if (myTripProvider.isTripSaved) {
      if (context.mounted) {
        /// If user Like the trip
        if (isUserLike == true) {
          _tripSavedPopUp(
            context: context,
          );
        }
      }
    }
  }

  /// TODO: Credit List Pop up
  Future<void> _creditListPopUp({
    required BuildContext context,
    required List<Creators> creators,
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
                        ? sizes!.heightRatio * 400
                        : sizes!.heightRatio * 400,
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
                          // CommonPadding.sizeBoxWithHeight(height: 10),

                          const GetGenericText(
                            text: "Credits",
                            fontFamily: Assets.basement,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 3,
                            textAlign: TextAlign.center,
                          ).getAlign(),

                          Expanded(
                            child: ListView.builder(
                              itemCount: creators.length,
                              itemBuilder: (context, index) {
                                var data = creators[index];
                                var name = data.name.toString();
                                var creatorLink = data.creator.toString();
                                var imageUrl = data.imageUrl.toString();

                                return RichText(
                                  text: TextSpan(
                                    text: '\u2022 Photo by ',
                                    style: TextStyle(
                                      color: AppColors.mainBlack,
                                      fontSize: sizes!.fontRatio * 16,
                                      fontFamily: Assets.aileron,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' $name',
                                        style: TextStyle(
                                          color: AppColors.mainBlue400,
                                          fontSize: sizes!.fontRatio * 16,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: Assets.aileron,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            await exploreProvider
                                                .openServiceUrl(
                                              serviceUrl: creatorLink,
                                            );
                                          },
                                      ),
                                      TextSpan(
                                        text: ' on ',
                                        style: TextStyle(
                                          color: AppColors.mainBlack,
                                          fontSize: sizes!.fontRatio * 16,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: Assets.aileron,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' Unsplash',
                                        style: TextStyle(
                                          color: AppColors.mainBlue400,
                                          fontSize: sizes!.fontRatio * 16,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: Assets.aileron,
                                          // decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            //http://planify.holiday/
                                            await exploreProvider
                                                .openServiceUrl(
                                              serviceUrl:
                                                  "https://unsplash.com/?utm_source=planify.holiday&utm_medium=referral",
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                )
                                    .get5VerticalPadding()
                                    .get10HorizontalPadding();
                              },
                            ),
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

  /// Text Field Feedback Container [_getTextFieldFeedbackWithValidation]
  Widget _getTextFieldFeedbackWithValidation({
    required String heading,
    required TextEditingController controller,
    required String hintText,
    @required String? errorText,
    required Function setState,
    required TextInputType textInputType,
    required int maxLines,
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
            onFieldSubmitted: (value) async {
              debugPrint("onFieldSubmitted: $value");
              await _saveShareTrip();
            },
            autocorrect: true,
            controller: controller,
            keyboardType: textInputType,
            maxLines: maxLines,
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

  // Save Share Trip
  Future<void> _saveShareTrip() async {
    var shareCode = _tripCodeController.value.text.toString().trim();

    if (shareCode.isNotEmpty) {
      await myTripProvider.shareTripSave(shareCode: shareCode);
      if (myTripProvider.isShareTripSaved) {
        // Toasts.getSuccessToast(text: myTripProvider.shareTripResponse.message);
        _tripCodeController.clear();
      } else {
        // Toasts.getSuccessToast(text: myTripProvider.errorResponse.message);
        _tripCodeController.clear();
      }
    } else {
      Toasts.getErrorToast(text: "Field is empty");
    }
  }

  Future<void> _tripSavedPopUp({
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
                            text: "Trip successfully saved!",
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
                              title: "CREATE YOUR DREAM TRIP",
                              onPress: () async {
                                //Check Is User Login

                                if (email != "" && token != "") {
                                  // setState(() {
                                  //   isLoadingState = true;
                                  // });

                                  //Check User's Available Trips
                                  await customizeTripProvider
                                      .checkAvailableTrip(context: context);
                                  if (customizeTripProvider.isAvailable > 0) {
                                    setState(() {
                                      // isLoadingState = false;
                                    });
                                    if (context.mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TripWithScreen()),
                                      ).then((value) => Navigator.pop(context));
                                    }
                                  } else {
                                    // setState(() {
                                    //   isLoadingState = false;
                                    // });

                                    // Showing Premium Screen
                                    if (context.mounted) {
                                      _showPremiumAlert(context: context);
                                    }
                                  }
                                } else {
                                  PopUps.loginRequiredPopUp(context: context);
                                }
                              }).get10HorizontalPadding(),
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
