// Created by Tayyab Mughal on 17/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:planify/app_data_models/trips/GetPublicTripResponse.dart';
import 'package:planify/app_languages/language_constants.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/pop_ups/pop_ups.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/main_home_screens/explore_screens/explore_provider.dart';
import 'package:planify/screens/main_home_screens/main_home_provider.dart';
import 'package:planify/screens/subscription_screens/subscription_provider.dart';
import 'package:planify/screens/subscription_screens/subscription_screen.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:planify/screens/trip_itinerary_detail_screens/trip_itinerary_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:planify/screens/setting_screens/currency_setting_screens/currency_provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  //Providers
  late ExploreProvider exploreProvider;
  late SubscriptionProvider subscriptionProvider;
  late MainHomeProvider mainHomeProvider;

  // Is Trip Selected
  bool isTripSelected = true;
  bool isLoadingState = false;
  bool isLike = false;

  //Placeholder Video
  var placeholderVideo =
      "https://res.cloudinary.com/deqca5vnt/video/upload/eo_27,so_0/v1687245081/_UTF-8_B_UGxhY2Vob2xkZXIgUGxhbmlmeSAtIFNvbmlkby1EaXNwb3Np___UTF-8_B_dGl2b3MgQXBwbGUgSEQgKGNhbGlkYWQgbWHMgXhpbWEpLm00dg___dy43zf.mp4";

  //Local Cache
  var email = LocalAppDatabase.getString(Strings.loginEmail) ?? "";
  var token = LocalAppDatabase.getString(Strings.loginUserToken) ?? "";
  var username = LocalAppDatabase.getString(Strings.loginFirstName) ?? "";
  late CurrencyProvider currencyProvider;
  //App Links
  var appleAppShorterLink = "https://apple.co/3CklEaK";
  var googleAppShorterLink = "https://bit.ly/3qwGlh4";

  @override
  void initState() {
    super.initState();
    currencyProvider = CurrencyProvider();
    currencyProvider = Provider.of<CurrencyProvider>(context, listen: false);
    currencyProvider.init(context: context);

    /// Explore Provider
    exploreProvider = ExploreProvider();
    exploreProvider = Provider.of<ExploreProvider>(context, listen: false);

    /// Subscription Provider
    subscriptionProvider = SubscriptionProvider();
    subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);

    mainHomeProvider = MainHomeProvider();
    mainHomeProvider = Provider.of<MainHomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      exploreProvider.init(context: context);
      subscriptionProvider.init(context: context);
    });

    debugPrint("calling Counts");
    exploreProvider.getTripAndUserCounts();

    // If user is login-in
    email != "" && token != ""
        ? exploreProvider.getAllPublicTripsWithToken()
        : exploreProvider.getAllPublicTripsWithoutToken();

    // // If user is login-in
    // email != "" && token != "" ? exploreProvider.checkAvailableTrip() : null;

    // If user is login-in
    email != "" && token != "" ? subscriptionProvider.getAdaptyPaywall() : null;
    // saveCurrency();
    firebaseNotification();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<void> saveCurrency() async {
  //   var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
  //   print(
  //       '${format.currencySymbol} ${format.currencyName} currencySymboldfjlksfjlsdjfd');
  //   currencyProvider.updateUserCurrency(
  //       currency: format.currencyName!, context: context);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('currencyName',
  //       format.currencyName != null ? format.currencyName! : 'EURO');
  // }

  //Firebase Notification
  Future<void> firebaseNotification() async {
    /// Foreground Notification While the app running state
    // On Message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('onExplore: ${message.data}');

        var isType = message.data['type'];
        debugPrint("isType: $isType");
        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification: ${message.notification!.title}, ${message.notification!.body}');
        }

        if (isType == 'trip') {
          // Show Trip Alert
          _showTripReadyAlert(context: context);
          debugPrint("NotificationType is: $isType");
        } else if (isType == "video") {
          debugPrint("NotificationType is: $isType");
        } else {
          debugPrint("NotificationType is: $isType");
        }
      } catch (e) {
        debugPrint("onMessageError: $e");
      }
    });

    // On Message Opened App
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('onExplore: ${message.data}');

        var isType = message.data['type'];
        debugPrint("isType: $isType");
        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification: ${message.notification!.title}, ${message.notification!.body}');
        }

        if (isType == 'trip') {
          // Show Trip Alert
          _showTripReadyAlert(context: context);
          debugPrint("NotificationType is: $isType");
        } else if (isType == "video") {
          debugPrint("NotificationType is: $isType");
        } else {
          debugPrint("NotificationType is: $isType");
        }
      } catch (e) {
        debugPrint("onMessageError: $e");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Providers
    Provider.of<ExploreProvider>(context, listen: true);
    Provider.of<SubscriptionProvider>(context, listen: true);
    Provider.of<MainHomeProvider>(context, listen: true);
    return Scaffold(
      appBar: MainAppBar.mainAppBar(
        email: email,
        token: token,
        isBadge: exploreProvider.isNewNotificationShowBadge,
        context: context,
      ),
      body: SafeArea(
        child: Container(
          height: sizes!.height,
          width: sizes!.width,
          color: AppColors.gradientBlueLinearOne,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonPadding.sizeBoxWithHeight(height: 30),

                /// Trip Counter Container
                TripCounterContainer(
                  counter: exploreProvider.tripCount,
                  numberOfUsers: exploreProvider.userCount,
                ),

                CommonPadding.sizeBoxWithHeight(height: 20),

                ///Redeemed Container
                // _redeemedContainer(
                //   isLoadingState: isLoadingState,
                //   onPress: () async {
                //     /// If user login-in
                //     if (email != "" && token != "") {
                //       setState(() {
                //         isLoadingState = true;
                //       });
                //
                //       /// Gift Code Generator
                //       await exploreProvider.giftCodeGenerator(context: context);
                //       if (exploreProvider.isGiftCode) {
                //         setState(() {
                //           isLoadingState = false;
                //         });
                //
                //         if (context.mounted) {
                //           /// Redeemed Gift Alert
                //           _showRedeemedGiftAlert(
                //             getCode: exploreProvider
                //                 .generateGiftCodeResponse.data!.code
                //                 .toString(),
                //             context: context,
                //           );
                //         }
                //       } else {
                //         setState(() {
                //           isLoadingState = false;
                //         });
                //       }
                //     } else {
                //       /// Login PopUp
                //       PopUps.loginRequiredPopUp(
                //         context: context,
                //       );
                //     }
                //   },
                // ),
                // CommonPadding.sizeBoxWithHeight(height: 20),
                _carbonContainer(),
                CommonPadding.sizeBoxWithHeight(height: 25),
                GetGenericText(
                  text: translation(context).takeALook,
                  //"Take a look at trips created by others 🔥",
                  fontFamily: Assets.basement,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite,
                  lines: 2,
                ),
                CommonPadding.sizeBoxWithHeight(height: 20),

                /// Trip List
                exploreProvider.isPublicTrip == 2
                    ? Flexible(
                        child: ListView.builder(
                          itemCount: exploreProvider
                              .getPublicTripResponse.data!.trips!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            //Data
                            var data = exploreProvider
                                .getPublicTripResponse.data!.trips![index];
                            //Trip
                            var tripId = data.id!;
                            var userName =
                                "${data.owner?.firstName ?? "Test"} ${data.owner?.lastName ?? "One"}";
                            var location = data.destination!;
                            var distance = data.distance.toString();

                            //DateTime Parse
                            var createdAtAgo =
                                DateTime.parse(data.createdAt.toString());
                            var savedBy = data.savedBy.toString();
                            var shareCode = data.shareCode.toString();
                            var isSavedByMe = data.isSavedByMe!;

                            ///Video
                            var videoLink =
                                data.video?.link ?? placeholderVideo;
                            debugPrint("videoLink $index: ${data.video?.link}");

                            var videoCreditList = data.video?.creators;

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: sizes!.heightRatio * 10,
                              ),
                              child: GetTripContainer(
                                key: Key("$index"),
                                videoLink: videoLink,
                                //videoLinkTwo,
                                numberOfSaves: savedBy,

                                ///TODO: UI not updating real-time
                                isFavouriteTrip: isSavedByMe,
                                kiloMeterAway: distance,
                                createdAtAgo: createdAtAgo,
                                userName: userName,
                                tripLocation: location,
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
                                  ///Favorite Press
                                  await favoritePress(
                                    tripId: tripId,
                                    isUserLike: isSavedByMe,
                                  );
                                },
                                onSharePress: () async {
                                  /// if user log-in
                                  if (email != "" && token != "") {
                                    await Share.share(
                                      "${username.toUpperCase()} has shared with you their DREAM TRIP. Please add this code: $shareCode on My Trips tab or click the link below. \n\n iOS App Link: \n $appleAppShorterLink \n\n Android App Link: \n $googleAppShorterLink",
                                    );
                                  } else {
                                    PopUps.loginRequiredPopUp(
                                      context: context,
                                    );
                                  }
                                },
                                onTripPress: () {
                                  /// Show Trip Detail
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TripItineraryDetailScreen(
                                        isMyTrips: false,
                                        tripId: tripId,
                                        userName: userName,
                                        videoLink: videoLink,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : exploreProvider.isPublicTrip == 1
                        ? Center(
                            child: GetGenericText(
                              text: exploreProvider.errorResponse.message ?? "",
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
                CommonPadding.sizeBoxWithHeight(height: 20),
              ],
            ).get16HorizontalPadding(),
          ),
        ),
      ),
    );
  }

  ///Favorite Press
  Future<void> favoritePress({
    required String tripId,
    required bool isUserLike,
  }) async {
    ///If user is log-in
    if (email != "" && token != "") {
      setState(() {
        isUserLike = !isUserLike;
        debugPrint("isUserLike: $isUserLike");
      });

      // mark Trip Favorite
      await exploreProvider.markTripFavorite(
        isLike: isUserLike,
        tripId: tripId,
      );

      /// Trip Saved
      if (exploreProvider.isTripSaved) {
        if (context.mounted) {
          /// If user Like the trip
          if (isUserLike == true) {
            _tripSavedPopUp(
              context: context,
            );
          }
        }
      }
    } else {
      ///Show Login PopUp
      PopUps.loginRequiredPopUp(
        context: context,
      );
    }
  }

  /// Redeemed Container
  Widget _redeemedContainer({
    required bool isLoadingState,
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          height: sizes!.heightRatio * 70,
          width: sizes!.widthRatio * 360,
          decoration: BoxDecoration(
            color: AppColors.mainWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.mainBlack100, width: 3),
            boxShadow: const [
              BoxShadow(
                color: AppColors.mainBlack100,
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(-2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizes!.widthRatio * 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.transparent,
                  child: Lottie.asset(
                    'assets/json/happy_giftbox.json',
                    height: sizes!.heightRatio * 48,
                    width: sizes!.widthRatio * 48,
                    fit: BoxFit.cover,
                  ),
                ),
                isLoadingState == false
                    ? const GetGenericText(
                        text: "Gift a Trip",
                        fontFamily: Assets.aileron,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainBlack100,
                        lines: 2,
                      )
                    : const CircularProgressIndicator(),
                Container(
                  color: Colors.transparent,
                  child: Lottie.asset(
                    'assets/json/happy_giftbox.json',
                    height: sizes!.heightRatio * 48,
                    width: sizes!.widthRatio * 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  /// Carbon Container
  Widget _carbonContainer() => Container(
        height: sizes!.heightRatio * 65,
        width: sizes!.widthRatio * 360,
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.greenColor, width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizes!.widthRatio * 8,
            vertical: Platform.isIOS
                ? sizes!.heightRatio * 4
                : sizes!.heightRatio * 8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/greeny_heart_icon.svg",
                height: sizes!.heightRatio * 18,
                width: sizes!.widthRatio * 20,
              ),
              CommonPadding.sizeBoxWithWidth(width: 10),
              Expanded(
                child: GetGenericText(
                  text:
                      "Planify is committed to the Global Program on Sustainability for negative carbon footprint by 2030",
                  fontFamily: Assets.aileron,
                  fontSize: Platform.isIOS ? 16 : 14,
                  fontWeight:
                      Platform.isIOS ? FontWeight.w500 : FontWeight.w400,
                  color: AppColors.mainBlack100,
                  lines: 3,
                ),
              )
            ],
          ),
        ),
      );

  /// Appears on when the home screen loaded
  Future<void> _showRedeemedGiftAlert({
    required String getCode,
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
                    height: sizes!.heightRatio * 240,
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
                            text: "You’ve successfully redeemed a trip.",
                            fontFamily: Assets.basement,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 3,
                            textAlign: TextAlign.center,
                          ).get16HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 12),
                          const GetGenericText(
                            text: "Click on the button below to view.",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainBlack100,
                            lines: 4,
                            textAlign: TextAlign.center,
                          ).get16HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 20),
                          // Gradient Get Start PopUp Button

                          GetStartFullBlackButton(
                            title: "Share with friends",
                            onPress: () {
                              Share.share(
                                "${username.toUpperCase()} has sent you a GIFT DREAM TRIP. Use this code: $getCode inside the app to redeem it. \n\n iOS App Link: \n $appleAppShorterLink \n\n Android App Link: \n $googleAppShorterLink",
                              ).then(
                                (value) => Navigator.pop(context),
                              );
                            },
                          ).get10HorizontalPadding(),
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

  /// Trip Save PopUp
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
                              Toasts.getWarningToast(text: "Please wait...");

                              //Check User's Available Trips
                              await exploreProvider.checkAvailableTrip();
                              if (exploreProvider.isAvailable > 0) {
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TripWithScreen(),
                                    ),
                                  ).then((value) => Navigator.pop(context));
                                }
                              } else {
                                /// Navigate to Subscription Screen
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SubscriptionScreen(), //SubscriptionScreen
                                    ),
                                  ).then((value) => Navigator.pop(context));
                                }
                              }
                            },
                          ).get10HorizontalPadding(),
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

  /// TODO: When the trip come
  Future<void> _showTripReadyAlert({
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
                        ? sizes!.heightRatio * 300
                        : sizes!.heightRatio * 320,
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
                            text: "Trip successfully generated!",
                            fontFamily: Assets.basement,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 3,
                            textAlign: TextAlign.center,
                          ).get10HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 12),
                          const GetGenericText(
                            text: "Click on the button below to see it 😍",
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainBlack100,
                            lines: 4,
                            textAlign: TextAlign.center,
                          ).get16HorizontalPadding(),

                          CommonPadding.sizeBoxWithHeight(height: 20),
                          // Gradient Get Start PopUp Button

                          _gradientButtonPopUpButton(
                            onPress: () {
                              //TODO:
                              Navigator.pop(context);
                              //Navigate to My Trips Screen
                              mainHomeProvider.onItemTapped(1);
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
                                          //decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
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

  // Gradient Button PopUp Button
  Widget _gradientButtonPopUpButton({
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
            "SEE MY DREAM TRIP",
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
