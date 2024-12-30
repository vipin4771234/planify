// Created by Tayyab Mughal on 20/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_itinerary_detail_screens/trip_itinerary_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../app_data_models/trips/GetTripDetailByIdResponse.dart';
import '../../pop_ups/pop_ups.dart';

class TripItineraryDetailScreen extends StatefulWidget {
  final String userName;
  final String tripId;
  final bool isMyTrips;
  final String videoLink;

  const TripItineraryDetailScreen({
    Key? key,
    required this.userName,
    required this.tripId,
    required this.isMyTrips,
    required this.videoLink,
  }) : super(key: key);

  @override
  State<TripItineraryDetailScreen> createState() =>
      _TripItineraryDetailScreenState();
}

class _TripItineraryDetailScreenState extends State<TripItineraryDetailScreen> {
  //Provider
  late TripDetailProvider tripDetailProvider;
  bool isLike = false;

  //Video Player
  late VideoPlayerController _controllerVideoPlayer;
  Duration getDuration = const Duration(hours: 0, minutes: 0);
  Duration deceaseVideoTimer = const Duration(minutes: 0, seconds: 0);
  bool hiddenVideoControllers = false;

  final newLinkTesting =
      "https://res.cloudinary.com/de7qyzgg8/video/upload/v1686048635/Video%20Auto/5e8eb2b8-42b5-4a14-8923-1910b4285f57.mp4";

  var email = LocalAppDatabase.getString(Strings.loginEmail) ?? "";
  var token = LocalAppDatabase.getString(Strings.loginUserToken) ?? "";
  var username = LocalAppDatabase.getString(Strings.loginFirstName) ?? "";

  int currentIndex = -1;

  var appleAppShorterLink = "https://apple.co/3CklEaK";
  var googleAppShorterLink = "https://bit.ly/3qwGlh4";

