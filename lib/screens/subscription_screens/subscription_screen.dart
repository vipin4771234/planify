// Created by Tayyab Mughal on 21/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/subscription_screens/subscription_provider.dart';
import 'package:provider/provider.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with SingleTickerProviderStateMixin {
  ///Provider
  late SubscriptionProvider subscriptionProvider;

  ///Controller
  final _verifyCodeController = TextEditingController();
  final _loader = Loader();
  bool onUserValidationClick = false;
  bool isVerifyCode = true;

  //Timer
  int beginHour = 6;
  int beginMinute = 1;
  int beginSecond = 0;
  int endHour = 0;
  int endMinute = 0;
  int endSecond = 0;
  String? currencyCode = 'EURO';

  late final CustomTimerController _controllerTimer = CustomTimerController(
    vsync: this,
    begin: Duration(
      hours: beginHour,
      minutes: beginMinute,
      seconds: beginSecond,
    ),
    end: Duration(
      hours: endHour,
      minutes: endMinute,
      seconds: endSecond,
    ),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.milliseconds,
  );

  // final _productIds = {
  //   'in_app_planify_1999_1f',
  //   'in_app_planify_3999_1f',
  //   'in_app_planify_8999_1y',
  // };

  //step 0
  // final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  // late StreamSubscription<List<PurchaseDetails>> _subscription;
  // List<ProductDetails> _products = <ProductDetails>[];
  // List<String> _notFoundIds = <String>[];
  // bool _isAvailable = false;
  // bool _loading = true;
  // String? _queryProductError;
  // bool _purchasePending = false;

  // UserData? userData;

