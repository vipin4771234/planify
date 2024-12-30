// Created by Tayyab Mughal on 25/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_data_models/trips/CreateTripResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/main_home_screens/main_home_screen.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class TripGeneratedItineraryScreen extends StatefulWidget {
  const TripGeneratedItineraryScreen({Key? key}) : super(key: key);

  @override
  State<TripGeneratedItineraryScreen> createState() =>
      _TripGeneratedItineraryScreenState();
}

class _TripGeneratedItineraryScreenState
    extends State<TripGeneratedItineraryScreen> {
  //
  String username = LocalAppDatabase.getString(Strings.loginFirstName) ?? "Jon";
  late CustomizeTripProvider customizeTripProvider;

  //
  bool isAddToCalendar = false;
  int currentIndex = -1;
  bool isUserRegeneratingIteration = false;

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // late VideoPlayerController _controllerVideoPlayer;

  // final videoLinkTwo =
  //     "https://myneuropal-pullzone.b-cdn.net/Content%20videos/BlueBox_Mobile_5min_V_500_2022110201.mp4";
  // final testShortVideoLink =
  //     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";

  // Duration getDuration = const Duration(hours: 0, minutes: 0);
  // Duration deceaseVideoTimer = const Duration(minutes: 0, seconds: 0);
  // bool hiddenVideoControllers = false;

  var selectCurrency =
      LocalAppDatabase.getString(Strings.userCurrency)?.toUpperCase() ?? "USD";

  @override
  void initState() {
    // TODO: implement initState

    customizeTripProvider = CustomizeTripProvider();
    customizeTripProvider =
        Provider.of<CustomizeTripProvider>(context, listen: false);
    customizeTripProvider.init(context: context);

    super.initState();

    //videoLinkTwo
    // _controllerVideoPlayer = VideoPlayerController.network(videoLinkTwo)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //     // TODO:
    //     // _controllerVideoPlayer.play();
    //   });

    // Video Position
    // _controllerVideoPlayer.addListener(_videoPosition);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _controllerVideoPlayer.dispose();
    // _controllerVideoPlayer.removeListener(_videoPosition);
  }

  /// Build Event
  Event buildEvent(
      {Recurrence? recurrence,
      required String title,
      required String description,
      required String location,
      required DateTime startDate,
      required DateTime endDate,
      required List<String>? emailInvites,
      Duration? reminder,
      String? url}) {
    return Event(
      title: title,
      description: description,
      location: location,
      startDate: startDate,
      endDate: endDate,
      allDay: false,
      iosParams: IOSParams(
        reminder: reminder,
        url: url,
      ),
      androidParams: AndroidParams(
        emailInvites: emailInvites,
      ),
      recurrence: recurrence,
    );
  }

  // void _videoPosition() async {
  //   if (_controllerVideoPlayer.value.isInitialized) {
  //     setState(() {
  //       getDuration = _controllerVideoPlayer.value.position;
  //       deceaseVideoTimer = _controllerVideoPlayer.value.duration -
  //           _controllerVideoPlayer.value.position;
  //     });
  //     if (_controllerVideoPlayer.value.position ==
  //         _controllerVideoPlayer.value.duration) {
  //       _controllerVideoPlayer.removeListener(_videoPosition);
  //       setState(() {
  //         // showAlertDialog(context: context);
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<CustomizeTripProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.accent02,
        foregroundColor: AppColors.mainBlack100,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(
            top: sizes!.heightRatio * 10,
            bottom: sizes!.heightRatio * 6,
          ),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainHomeScreen(),
                ),
                (route) => false),
            child: Container(
              height: sizes!.heightRatio * 32,
              width: sizes!.widthRatio * 108,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.mainWhite100,
                  width: 2,
                ),
              ),
              child: const Center(
                child: GetGenericText(
                  text: "Return to home",
                  fontFamily: Assets.aileron,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainWhite100,
                  lines: 1,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetStartFullBlackButton(
        title: "Share with friends",
        onPress: () {
          _shareWithFriendsAlertBox(context: context);
        },
      ).get16HorizontalPadding().get16VerticalPadding(),
      body: Container(
        color: AppColors.accent02,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonPadding.sizeBoxWithHeight(height: 10),
                Stack(
                  children: [
                    Container(
                      height: sizes!.heightRatio * 300,
                      width: sizes!.widthRatio * 342,
                      decoration: BoxDecoration(
                        color: AppColors.redOneColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/play_icon.svg',
                            color: AppColors.accent02,
                          ),
                          CommonPadding.sizeBoxWithHeight(height: 16),
                          Stack(
                            children: [
                              Container(
                                height: sizes!.heightRatio * 12,
                                width: sizes!.widthRatio * 280,
                                decoration: BoxDecoration(
                                  color: AppColors.mainWhite,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Container(
                                height: sizes!.heightRatio * 12,
                                width: sizes!.widthRatio * 80,
                                decoration: BoxDecoration(
                                  color: AppColors.accent02,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          CommonPadding.sizeBoxWithHeight(height: 16),
                          const GetGenericText(
                            text:
                                "Please wait, your video is being generated...",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent02,
                            lines: 3,
                            textAlign: TextAlign.center,
                          ).get15HorizontalPadding(),
                        ],
                      ),
                    ),
                  ],
                ),

                ///Video Container
                // Container(
                //   height: sizes!.heightRatio * 300,
                //   width: sizes!.widthRatio * 342,
                //   decoration: BoxDecoration(
                //     color: AppColors.mainWhite100,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: CachedNetworkImage(
                //       imageUrl:
                //           'https://images.unsplash.com/photo-1528127269322-539801943592?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2970&q=80',
                //       fit: BoxFit.cover,
                //       progressIndicatorBuilder:
                //           (context, url, downloadProgress) => Center(
                //         child: SizedBox(
                //           height: sizes!.heightRatio * 20,
                //           width: sizes!.widthRatio * 20,
                //           child: CircularProgressIndicator(
                //             value: downloadProgress.progress,
                //           ),
                //         ),
                //       ),
                //       errorWidget: (context, url, error) =>
                //           const Icon(Icons.error),
                //     ),
                //   ),
                //   // child:
                //   //
                //   //     /// Video Player
                //   //     _controllerVideoPlayer.value.isInitialized
                //   //         ? SizedBox(
                //   //             height: sizes!.heightRatio * 300,
                //   //             width: sizes!.widthRatio * 342,
                //   //             child: Stack(
                //   //               alignment: Alignment.center,
                //   //               children: [
                //   //                 ClipRRect(
                //   //                   borderRadius: BorderRadius.circular(10),
                //   //                   child: GestureDetector(
                //   //                     onTap: () {
                //   //                       setState(() {
                //   //                         _controllerVideoPlayer.value.isPlaying
                //   //                             ? _controllerVideoPlayer.pause()
                //   //                             : _controllerVideoPlayer.play();
                //   //                       });
                //   //                     },
                //   //                     child: VideoPlayer(
                //   //                       _controllerVideoPlayer,
                //   //                     ),
                //   //                   ),
                //   //                 ),
                //   //                 _controllerVideoPlayer.value.isPlaying
                //   //                     ? SvgPicture.asset(
                //   //                         "assets/svg/pause_icon.svg",
                //   //                       )
                //   //                     : SvgPicture.asset(
                //   //                         'assets/svg/play_icon.svg',
                //   //                       )
                //   //               ],
                //   //             ),
                //   //           )
                //   //         : const Center(
                //   //             child: CircularProgressIndicator(
                //   //               color: AppColors.redTwoColor,
                //   //             ),
                //   //           ),
                // ),
                CommonPadding.sizeBoxWithHeight(height: 16),
                // Location And Share Heading
                _locationAndShareHeading(
                  location: customizeTripProvider
                          .createTripResponse.data?.destination ??
                      "",
                ),
                CommonPadding.sizeBoxWithHeight(height: 12),
                // Trip User Container
                _tripUserContainer(
                  userName:
                      "${customizeTripProvider.createTripResponse.data!.owner!.firstName} ${customizeTripProvider.createTripResponse.data!.owner!.lastName ?? ""}",
                ),
                CommonPadding.sizeBoxWithHeight(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Rate this Trip
                    _rateThisTripButton(
                      onPress: () {
                        //TODO: Uncomment this
                        var tripId =
                            customizeTripProvider.createTripResponse.data!.id!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TripFeedbackScreen(
                              tripId: tripId,
                            ),
                          ),
                        );
                      },
                    ),

                    /// Add To Calender Button
                    _addToCalenderButton(
                      onPress: () async {
                        //TODO: Working here

                        await Add2Calendar.addEvent2Cal(buildEvent(
                          title: customizeTripProvider
                              .createTripResponse.data!.destination!,
                          description:
                              "This trip has been created by using Planify.holiday",
                          location: customizeTripProvider
                              .createTripResponse.data!.departureLocation!,
                          startDate: DateTime.now(),
                          endDate: DateTime.now().add(const Duration(days: 5)),
                          emailInvites: [''],
                        )).then((value) {
                          // State
                          setState(() {
                            isAddToCalendar = true;
                          });
                          //Toasts
                          Toasts.getSuccessToast(
                            text:
                                "Trip ${isAddToCalendar ? "added" : "removed"} ${isAddToCalendar ? "to" : "from"} your calender",
                          );
                        });
                      },
                    ),
                  ],
                ),

                CommonPadding.sizeBoxWithHeight(height: 12),
                const Divider(
                  color: AppColors.gray5Color,
                  thickness: 1,
                ),
                CommonPadding.sizeBoxWithHeight(height: 12),
                const GetGenericText(
                  text: "Trip Information",
                  fontFamily: Assets.basement,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite100,
                  lines: 1,
                ).getAlign(),
                CommonPadding.sizeBoxWithHeight(height: 24),
                _getTripInfoRow(
                  title: "Trip Type",
                  subTitle: "Customized",
                ),
                //Customized
                CommonPadding.sizeBoxWithHeight(height: 8),
                _getTripInfoRow(
                  title: "Company of",
                  subTitle: customizeTripProvider
                          .createTripResponse.data?.companyOf ??
                      "",
                ),
                //Family
                CommonPadding.sizeBoxWithHeight(height: 8),
                _getTripInfoRow(
                  title: "Commute Type",
                  subTitle: customizeTripProvider
                          .createTripResponse.data?.commuteType ??
                      "",
                ),
                //Public
                // CommonPadding.sizeBoxWithHeight(height: 8),
                // _getTripInfoRow(title: "Amenities", subTitle: "Pools"),
                // CommonPadding.sizeBoxWithHeight(height: 8),
                // _getTripInfoRow(title: "Stay", subTitle: "Apartment"),
                CommonPadding.sizeBoxWithHeight(height: 8),
                _getTripInfoRow(
                    title: "Budget",
                    subTitle:
                        "$selectCurrency ${customizeTripProvider.createTripResponse.data?.budget ?? "0"}"),
                CommonPadding.sizeBoxWithHeight(height: 8),
                _getTripInfoRow(
                  title: "Number of Members",
                  subTitle: customizeTripProvider
                          .createTripResponse.data?.numberOfMembers
                          .toString() ??
                      "0",
                ),
                CommonPadding.sizeBoxWithHeight(height: 8),
                _getTripInfoRow(
                  title: "Number of days",
                  subTitle: customizeTripProvider
                          .createTripResponse.data?.numberOfDays
                          .toString() ??
                      "0",
                ),
                CommonPadding.sizeBoxWithHeight(height: 8),
                _getTripDateInfoRow(
                  date: "Date",
                  subTitle: customizeTripProvider
                      .createTripResponse.data!.createdAt
                      .toString(),
                ),
                CommonPadding.sizeBoxWithHeight(height: 16),
                const Divider(
                  color: AppColors.gray5Color,
                  thickness: 1,
                ),
                CommonPadding.sizeBoxWithHeight(height: 16),
                const GetGenericText(
                  text: "Trip Itinerary",
                  fontFamily: Assets.basement,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite100,
                  lines: 1,
                ).getAlign(),
                CommonPadding.sizeBoxWithHeight(height: 16),

                // Trip Itinerary ListView
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: customizeTripProvider
                        .createTripResponse.data!.tripItinerary!.length,
                    itemBuilder: (context, index) {
                      //Pass Trip Id
                      var tripId =
                          customizeTripProvider.createTripResponse.data!.id!;

                      //data
                      var data = customizeTripProvider
                          .createTripResponse.data!.tripItinerary![index];
                      var title = data.title.toString();
                      var activity = data.activities!;
                      var iterationId = data.id!;

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: sizes!.heightRatio * 10,
                        ),
                        child: _tripItineraryContainer(
                          tripId: tripId,
                          title: title,
                          iterationId: iterationId,
                          numberOfDays: "0${index + 1}",
                          activities: activity,
                          onPress: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 8),
                const Divider(
                  color: AppColors.gray5Color,
                  thickness: 1,
                ),
                CommonPadding.sizeBoxWithHeight(height: 8),
                // Carbon Container
                _carbonContainer(),
                CommonPadding.sizeBoxWithHeight(height: 80),
              ],
            ).get16HorizontalPadding(),
          ),
        ),
      ),
    );
  }

  /// Location And Share Heading
  Widget _locationAndShareHeading({
    required String location,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/svg/location_icon.svg",
            height: sizes!.heightRatio * 32,
            width: sizes!.widthRatio * 32,
            color: AppColors.mainWhite100,
          ),
          CommonPadding.sizeBoxWithWidth(width: 6),
          Expanded(
            child: GetGenericText(
              text: location,
              fontFamily: Assets.basement,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.mainWhite100,
              lines: 2,
            ),
          ),
        ],
      );

  /// Rate this trip
  Widget _rateThisTripButton({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          height: sizes!.heightRatio * 32,
          width: sizes!.widthRatio * 155,
          decoration: BoxDecoration(
            color: AppColors.mainPureWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: AppColors.mainBlack100,
              width: 2,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/rating_star_icon.svg",
              ),
              CommonPadding.sizeBoxWithWidth(width: 8),
              const GetGenericText(
                text: "Rate this trip",
                fontFamily: Assets.aileron,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.mainBlack100,
                lines: 1,
              )
            ],
          ),
        ),
      );

  /// Add To Calender
  Widget _addToCalenderButton({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          height: sizes!.heightRatio * 32,
          width: sizes!.widthRatio * 155,
          decoration: BoxDecoration(
            color: AppColors.mainPureWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isAddToCalendar == true
                  ? AppColors.greenTwoColor
                  : AppColors.mainBlack100,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isAddToCalendar == true
                    ? AppColors.greenTwoColor
                    : AppColors.mainBlack100,
                spreadRadius: 0,
                blurRadius: 0,
                offset: const Offset(-2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isAddToCalendar == true
                  ? SvgPicture.asset(
                      "assets/svg/add_green_calendar_icon.svg",
                    )
                  : SvgPicture.asset(
                      "assets/svg/add_calendar_icon.svg",
                    ),
              CommonPadding.sizeBoxWithWidth(width: 8),
              GetGenericText(
                text: "Add to Calendar",
                fontFamily: Assets.aileron,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isAddToCalendar == true
                    ? AppColors.greenTwoColor
                    : AppColors.mainBlack100,
                lines: 1,
              )
            ],
          ),
        ),
      );

  /// Carbon Container
  Widget _carbonContainer() => Container(
        height: sizes!.heightRatio * 60,
        width: sizes!.widthRatio * 360,
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.greenColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizes!.widthRatio * 8,
            vertical: sizes!.heightRatio * 14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/svg/greeny_heart_icon.svg",
                height: sizes!.heightRatio * 18,
                width: sizes!.widthRatio * 20,
              ),
              CommonPadding.sizeBoxWithWidth(width: 12),
              const Expanded(
                child: GetGenericText(
                  text:
                      "Planify is committed to the Global Program on Sustainability for negative carbon footprint by 2030",
                  fontFamily: Assets.aileron,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainBlack100,
                  lines: 2,
                ),
              )
            ],
          ),
        ),
      );

  /// Trip Itinerary Container
  Widget _tripItineraryContainer({
    required String tripId,
    required String title,
    required String iterationId,
    required String numberOfDays,
    required List<Activities> activities,
    required int index,
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: currentIndex == index
            ? Container(
                //height: sizes!.heightRatio * 510,
                width: sizes!.widthRatio * 362,
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.mainBlack,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(-4, 4), // changes position of shadow
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: sizes!.widthRatio * 16,
                        right: sizes!.widthRatio * 8,
                        top: sizes!.heightRatio * 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              debugPrint("iterationId: $iterationId");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShowPreviousIterationScreen(
                                    iterationId: iterationId,
                                    tripId: tripId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Text(
                                "Show previous iteration",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: sizes!.fontRatio * 12,
                                  fontFamily: Assets.aileron,
                                  color: AppColors.accent02,
                                  //decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Toasts.getWarningToast(text: "Regenerate it");
                              _showGenerateAlertBox(
                                tripId: tripId,
                                iterationId: iterationId,
                                context: context,
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                "assets/svg/regenerate_icon.svg",
                                height: sizes!.heightRatio * 24,
                                width: sizes!.widthRatio * 24,
                                color: AppColors.accent02,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonPadding.sizeBoxWithHeight(height: 25),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizes!.widthRatio * 16,
                      ),
                      child: Row(
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
                                color: AppColors.accent02,
                                lines: 1,
                              ),
                            ],
                          ),
                          CommonPadding.sizeBoxWithWidth(width: 24),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: sizes!.heightRatio * 90,
                width: sizes!.widthRatio * 362,
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.mainBlack,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(-4, 4), // changes position of shadow
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizes!.widthRatio * 16,
                    vertical: sizes!.heightRatio * 12,
                  ),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: AppColors.accent02,
                                lines: 1,
                              ),
                            ],
                          ),
                          CommonPadding.sizeBoxWithWidth(width: 25),
                          Flexible(
                            child: GetGenericText(
                              text: title,
                              fontFamily: Assets.aileron,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.mainBlack100,
                              lines: 4,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      );

  /// Trip User Container
  Widget _tripUserContainer({
    required String userName,
  }) =>
      Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(
              "https://picsum.photos/200/300",
            ),
          ),
          CommonPadding.sizeBoxWithWidth(width: 8),
          GetGenericText(
            text: userName,
            fontFamily: Assets.aileron,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.mainWhite100,
            lines: 1,
          ),
        ],
      );

  // Get Trip Info Row
  Widget _getTripInfoRow({
    required String title,
    required String subTitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GetGenericText(
          text: title,
          fontFamily: Assets.aileron,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.mainWhite100,
          lines: 1,
        ),
        GetGenericText(
          text: subTitle,
          fontFamily: Assets.basement,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.mainWhite100,
          lines: 1,
        ),
      ],
    );
  }

  // Get Trip Info Row
  Widget _getTripDateInfoRow({
    required String date,
    required String subTitle,
  }) {
    var parse = DateTime.parse(subTitle);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GetGenericText(
          text: date,
          fontFamily: Assets.aileron,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.mainWhite100,
          lines: 1,
        ),
        GetGenericText(
          text: "${parse.day}/${parse.month}/${parse.year}",
          fontFamily: Assets.basement,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.mainWhite100,
          lines: 1,
        ),
      ],
    );
  }

  // Show Gift Sharing Box
  Future<void> _shareWithFriendsAlertBox({
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
                    height: sizes!.heightRatio * 325,
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
                            text: "Your Trip is Successfully Generated.",
                            fontFamily: Assets.basement,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 3,
                            textAlign: TextAlign.center,
                          ).get16HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 12),
                          const GetGenericText(
                            text: "Share it with your friends 😃",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainBlack100,
                            lines: 4,
                            textAlign: TextAlign.center,
                          ).get16HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 30),

                          // Gradient Get Start PopUp Button
                          GradientGetStartPopUpButton(
                            title: 'Share on Tiktok',
                            icon: "assets/png/tiktok_icon.png",
                            onPress: () async {
                              //TODO: Working here
                              await Share.share(
                                "$username has shared with you their dream trip. Please add this code ${customizeTripProvider.createTripResponse.data!.shareCode} on My Trips tab or click the link below. Link with the trip shared. \n\n https://play.google.com/store/apps/details?id=com.erizzarate.planify",
                              ).then((value) {
                                Navigator.pop(context);
                              });
                            },
                          ),

                          CommonPadding.sizeBoxWithHeight(height: 16),

                          // Gradient Get Start PopUp Button
                          GradientGetStartPopUpButton(
                            title: 'Share on Instagram',
                            icon: "assets/png/instagram_icon.png",
                            onPress: () async {
                              //TODO: Working here
                              await Share.share(
                                "$username has shared with you their dream trip. Please add this code ${customizeTripProvider.createTripResponse.data!.shareCode} on My Trips tab or click the link below. Link with the trip shared. \n\n https://play.google.com/store/apps/details?id=com.erizzarate.planify",
                              ).then((value) {
                                Navigator.pop(context);
                              });
                            },
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

  /// Show Generate Alert Box
  Future<void> _showGenerateAlertBox({
    required String iterationId,
    required String tripId,
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
                          CommonPadding.sizeBoxWithHeight(height: 10),

                          const GetGenericText(
                            text:
                                "Are you sure you want to regenerate this activity?",
                            fontFamily: Assets.aileron,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainBlack100,
                            lines: 3,
                            textAlign: TextAlign.center,
                          ).get16HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: sizes!.heightRatio * 52,
                                  width: sizes!.widthRatio * 145,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainPureWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: GetGenericText(
                                      text: "Cancel",
                                      fontFamily: Assets.basement,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.mainBlack100,
                                      lines: 1,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  regenerateTripIteration(
                                    tripId: tripId,
                                    iterationId: iterationId,
                                  );
                                },
                                child: Container(
                                  height: sizes!.heightRatio * 52,
                                  width: sizes!.widthRatio * 145,
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
                                      "Regenerate",
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
                                ),
                              ),
                            ],
                          )
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

  /// Call Regenerate Trip Iteration
  void regenerateTripIteration({
    required String tripId,
    required String iterationId,
  }) async {
    setState(() {
      isUserRegeneratingIteration = true;
    });

    Toasts.getWarningToast(
      text: "Please wait, iteration regenerating...",
    );

    await customizeTripProvider
        .regenerateTripIteration(
          tripId: tripId,
          iterationId: iterationId,
          context: context,
        )
        .then(
          (value) => Navigator.pop(context),
        );
  }
}
