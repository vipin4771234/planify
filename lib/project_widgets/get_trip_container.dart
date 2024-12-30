// Created by Tayyab Mughal on 17/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:video_player/video_player.dart';

class GetTripContainer extends StatefulWidget {
  final String tripLocation;
  final String userName;
  final String numberOfSaves;
  final DateTime createdAtAgo;
  final String kiloMeterAway;

  final String videoLink;

  final Function onFavouritePress;
  final Function onSharePress;
  final Function onCreditPress;

  final bool isFavouriteTrip;
  final Function onTripPress;

  const GetTripContainer({
    Key? key,
    required this.onFavouritePress,
    required this.isFavouriteTrip,
    required this.tripLocation,
    required this.userName,
    required this.onSharePress,
    required this.onTripPress,
    required this.onCreditPress,
    required this.videoLink,
    required this.numberOfSaves,
    required this.createdAtAgo,
    required this.kiloMeterAway,
  }) : super(key: key);

  @override
  State<GetTripContainer> createState() => _GetTripContainerState();
}

class _GetTripContainerState extends State<GetTripContainer> {
  late VideoPlayerController _controllerVideoPlayer;
  Duration getDuration = const Duration(hours: 0, minutes: 0);
  Duration deceaseVideoTimer = const Duration(minutes: 0, seconds: 0);
  bool hiddenVideoControllers = false;