//   //Subscription 01
//   String sub1Id =
//       Platform.isAndroid ? 'android.test.purchased' : 'your_ios_sub1_id';
//
// //Subscription 02
//   String sub2Id =
//       Platform.isAndroid ? 'silver_subscription' : 'your_ios_sub2_id';

  // final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  // late StreamSubscription<List<PurchaseDetails>> _subscription;

  @override
  void initState() {
    // ///step 1
    // final Stream<List<PurchaseDetails>> purchaseUpdated =
    //     _inAppPurchase.purchaseStream;
    //
    // _subscription = purchaseUpdated.listen(
    //   (List<PurchaseDetails> purchaseDetailsList) {
    //     _listenToPurchaseUpdated(purchaseDetailsList);
    //     debugPrint("PurchaseDetailList: $purchaseDetailsList");
    //   },
    //   onDone: () {
    //     _subscription.cancel();
    //   },
    //   onError: (Object error) {
    //     debugPrint("error :${error.toString()}");
    //   },
    // );
    //
    // ///Step: 2
    // initStoreInfo();
    getCurrency();
    _controllerTimer.start();
    subscriptionProvider = SubscriptionProvider();
    subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      subscriptionProvider.init(context: context);
    });

    //Adapty Purchases
    subscriptionProvider.getAdaptyPaywall();
    Adapty().didUpdateProfileStream.listen((profile) {
      // handle any changes to subscription state
      debugPrint("adaptyProfile: $profile");
    });
    checkAvailableTrips();
    super.initState();
  }

  Future<String?> getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cName = prefs.getString('currencyName');
    print("cNamecName $cName");
    setState(() {
      currencyCode = cName;
    });
    return cName;
  }

  // Future<void> initStoreInfo() async {
  //   // If Not Available
  //   final bool isAvailable = await _inAppPurchase.isAvailable();
  //   if (!isAvailable) {
  //     setState(() {
  //       _isAvailable = isAvailable;
  //       _products = <ProductDetails>[];
  //       _notFoundIds = <String>[];
  //       _loading = false;
  //     });
  //     return;
  //   }
  //
  //   // Check the Platform
  //   if (Platform.isIOS) {
  //     final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
  //         _inAppPurchase
  //             .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
  //     await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
  //   }
  //
  //   /// Query Product Details
  //   final ProductDetailsResponse productDetailResponse = await _inAppPurchase
  //       .queryProductDetails(_productIds); //_subscriptionProductIds
  //
  //   //If Error
  //   if (productDetailResponse.error != null) {
  //     setState(() {
  //       _queryProductError = productDetailResponse.error!.message;
  //       _isAvailable = isAvailable;
  //       _products = productDetailResponse.productDetails;
  //       _notFoundIds = productDetailResponse.notFoundIDs;
  //       debugPrint('_notFoundIds :: ${_notFoundIds.toList()}');
  //       _loading = false;
  //     });
  //     return;
  //   }
  //
  //   //Product Detail is Empty
  //   if (productDetailResponse.productDetails.isEmpty) {
  //     setState(() {
  //       _queryProductError = null;
  //       _isAvailable = isAvailable;
  //       _products = productDetailResponse.productDetails;
  //       _notFoundIds = productDetailResponse.notFoundIDs;
  //       debugPrint('_notFoundIds : ${_notFoundIds.toList()}');
  //       debugPrint(
  //           'productDetailResponse error :: ${productDetailResponse.error}');
  //       _loading = false;
  //     });
  //     return;
  //   } else {
  //     debugPrint('onProductDetail is not empty');
  //   }
  //
  //   setState(() {
  //     _isAvailable = isAvailable;
  //     _products = productDetailResponse.productDetails;
  //     debugPrint("Product-Details:${_products.map((e) => e.title)}");
  //     _notFoundIds = productDetailResponse.notFoundIDs;
  //     debugPrint('No Products :: ${_notFoundIds.toList()}');
  //     _purchasePending = false;
  //     _loading = false;
  //   });
  // }

  // _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
  //   // Loop-throw
  //   for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
  //     //Check Status
  //     if (purchaseDetails.status == PurchaseStatus.pending) {
  //       debugPrint("purchase Status: ${purchaseDetails.status}");
  //
  //       ///Step: 1, case:1
  //       // showPendingUI();
  //     } else {
  //       if (purchaseDetails.status == PurchaseStatus.error) {
  //         debugPrint("purchase Status: ${purchaseDetails.status}");
  //
  //         ///Step: 1, case:2
  //         //handleError(purchaseDetails.error!);
  //       } else if (purchaseDetails.status == PurchaseStatus.purchased ||
  //           purchaseDetails.status == PurchaseStatus.restored) {
  //         debugPrint("purchase Status: ${purchaseDetails.status}");
  //
  //         var date = int.parse(purchaseDetails.transactionDate!);
  //         DateTime transactionDate = DateTime.fromMillisecondsSinceEpoch(date);
  //         var format = DateFormat("dd/MM/yyyy hh:mm").format(transactionDate);
  //
  //         final purchaseBody = {
  //           "id": "",
  //           "title": "",
  //           "description": "",
  //           "price": "",
  //           "rawPrice": "",
  //           "currencyCode": "",
  //           "currencySymbol": "",
  //           "productID": purchaseDetails.productID,
  //           "purchaseID": purchaseDetails.purchaseID,
  //           "transactionDate": format,
  //           //purchaseDetails.transactionDate,
  //           //DateFormat("dd/MM/YYYY hh:mm").format(date),
  //           // "serverVerificationData":
  //           //     purchaseDetails.verificationData.serverVerificationData,
  //           // "localVerificationData":
  //           //     purchaseDetails.verificationData.localVerificationData,
  //           "source": purchaseDetails.verificationData.source,
  //         };
  //
  //         debugPrint("purchaseBody: $purchaseBody");
  //
  //         Toasts.getSuccessToast(text: "Thank you for purchased");
  //
  //         ///Step: 1, case:3
  //         //verifyAndDeliverProduct(purchaseDetails);
  //       } else if (purchaseDetails.status == PurchaseStatus.restored) {
  //         debugPrint("purchase Status: ${purchaseDetails.status}");
  //       }
  //       if (purchaseDetails.pendingCompletePurchase) {
  //         debugPrint("pendingCompletePurchase: ${purchaseDetails.status}");
  //         await _inAppPurchase.completePurchase(purchaseDetails);
  //       }
  //     }
  //   }
  // }

  @override
  void dispose() {
    _controllerTimer.dispose();

    // if (Platform.isIOS) {
    //   final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
    //       _inAppPurchase
    //           .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    //   iosPlatformAddition.setDelegate(null);
    // }
    // _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SubscriptionProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.gradientBlueLinearTwo,
        backgroundColor: AppColors.gradientBlueLinearOne,
        elevation: 0,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // await _inAppPurchase.restorePurchases();
      //     // await subscriptionProvider.adaptyRestorePurchases();
      //   },
      // ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: sizes!.height,
          width: sizes!.width,
          color: AppColors.gradientBlueLinearOne,
          child: SafeArea(
            child: Column(
              children: [
                const GetGenericText(
                  text: "Unlock the best experiential trips ✈️😍",
                  fontFamily: Assets.aileron,
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite,
                  lines: 3,
                ),

                ///Enter Trip Code
                //  CommonPadding.sizeBoxWithHeight(height: 20),
                //  Visibility(
                //    visible: isVerifyCode,
                //    child: Row(
                //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //      crossAxisAlignment: CrossAxisAlignment.center,
                //      children: [
                //        /// Enter Code
                //        Expanded(
                //          child: TextFormField(
                //            onChanged: (_) => setState(() {}),
                //            autocorrect: true,
                //            controller: _verifyCodeController,
                //            keyboardType: TextInputType.text,
                //            maxLines: 1,
                //            style: const TextStyle(
                //              color: AppColors.gray5Color,
                //              fontFamily: Assets.aileron,
                //              fontSize: 16,
                //              fontWeight: FontWeight.w400,
                //            ),
                //            decoration: InputDecoration(
                //              hintText: "Enter code",
                //              hintStyle: const TextStyle(
                //                color: AppColors.gray5Color,
                //                fontFamily: Assets.aileron,
                //                fontSize: 16,
                //                fontWeight: FontWeight.w400,
                //              ),
                //              // errorText:
                //              //     onUserValidationClick ? _verifyTextError : null,
                //              contentPadding: EdgeInsets.only(
                //                bottom: sizes!.heightRatio * 15,
                //                top: sizes!.heightRatio * 15,
                //                right: sizes!.widthRatio * 10,
                //                left: sizes!.widthRatio * 10,
                //              ),
                //              //  errorText: "errorText",
                //              errorBorder: OutlineInputBorder(
                //                borderSide: BorderSide(
                //                  color: onUserValidationClick
                //                      ? AppColors.redTwoColor
                //                      : AppColors.mainBlack100,
                //                  width: 2,
                //                ),
                //                borderRadius: BorderRadius.circular(10.0),
                //              ),
                //              enabledBorder: OutlineInputBorder(
                //                borderSide: const BorderSide(
                //                  color: AppColors.mainBlack100,
                //                  width: 2,
                //                ),
                //                borderRadius: BorderRadius.circular(10.0),
                //              ),
                //              focusedErrorBorder: OutlineInputBorder(
                //                borderSide: BorderSide(
                //                  color: onUserValidationClick
                //                      ? AppColors.redTwoColor
                //                      : AppColors.mainBlack100,
                //                  width: 2,
                //                ),
                //                borderRadius: BorderRadius.circular(10.0),
                //              ),
                //              focusedBorder: OutlineInputBorder(
                //                borderSide: const BorderSide(
                //                  color: AppColors.mainBlack100,
                //                  width: 2,
                //                ),
                //                borderRadius: BorderRadius.circular(10.0),
                //              ),
                //            ),
                //          ),
                //        ),
                //        CommonPadding.sizeBoxWithWidth(width: 15),
                //        VerifyButtonContainer(
                //          title: "Verify",
                //          onPress: () {
                //            validateData();
                //          },
                //        ),
                //      ],
                //    ),
                //  ),
                //  Visibility(
                //    visible: !isVerifyCode,
                //    child: const GetGenericText(
                //      text: "Discount Generated",
                //      fontFamily: Assets.aileron,
                //      fontSize: 18,
                //      fontWeight: FontWeight.w700,
                //      color: AppColors.mainWhite,
                //      lines: 1,
                //    ).getAlign(),
                //  ),
                CommonPadding.sizeBoxWithHeight(height: 20),

                ///In-App-Purchase
                subscriptionProvider.isAdaptySubscriptionLoading == 2
                    ? Expanded(
                        child: ListView.builder(
                          itemCount:
                              subscriptionProvider.adaptyPaywallProduct.length,
                          itemBuilder: (context, index) {
                            // Data
                            var data = subscriptionProvider
                                .adaptyPaywallProduct[index];
                            //price
                            // var price = data.price.toStringAsFixed(2); previously this was causing error
                            var price = data.price;
                            debugPrint("price: ${data.price}");
                            var vendorProductID = data.vendorProductId;
                            // var currencyCode = data.currencyCode; //previously this was causing error
                            // var currencyCode = 'USD'; //use for usa
                            // var currencyCode = 'INR'; //use for india

                            // in_app_planify_8999_1y
                            //in_app_planify_1999_1f
                            //in_app_planify_3999_1f
                            if (vendorProductID == "in_app_planify_8999_1y") {
                              return SubscriptionPremiumContainer(
                                offerTitle: 'Save 70% NOW!',
                                tripTitle: "FREE Trips for 1 Year",
                                //title,
                                //'FREE Trips for 1 Year ',
                                tripPrice: "$currencyCode $price",
                                //'\$8.99',
                                tripRealPrice: '\$29.95',
                                controller: _controllerTimer,
                                onPress: () async {
                                  /// Check Available Trip
                                  // await subscriptionProvider
                                  //     .checkAvailableTrip();
                                  _loader.showAppLoaderWithoutBg(
                                      context: context);
                                  debugPrint("rannnnnnherere11111");
                                  if (subscriptionProvider
                                      .isUnlimitedPurchased) {
                                    _loader.hideAppLoader(context: context);
                                    Toasts.getWarningToast(
                                      text: "You already has Unlimited Trips",
                                    );
                                  } else {
                                    //Make Purchase
                                    if (context.mounted) {
                                      debugPrint("rannnnnnherere");
                                      await subscriptionProvider
                                          .adaptyMakePurchase(
                                        product: data,
                                        context: context,
                                      );
                                      _loader.hideAppLoader(context: context);
                                    }
                                  }
                                  _loader.hideAppLoader(context: context);
                                },
                              ).get5VerticalPadding();
                            } else if (vendorProductID ==
                                "in_app_planify_3999_1f") {
                              return SubscriptionPremiumContainer(
                                offerTitle: 'Save 60% NOW!',
                                tripTitle: "5 Trips",
                                //title,
                                //'FREE Trips for 1 Year ',
                                tripPrice: "$currencyCode $price",
                                //'\$8.99',
                                tripRealPrice: '\$9.95',
                                controller: _controllerTimer,
                                onPress: () async {
                                  /// Check Available Trip
                                  // await subscriptionProvider
                                  //     .checkAvailableTrip();
                                  _loader.showAppLoaderWithoutBg(
                                      context: context);

                                  /// IsUnlimitedPlan is true
                                  if (subscriptionProvider
                                      .isUnlimitedPurchased) {
                                    _loader.hideAppLoader(context: context);
                                    //You don't need to purchase this
                                    Toasts.getWarningToast(
                                      text: "You already has Unlimited Trips",
                                    );
                                  } else {
                                    if (context.mounted) {
                                      await subscriptionProvider
                                          .adaptyMakePurchase(
                                        product: data,
                                        context: context,
                                      );
                                      _loader.hideAppLoader(context: context);
                                    }
                                  }
                                  _loader.hideAppLoader(context: context);
                                },
                              ).get5VerticalPadding();
                            } else {
                              return SubscriptionOneTripPackageContainer(
                                title: "1 Trip", //title,
                                price: "$currencyCode $price",
                                onPress: () async {
                                  /// Check Available Trip
                                  // await subscriptionProvider
                                  //     .checkAvailableTrip();
                                  _loader.showAppLoaderWithoutBg(
                                      context: context);

                                  /// IsUnlimitedPlan is true
                                  if (subscriptionProvider
                                      .isUnlimitedPurchased) {
                                    //You don't need to purchase this
                                    _loader.hideAppLoader(context: context);
                                    Toasts.getWarningToast(
                                      text: "You already has Unlimited Trips",
                                    );
                                  } else {
                                    if (context.mounted) {
                                      await subscriptionProvider
                                          .adaptyMakePurchase(
                                        product: data,
                                        context: context,
                                      );
                                      _loader.hideAppLoader(context: context);
                                    }
                                  }
                                  _loader.hideAppLoader(context: context);
                                },
                              ).get10VerticalPadding();
                            }
                          },
                        ),
                      )
                    : subscriptionProvider.isAdaptySubscriptionLoading == 1
                        ? const Center(
                            child: GetGenericText(
                              text: "No Subscription Package Available",
                              fontFamily: Assets.aileron,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainWhite,
                              lines: 1,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),

                ///RevenueCat
                //  Expanded(
                //    child: ListView.builder(
                //      itemCount: subscriptionProvider
                //          .getAvailableStoreProductList.length,
                //      itemBuilder: (context, index) {
                //        //Data
                //        var dataStoreProduct = subscriptionProvider
                //            .getAvailableStoreProductList[index].storeProduct;
                //        //
                //        var package = subscriptionProvider
                //            .getAvailableStoreProductList[index];
                //        var tripTitle = dataStoreProduct.title;
                //        var tripPrice = dataStoreProduct.priceString;
                //
                //        // Check Data States
                //        switch (subscriptionProvider.networkState) {
                //          case NetworkState.loading:
                //            return const Center(
                //              child: CircularProgressIndicator(),
                //            );
                //          case NetworkState.data:
                //            return SubscriptionPremiumContainer(
                //              offerTitle:
                //                  index == 0 ? 'Save 70% NOW!' : "Save 60% NOW!",
                //              tripTitle: tripTitle,
                //              tripPrice: tripPrice,
                //              tripRealPrice: index == 0 ? "\$29.99" : "\$9.95",
                //              controller: _controllerTimer,
                //              onPress: () async {
                //                // Toasts.getWarningToast(text: "Try it later");
                //                await subscriptionProvider.purchasePackage(
                //                  package: package,
                //                  context: context,
                //                );
                //              },
                //            ).get5VerticalPadding();
                //          case NetworkState.error:
                //            return const Center(
                //              child: Text(
                //                'Error occurred',
                //                style: TextStyle(fontSize: 18),
                //              ),
                //            );
                //        }
                //      },
                //    ),
                //  ),

                /// Subscription Premium Container
                // SubscriptionPremiumContainer(
                //   offerTitle: 'Save 70% NOW!',
                //   tripTitle: 'FREE Trips for 1 Year ',
                //   tripPrice: '\$8.99',
                //   tripRealPrice: '\$29.95',
                //   controller: _controller,
                //   onPress: () {
                //     Toasts.getWarningToast(text: "Try it later");
                //   },
                // ),
                // CommonPadding.sizeBoxWithHeight(height: 20),
                // SubscriptionPremiumContainer(
                //   offerTitle: 'Save 60% NOW!',
                //   tripTitle: '5 trips',
                //   tripPrice: '\$3.99',
                //   tripRealPrice: '\$9.95',
                //   controller: _controller,
                //   onPress: () {
                //     Toasts.getWarningToast(text: "Try it later");
                //   },
                // ),
                // CommonPadding.sizeBoxWithHeight(height: 20),
                //
                // /// Subscription One trip Package Container
                // SubscriptionOneTripPackageContainer(
                //   onPress: () {
                //     Toasts.getWarningToast(text: "Try it later");
                //   },
                // ),
                CommonPadding.sizeBoxWithHeight(height: 20),
              ],
            ).get16HorizontalPadding(),
          ),
        ),
      ),
    );
  }

  // Future<void> buyPackage({required ProductDetails productDetails}) async {
  //   debugPrint("selected: ${productDetails.title}");
  //
  //   ///Step: 3
  //   late PurchaseParam purchaseParam;
  //
  //   if (Platform.isAndroid) {
  //     //update oldSubscription details for upgrading and downgrading subscription
  //     GooglePlayPurchaseDetails? oldSubscription;
  //
  //     // if (userData?.oldPdFromDb != null)
  //     //   oldSubscription = userData?.oldPdFromDb;
  //
  //     purchaseParam = PurchaseParam(productDetails: productDetails);
  //
  //     /// Harshi
  //     // GooglePlayPurchaseParam(
  //     // productDetails: productDetails,
  //     // applicationUserName: null,
  //     // changeSubscriptionParam: (oldSubscription != null)
  //     //     ? ChangeSubscriptionParam(
  //     //         oldPurchaseDetails: oldSubscription,
  //     //         prorationMode: ProrationMode.immediateAndChargeProratedPrice,
  //     //       )
  //     //     : null);
  //   } else {
  //     ///IOS handling
  //     purchaseParam = PurchaseParam(
  //       productDetails: productDetails,
  //       applicationUserName: null,
  //     );
  //   }
  //
  //   ///buying Subscription
  //   if (productDetails.title == "Unlimited Trips") {
  //     debugPrint("purchaseParamBuyConsumable: $purchaseParam");
  //     await _inAppPurchase
  //         .buyConsumable(purchaseParam: purchaseParam)
  //         .then((value) {
  //       debugPrint("buyConsumable:$value");
  //     });
  //   } else {
  //     debugPrint(
  //         "purchaseParamBuyNonConsumable: ${purchaseParam.productDetails}");
  //     await _inAppPurchase
  //         .buyNonConsumable(purchaseParam: purchaseParam)
  //         .then((value) {
  //       debugPrint("buyNonConsumable:$value");
  //     });
  //   }
  // }

  // Email Error Handler
  String? get _verifyTextError {
    final text = _verifyCodeController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  void validateData() async {
    FocusManager.instance.primaryFocus?.unfocus();
    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    var giftCode = _verifyCodeController.value.text.toString();

    if (giftCode.isNotEmpty) {
      // Radeem Gift Code
      await subscriptionProvider.radeemGiftCode(
        giftCode: giftCode,
        context: context,
      );
      // Is Radeem Gift Code
      if (subscriptionProvider.isRadeemGiftCode) {
        if (context.mounted) {
          Toasts.getSuccessToast(
            text: subscriptionProvider.radeemGiftCodeResponse.message,
          );
          _showAlert(context: context);
        }
        setState(() {
          isVerifyCode = !isVerifyCode;
        });
      }
    } else {
      Toasts.getWarningToast(text: "Field is required");
    }
  }

  void checkAvailableTrips() async {
    await subscriptionProvider.checkAvailableTrip();
  }

  // Appears on when the home screen loaded
  Future<void> _showAlert({
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
                    height: sizes!.heightRatio * 115,
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
                            text: "You have successfully redeemed a Trip!",
                            fontFamily: Assets.basement,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 2,
                            textAlign: TextAlign.center,
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
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.s

// class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
//   @override
//   bool shouldContinueTransaction(
//       SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
//     return true;
//   }
//
//   @override
//   bool shouldShowPriceConsent() {
//     return false;
//   }
// }