  @override
  void initState() {
    super.initState();

    tripDetailProvider = TripDetailProvider();
    tripDetailProvider =
        Provider.of<TripDetailProvider>(context, listen: false);
    tripDetailProvider.init(context: context);

    //videoLinkTwo
    _controllerVideoPlayer = VideoPlayerController.network(widget.videoLink)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        // TODO:
        // _controllerVideoPlayer.play();
      });

    // Video Position
    _controllerVideoPlayer.addListener(_videoPosition);

    debugPrint(
        "videoHeight: ${_controllerVideoPlayer.value.size.height} - videoWidth: ${_controllerVideoPlayer.value.size.width}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      tripDetailProvider.getTripDetailById(tripId: widget.tripId);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerVideoPlayer.dispose();
    _controllerVideoPlayer.removeListener(_videoPosition);
  }

  /// Video Position
  void _videoPosition() async {
    if (_controllerVideoPlayer.value.isInitialized) {
      setState(() {
        getDuration = _controllerVideoPlayer.value.position;
        deceaseVideoTimer = _controllerVideoPlayer.value.duration -
            _controllerVideoPlayer.value.position;
      });
      if (_controllerVideoPlayer.value.position ==
          _controllerVideoPlayer.value.duration) {
        _controllerVideoPlayer.removeListener(_videoPosition);
        setState(() {
          // showAlertDialog(context: context);
        });
      }
    }
  }

  /// Hidden Controller
  // void _hiddenController() async {
  //   Future.delayed(const Duration(seconds: 5), () {
  //     if (hiddenVideoControllers) {
  //       hiddenVideoControllers = false;
  //       debugPrint("hiddenVideoControllers: $hiddenVideoControllers");
  //     }
  //   });
  // }

  /// Get Video Position
  // _getVideoPosition() {
  //   if (_controllerVideoPlayer.value.isInitialized) {
  //     var getVideoCurrentPosition = Duration(
  //         milliseconds:
  //             _controllerVideoPlayer.value.position.inMilliseconds.round());
  //     var getVideoFullDuration = Duration(
  //         milliseconds:
  //             _controllerVideoPlayer.value.duration.inMilliseconds.round());
  //     var getVideoTimer = getVideoFullDuration - getVideoCurrentPosition;
  //     var time = [getVideoTimer.inMinutes, getVideoTimer.inSeconds]
  //         .map((seg) => seg.remainder(60).toString().padLeft(2, "0"))
  //         .join(":");
  //     debugPrint("getVideoTimer:$time");
  //     return time;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<TripDetailProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientBlueLinearOne,
        elevation: 0,
      ),
      body: Container(
        height: sizes!.height,
        width: sizes!.width,
        color: AppColors.gradientBlueLinearOne,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: SafeArea(
            child: tripDetailProvider.isTripDetailLoading == 2
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        tripDetailProvider.isTripDetailLoading == 1 ||
                                tripDetailProvider.isTripDetailLoading == 0
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                    children: [
                      CommonPadding.sizeBoxWithHeight(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(134, 0, 0, 0),
                            width: 4.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(194, 0, 0, 0),
                        ),
                        child: SvgPicture.asset(
                          "assets/svg/planify_logo.svg",
                          height: sizes!.heightRatio * 180,
                          width: sizes!.widthRatio * 342,
                        ),
                      ),
                      //Video Player
                      // Container(
                      //   height: _controllerVideoPlayer.value.isInitialized
                      //       ? null
                      //       : sizes!.heightRatio * 180,
                      //   width: _controllerVideoPlayer.value.isInitialized
                      //       ? null
                      //       : sizes!.widthRatio * 342,
                      //   decoration: BoxDecoration(
                      //     color: AppColors.mainBlack100,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child:

                      //       /// Video Player
                      //       _controllerVideoPlayer.value.isInitialized
                      //           ? SizedBox(
                      //               // height: sizes!.heightRatio * 300,
                      //               // width: sizes!.widthRatio * 342,
                      //               child: Stack(
                      //                 alignment: Alignment.center,
                      //                 children: [
                      //                   ///Video Player
                      //                   ClipRRect(
                      //                     borderRadius:
                      //                         BorderRadius.circular(10),
                      //                     child: GestureDetector(
                      //                       onTap: () {
                      //                         setState(() {
                      //                           _controllerVideoPlayer
                      //                                   .value.isPlaying
                      //                               ? _controllerVideoPlayer
                      //                                   .pause()
                      //                               : _controllerVideoPlayer
                      //                                   .play();
                      //                         });
                      //                       },
                      //                       child: AspectRatio(
                      //                         aspectRatio:
                      //                             _controllerVideoPlayer
                      //                                 .value.aspectRatio,
                      //                         child: VideoPlayer(
                      //                           _controllerVideoPlayer,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),

                      //                   /// If isBuffering show CircularProgressIndicator
                      //                   Visibility(
                      //                     visible: _controllerVideoPlayer
                      //                         .value.isBuffering,
                      //                     child: const Center(
                      //                       child: CircularProgressIndicator(
                      //                         color: AppColors.redTwoColor,
                      //                       ),
                      //                     ),
                      //                   ),

                      //                   /// Video Player Buttons
                      //                   Visibility(
                      //                     visible: !_controllerVideoPlayer
                      //                         .value.isPlaying,
                      //                     child: _controllerVideoPlayer
                      //                             .value.isPlaying
                      //                         ? GestureDetector(
                      //                             onTap: () {
                      //                               setState(() {
                      //                                 _controllerVideoPlayer
                      //                                         .value.isPlaying
                      //                                     ? _controllerVideoPlayer
                      //                                         .pause()
                      //                                     : _controllerVideoPlayer
                      //                                         .play();
                      //                               });
                      //                             },
                      //                             child: SvgPicture.asset(
                      //                               "assets/svg/pause_icon.svg",
                      //                             ),
                      //                           )
                      //                         : GestureDetector(
                      //                             onTap: () {
                      //                               setState(() {
                      //                                 _controllerVideoPlayer
                      //                                         .value.isPlaying
                      //                                     ? _controllerVideoPlayer
                      //                                         .pause()
                      //                                     : _controllerVideoPlayer
                      //                                         .play();
                      //                               });
                      //                             },
                      //                             child: SvgPicture.asset(
                      //                               'assets/svg/play_icon.svg',
                      //                             ),
                      //                           ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             )
                      //           : const Center(
                      //               child: CircularProgressIndicator(
                      //                 color: AppColors.redTwoColor,
                      //               ),
                      //             ),
                      // ),

                      CommonPadding.sizeBoxWithHeight(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/location_icon.svg",
                            height: sizes!.heightRatio * 32,
                            width: sizes!.widthRatio * 32,
                          ),
                          CommonPadding.sizeBoxWithWidth(width: 6),
                          Expanded(
                            child: GetGenericText(
                              text: tripDetailProvider.getTripDetailByIdResponse
                                      .data?.trip?.destination ??
                                  "There is no location available",
                              fontFamily: Assets.basement,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: AppColors.mainWhite,
                              lines: 2,
                            ),
                          ),
                          CommonPadding.sizeBoxWithWidth(width: 6),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  /// if user log-in
                                  if (email != "" && token != "") {
                                    var isSavedByMe =
                                        tripDetailProvider.isTripSaved;
                                    debugPrint("isSavedByMe: $isSavedByMe");
                                    // Set value true or false -> by default false
                                    setState(() {
                                      // isSavedByMe = !isSavedByMe;
                                      isLike = !isSavedByMe;
                                    });
                                    debugPrint("isLike: $isLike");

                                    var tripId = tripDetailProvider
                                        .getTripDetailByIdResponse
                                        .data!
                                        .trip!
                                        .id!;

                                    debugPrint("tripId:$tripId");

                                    /// Mark Trip Favorite
                                    await tripDetailProvider.markTripFavorite(
                                      tripId: tripId,
                                      isLike: isLike,
                                      context: context,
                                    );
                                  } else {
                                    PopUps.loginRequiredPopUp(
                                      context: context,
                                    );
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: isLike
                                      ? SvgPicture.asset(
                                          "assets/svg/select_heart_icon.svg",
                                          height: sizes!.heightRatio * 24,
                                          width: sizes!.widthRatio * 24,
                                        )
                                      : SvgPicture.asset(
                                          "assets/svg/un_select_heart_icon.svg",
                                          height: sizes!.heightRatio * 24,
                                          width: sizes!.widthRatio * 24,
                                        ),
                                ),
                              ),
                              CommonPadding.sizeBoxWithHeight(height: 6),
                              GestureDetector(
                                onTap: () async {
                                  /// if user log-in
                                  if (email != "" && token != "") {
                                    await Share.share(
                                        "${username.toUpperCase()} has shared with you their DREAM TRIP. Please add this code: ${tripDetailProvider.getTripDetailByIdResponse.data?.trip?.shareCode} on My Trips tab or click the link below. \n\n iOS App Link: \n unitester2910://unitest000.com?openPicture1029 \n\n Android App Link: \n $googleAppShorterLink");
                                  } else {
                                    PopUps.loginRequiredPopUp(
                                      context: context,
                                    );
                                  }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: SvgPicture.asset(
                                    "assets/svg/share_icon.svg",
                                    height: sizes!.heightRatio * 24,
                                    width: sizes!.widthRatio * 24,
                                    color: AppColors.mainWhite,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      CommonPadding.sizeBoxWithHeight(height: 12),
                      _tripUserContainer(
                        userName:
                            "${tripDetailProvider.getTripDetailByIdResponse.data!.trip!.owner!.firstName} ${tripDetailProvider.getTripDetailByIdResponse.data!.trip!.owner!.lastName}",
                        imageUrl:
                            // tripDetailProvider
                            //         .getTripDetailResponse.data!.createdBy!.picture ??
                            "https://picsum.photos/200/300",
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
                        color: AppColors.mainWhite,
                        lines: 1,
                      ).getAlign(),
                      CommonPadding.sizeBoxWithHeight(height: 24),
                      _getTripInfoRow(
                        title: "Trip Type",
                        subTitle:
                            // tripDetailProvider
                            //         .getTripDetailResponse.data!.tripInfo!.tripType ??
                            "Customized",
                      ),
                      CommonPadding.sizeBoxWithHeight(height: 8),
                      //TODO: Add Family
                      _getTripInfoRow(
                        title: "Company of",
                        subTitle: tripDetailProvider.getTripDetailByIdResponse
                                .data?.trip?.companyOf ??
                            "Family",
                      ),
                      CommonPadding.sizeBoxWithHeight(height: 8),
                      //TODO: Add Public
                      _getTripInfoRow(
                          title: "Commute Type", subTitle: "Public"),
                      CommonPadding.sizeBoxWithHeight(height: 8),
                      //TODO: Add Date
                      // _getTripInfoRow(title: "Amenities", subTitle: "Demo"
                      // tripDetailProvider
                      //     .getTripDetailResponse.data!.tripInfo!.amenities!
                      //     .map((e) => e)
                      //     .toString(),
                      // tripDetailProvider
                      //     .getTripDetailResponse.data!.tripInfo!.amenities![0]
                      //     .toString(),

                      // "Pools",
                      //  ),
                      // CommonPadding.sizeBoxWithHeight(height: 8),
                      //TODO: Add Date
                      // _getTripInfoRow(title: "Stay", subTitle: "Apartment"),
                      // CommonPadding.sizeBoxWithHeight(height: 8),
                      _getTripInfoRow(
                          title: "Budget",
                          subTitle:
                              "\$${tripDetailProvider.getTripDetailByIdResponse.data?.trip?.budget ?? '\$0000'}"),
                      CommonPadding.sizeBoxWithHeight(height: 8),
                      _getTripInfoRow(
                          title: "Number of Members",
                          subTitle:
                              "${tripDetailProvider.getTripDetailByIdResponse.data?.trip?.numberOfMembers ?? '0'}"),
                      CommonPadding.sizeBoxWithHeight(height: 8),
                      _getTripInfoRow(
                          title: "Number of days",
                          subTitle:
                              "${tripDetailProvider.getTripDetailByIdResponse.data?.trip?.numberOfDays ?? '0'}"),
                      CommonPadding.sizeBoxWithHeight(height: 8),
                      //TODO: Add Date
                      _getTripInfoRow(
                        title: "Date",
                        subTitle: "${tripDetailProvider.formattedDate}",
                      ),
                      CommonPadding.sizeBoxWithHeight(height: 16),
                      // Activity Container, Saves, Km away, 1h ago
                      _activityContainer(
                        numberOfSaves: tripDetailProvider
                            .getTripDetailByIdResponse.data!.trip!.savedBy
                            .toString(),
                        kmAway: tripDetailProvider
                            .getTripDetailByIdResponse.data!.trip!.distance
                            .toString(), //widget.kmAway,
                        timeAgo: DateTime.parse(
                          tripDetailProvider
                              .getTripDetailByIdResponse.data!.trip!.createdAt
                              .toString(),
                        ),
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
                        color: AppColors.mainWhite,
                        lines: 1,
                      ).getAlign(),
                      CommonPadding.sizeBoxWithHeight(height: 16),
                      // Trip Itinerary ListView
                      tripDetailProvider.getTripDetailByIdResponse.data!.trip!
                              .tripItinerary!.isNotEmpty
                          ? Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: tripDetailProvider
                                    .getTripDetailByIdResponse
                                    .data!
                                    .trip!
                                    .tripItinerary!
                                    .length,

                                // tripDetailProvider
                                //     .getTripDetailResponse.data!.tripItinerary!.length,
                                itemBuilder: (context, index) {
                                  var data = tripDetailProvider
                                      .getTripDetailByIdResponse
                                      .data!
                                      .trip!
                                      .tripItinerary![index];

                                  // var numberOfDay = data.day;
                                  var activityTitle = data.title.toString();
                                  var activity = data.activities!;

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: sizes!.heightRatio * 10,
                                    ),
                                    child: _tripItineraryContainer(
                                      index: index,
                                      activities: activity,
                                      numberOfDays: "0${index + 1}",
                                      //"0$numberOfDay",
                                      activityTitle: activityTitle,
                                      onPress: () {
                                        // Toasts.getWarningToast(
                                        //   text:
                                        //       "Try it later, ${index + 1}",
                                        // );
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text("No Trip Itinerary available."),
                            ),
                      CommonPadding.sizeBoxWithHeight(height: 8),
                      const Divider(
                        color: AppColors.gray5Color,
                        thickness: 1,
                      ),
                      CommonPadding.sizeBoxWithHeight(height: 8),

                      // Environmental Container
                      _environmentalContainer(),
                      CommonPadding.sizeBoxWithHeight(height: 30),
                    ],
                  ).get16HorizontalPadding()
                : tripDetailProvider.isTripDetailLoading == 1
                    ? Center(
                        child: GetGenericText(
                          text:
                              tripDetailProvider.errorResponse.data?.message ??
                                  "",
                          fontFamily: Assets.aileron,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainWhite,
                          lines: 2,
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          ),
        ),
      ),
    );
  }

  /// Trip Itinerary Container
  Widget _tripItineraryContainer({
    required String numberOfDays,
    required String activityTitle,
    required List<Activities> activities,
    required int index,
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          //TODO:
          // height: sizes!.heightRatio * 235,
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
              vertical: sizes!.heightRatio * 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Heading Day and Title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    CommonPadding.sizeBoxWithWidth(width: 10),
                    //Activity Title
                    Expanded(
                      child: GetGenericText(
                        text: activityTitle,
                        fontFamily: Assets.aileron,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainBlack100,
                        lines: 10,
                      ),
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     SvgPicture.asset("assets/svg/itinerary_icon.svg"),
                    //     CommonPadding.sizeBoxWithWidth(width: 8),
                    //     GetGenericText(
                    //       text: activityTitle,
                    //       fontFamily: Assets.aileron,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400,
                    //       color: AppColors.mainBlack100,
                    //       lines: 2,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                //Booking on
                CommonPadding.sizeBoxWithHeight(height: 20),
                const GetGenericText(
                  text: "Booking on:",
                  fontFamily: Assets.basement,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainBlack,
                  lines: 1,
                ).getAlign(),
                CommonPadding.sizeBoxWithHeight(height: 12),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await tripDetailProvider.openServiceUrl(
                          serviceUrl:
                              "https://www.booking.com/index.html?aid=7997731",
                        );
                      },
                      child: Container(
                        height: sizes!.heightRatio * 40,
                        width: sizes!.widthRatio * 100,
                        decoration: BoxDecoration(
                          color: AppColors.bookOnColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/png/booking_logo.png",
                            width: sizes!.widthRatio * 80,
                          ),
                        ),
                      ),
                    ),
                    CommonPadding.sizeBoxWithWidth(width: 10),
                    GestureDetector(
                      onTap: () async {
                        await tripDetailProvider.openServiceUrl(
                          serviceUrl: "https://expedia.com/affiliate/QlOOyca",
                        );
                      },
                      child: Container(
                        height: sizes!.heightRatio * 40,
                        width: sizes!.widthRatio * 100,
                        decoration: BoxDecoration(
                          color: AppColors.bookOnColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/png/expedia_logo.png",
                            width: sizes!.widthRatio * 80,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                CommonPadding.sizeBoxWithHeight(height: 20),

                widget.isMyTrips
                    ? Flexible(
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
                                      await tripDetailProvider.openServiceUrl(
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
                      )
                    : widget.isMyTrips == false && index.isOdd
                        ? Flexible(
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
                                          await tripDetailProvider
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
                          )
                        : Container(),

                // CommonPadding.sizeBoxWithHeight(height: 12),
                // Row(
                //   children: [
                //     GestureDetector(
                //       onTap: () async {
                //         await tripDetailProvider.openServiceUrl(
                //           serviceUrl: "https://www.opentable.com/",
                //         );
                //       },
                //       child: Container(
                //         height: sizes!.heightRatio * 40,
                //         width: sizes!.widthRatio * 100,
                //         decoration: BoxDecoration(
                //           color: AppColors.bookOnColor,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Center(
                //           child: Image.asset(
                //             "assets/png/open_table_logo.png",
                //             width: sizes!.widthRatio * 80,
                //           ),
                //         ),
                //       ),
                //     ),
                //     CommonPadding.sizeBoxWithWidth(width: 10),
                //     GestureDetector(
                //       onTap: () async {
                //         await tripDetailProvider.openServiceUrl(
                //           serviceUrl: "https://www.civitatis.com/en/",
                //         );
                //       },
                //       child: Container(
                //         height: sizes!.heightRatio * 40,
                //         width: sizes!.widthRatio * 100,
                //         decoration: BoxDecoration(
                //           color: AppColors.bookOnColor,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Center(
                //           child: Image.asset(
                //             "assets/png/civitatis_logo.png",
                //             width: sizes!.widthRatio * 80,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      );

  /// Trip User Container
  Widget _tripUserContainer({
    required String userName,
    required String imageUrl,
  }) =>
      Row(
        children: [
          const CircleAvatar(
            radius: 20,
            foregroundImage: AssetImage("assets/png/user_avatar_two.png"),
          ),
          CommonPadding.sizeBoxWithWidth(width: 8),
          GetGenericText(
            text: userName,
            fontFamily: Assets.aileron,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.mainWhite,
            lines: 1,
          ),
        ],
      );

  /// Activity
  Widget _activityContainer({
    required String numberOfSaves,
    required String kmAway,
    required DateTime timeAgo,
  }) {
    var createdAtAgo = DateTime.parse(timeAgo.toString());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/svg/save_icon.svg",
            height: sizes!.heightRatio * 16,
            width: sizes!.widthRatio * 12,
            color: AppColors.mainWhite,
          ),
          CommonPadding.sizeBoxWithWidth(width: 4),
          GetGenericText(
            text: "$numberOfSaves Saves",
            fontFamily: Assets.aileron,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.mainWhite,
            lines: 1,
          ),
          const Spacer(),
          SvgPicture.asset(
            "assets/svg/routing_icon.svg",
            height: sizes!.heightRatio * 20,
            width: sizes!.widthRatio * 20,
            color: AppColors.mainWhite,
          ),
          CommonPadding.sizeBoxWithWidth(width: 4),
          GetGenericText(
            text: "$kmAway km away",
            fontFamily: Assets.aileron,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.mainWhite,
            lines: 1,
          ),
          const Spacer(),
          SvgPicture.asset(
            "assets/svg/edit_icon.svg",
            height: sizes!.heightRatio * 20,
            width: sizes!.widthRatio * 20,
            color: AppColors.mainWhite,
          ),
          CommonPadding.sizeBoxWithWidth(width: 4),
          GetGenericText(
            text: "".getTimeAgoString(timeNow: createdAtAgo),
            fontFamily: Assets.aileron,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.mainWhite,
            lines: 1,
          ),
        ],
      ),
    );
  }

  Widget _environmentalContainer() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/png/badge_icon.png",
            height: sizes!.heightRatio * 34,
            width: sizes!.widthRatio * 34,
          ),
          CommonPadding.sizeBoxWithWidth(width: 8),
          const Expanded(
            child: GetGenericText(
              text:
                  "This trip contributes to more sustainable future and reducing your environmental footprint. 😊",
              fontFamily: Assets.aileron,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: AppColors.mainWhite,
              lines: 3,
            ),
          )
        ],
      );

  Widget _getTripInfoRow({
    required String title,
    required String subTitle,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetGenericText(
            text: title,
            fontFamily: Assets.aileron,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.mainWhite,
            lines: 1,
          ),
          GetGenericText(
            text: subTitle,
            fontFamily: Assets.basement,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.mainWhite,
            lines: 1,
          ),
        ],
      );
}