  @override
  void initState() {
    super.initState();

    debugPrint("widget.isFavouriteTrip: ${widget.isFavouriteTrip}");

    ///videoLinkTwo
    _controllerVideoPlayer = VideoPlayerController.network(widget.videoLink)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        // TODO:
        // _controllerVideoPlayer.play();
      });

    /// Video Position
    _controllerVideoPlayer.addListener(_videoPosition);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerVideoPlayer.dispose();
    _controllerVideoPlayer.removeListener(_videoPosition);
  }

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
    return GestureDetector(
      onTap: () => widget.onTripPress.call(),
      child: Container(
        // height: sizes!.heightRatio * 525,
        // width: sizes!.widthRatio * 360,
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.mainBlack100,
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(-4, 4), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizes!.widthRatio * 10,
            vertical: sizes!.heightRatio * 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //TODO: Fix this
              CommonPadding.sizeBoxWithHeight(height: 0),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/routing_icon.svg",
                      height: sizes!.heightRatio * 20,
                      width: sizes!.widthRatio * 20,
                    ),
                    CommonPadding.sizeBoxWithWidth(width: 4),
                    GetGenericText(
                      text: "${widget.kiloMeterAway ?? 0}km away",
                      fontFamily: Assets.aileron,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainBlack100,
                      lines: 1,
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      "assets/svg/edit_icon.svg",
                      height: sizes!.heightRatio * 20,
                      width: sizes!.widthRatio * 20,
                    ),
                    CommonPadding.sizeBoxWithWidth(width: 4),
                    GetGenericText(
                      text: "".getTimeAgoString(timeNow: widget.createdAtAgo),
                      fontFamily: Assets.aileron,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainBlack100,
                      lines: 1,
                    ),
                  ],
                ),
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),

              ///Video Player
              Stack(
                children: [
                  Container(
                    height: _controllerVideoPlayer.value.isInitialized
                        ? null
                        : sizes!.heightRatio * 180,
                    width: _controllerVideoPlayer.value.isInitialized
                        ? null
                        : sizes!.widthRatio * 342,
                    decoration: BoxDecoration(
                      color: AppColors.mainBlack100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      "assets/svg/planify_logo.svg",
                      height: sizes!.heightRatio * 180,
                      width: sizes!.widthRatio * 342,
                    ),

                    /// Video Player
                    // _controllerVideoPlayer.value.isInitialized
                    //     ? SizedBox(
                    //         // height: sizes!.heightRatio * 300,
                    //         // width: sizes!.widthRatio * 342,
                    //         child: Stack(
                    //           alignment: Alignment.center,
                    //           children: [
                    //             ///Video Player
                    //             ClipRRect(
                    //               borderRadius: BorderRadius.circular(10),
                    //               child: GestureDetector(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     _controllerVideoPlayer
                    //                             .value.isPlaying
                    //                         ? _controllerVideoPlayer.pause()
                    //                         : _controllerVideoPlayer.play();
                    //                   });
                    //                 },
                    //                 child: AspectRatio(
                    //                   aspectRatio: _controllerVideoPlayer
                    //                       .value.aspectRatio,
                    //                   child: VideoPlayer(
                    //                     _controllerVideoPlayer,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),

                    //             /// If isBuffering show CircularProgressIndicator
                    //             Visibility(
                    //               visible: _controllerVideoPlayer
                    //                   .value.isBuffering,
                    //               child: const Center(
                    //                 child: CircularProgressIndicator(
                    //                   color: AppColors.redTwoColor,
                    //                 ),
                    //               ),
                    //             ),

                    //             /// Video Player Buttons
                    //             Visibility(
                    //               visible: !_controllerVideoPlayer
                    //                   .value.isPlaying,
                    //               child:
                    //                   _controllerVideoPlayer.value.isPlaying
                    //                       ? GestureDetector(
                    //                           onTap: () {
                    //                             setState(() {
                    //                               _controllerVideoPlayer
                    //                                       .value.isPlaying
                    //                                   ? _controllerVideoPlayer
                    //                                       .pause()
                    //                                   : _controllerVideoPlayer
                    //                                       .play();
                    //                             });
                    //                           },
                    //                           child: SvgPicture.asset(
                    //                             "assets/svg/pause_icon.svg",
                    //                           ),
                    //                         )
                    //                       : GestureDetector(
                    //                           onTap: () {
                    //                             setState(() {
                    //                               _controllerVideoPlayer
                    //                                       .value.isPlaying
                    //                                   ? _controllerVideoPlayer
                    //                                       .pause()
                    //                                   : _controllerVideoPlayer
                    //                                       .play();
                    //                             });
                    //                           },
                    //                           child: SvgPicture.asset(
                    //                             'assets/svg/play_icon.svg',
                    //                           ),
                    //                         ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     : const Center(
                    //         child: CircularProgressIndicator(
                    //           color: AppColors.redTwoColor,
                    //         ),
                    //       ),
                  ),
                  Positioned(
                    right: sizes!.widthRatio * 8,
                    top: sizes!.heightRatio * 8,
                    child: GestureDetector(
                      onTap: () => widget.onCreditPress.call(),
                      child: Container(
                        height: sizes!.heightRatio * 36,
                        width: sizes!.widthRatio * 36,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/svg/credit_info.svg"),
                      ),
                    ),
                  )
                ],
              ),

              CommonPadding.sizeBoxWithHeight(height: 16),

              /// Location Heart
              Column(
                children: [
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
                          text: widget.tripLocation,
                          fontFamily: Assets.basement,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.mainBlack100,
                          lines: 2,
                        ),
                      ),
                      CommonPadding.sizeBoxWithWidth(width: 6),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => widget.onFavouritePress.call(),
                            child: Container(
                              color: Colors.transparent,
                              child: widget.isFavouriteTrip
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
                            onTap: () => widget.onSharePress.call(),
                            child: Container(
                                color: Colors.transparent,
                                child: SvgPicture.asset(
                                  "assets/svg/share_icon.svg",
                                  height: sizes!.heightRatio * 24,
                                  width: sizes!.widthRatio * 24,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 6),

                  ///User Row
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //User Image
                        const CircleAvatar(
                          radius: 20,
                          foregroundImage:
                              AssetImage("assets/png/user_avatar_two.png"),
                          // backgroundImage: CachedNetworkImageProvider(
                          //   "https://picsum.photos/200/300",
                          // ),
                        ),
                        CommonPadding.sizeBoxWithWidth(width: 8),
                        GetGenericText(
                          text: widget.userName,
                          fontFamily: Assets.aileron,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.mainBlack100,
                          lines: 1,
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/svg/save_icon.svg",
                          height: sizes!.heightRatio * 16,
                          width: sizes!.widthRatio * 12,
                        ),
                        CommonPadding.sizeBoxWithWidth(width: 4),
                        GetGenericText(
                          text: "${widget.numberOfSaves} Saves",
                          fontFamily: Assets.aileron,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.mainBlack100,
                          lines: 1,
                        ),
                      ],
                    ),
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 16),

                  /// This Trip
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          color: AppColors.mainBlack100,
                          lines: 3,
                        ),
                      )
                    ],
                  ),

                  ///End
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
