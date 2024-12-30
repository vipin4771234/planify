// Created by Tayyab Mughal on 29/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/error_model/CheckAvailableTripErrorResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/gift/RadeemGiftCodeResponse.dart';
import 'package:planify/app_data_models/subscriptions/UserSubscriptionResponse.dart';
import 'package:planify/app_data_models/trips/CheckAvailableTripResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';

class SubscriptionProvider extends ChangeNotifier {
  BuildContext? context;

  // Loader and Logger
  final _loader = Loader();
  final _logger = Logger();
  bool isDataLoaded = false;
  bool isRadeemGiftCode = false;

  int isLoadingPackages = 0;
  bool isUnlimitedPurchased = false;
  bool isSubscriptionCompleted = false;

  //Response
  RadeemGiftCodeResponse radeemGiftCodeResponse = RadeemGiftCodeResponse();
  ErrorResponse errorResponse = ErrorResponse();
  UserSubscriptionResponse userSubscriptionResponse =
      UserSubscriptionResponse();
  CheckAvailableTripResponse checkAvailableTripResponse =
      CheckAvailableTripResponse();
  CheckAvailableTripErrorResponse checkAvailableTripErrorResponse =
      CheckAvailableTripErrorResponse();

  ///Adatpy
  List<AdaptyPaywallProduct> adaptyPaywallProduct = [];
  int isAdaptySubscriptionLoading = 0;
  bool isAdaptyServerDone = false;

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isDataLoaded = false;
  }

  /// Adapty Paywall
  Future<void> getAdaptyPaywall() async {
    try {
      final paywall =
          await Adapty().getPaywall(id: "unlimited_trips", locale: "en");
      _logger.i("paywall: $paywall");

      // the requested products array
      adaptyPaywallProduct =
          await Adapty().getPaywallProducts(paywall: paywall);
      _logger.i("adaptyProducts: ${adaptyPaywallProduct.map((e) => "$e\n")}");

      if (adaptyPaywallProduct.isNotEmpty) {
        isAdaptySubscriptionLoading = 2;
      }

      notifyListeners();
      // the requested paywall
    } on AdaptyError catch (adaptyError) {
      // handle the error
      _logger.e("onAdaptyError: $adaptyError");
      isAdaptySubscriptionLoading = 1;
    } catch (e) {
      _logger.e("onAdaptyError: $e");
      isAdaptySubscriptionLoading = 1;
    }
  }

  /// Adapty Make Purchase
  Future<void> adaptyMakePurchase({
    required AdaptyPaywallProduct product,
    required BuildContext context,
  }) async {
    try {
      _logger.i("adaptyBeforePurchase: $product");
      isSubscriptionCompleted = true;
      final result = await Adapty().makePurchase(product: product);

      // successful purchase
      _logger.i(
          "onAdaptyLevelOfAccess: ${result?.accessLevels.entries.map((e) => e)}");
      _logger.i("onAdaptySubscription: ${result?.subscriptions.keys}");
      _logger.i("onAdaptyNonSubscription: ${result?.nonSubscriptions.keys}");
      debugPrint(
          "onAdaptyNonSubscription: ${result?.nonSubscriptions.entries.map((e) => e)}");

      Map<String, dynamic> subscriptionBody = {};

      if (product.vendorProductId == "in_app_planify_8999_1y") {
        _logger.i("VendorProductId: ${product.vendorProductId}");

        /// Getting non-Subscription response
        result?.subscriptions.forEach((key, value) {
          ///Adding value in body
          debugPrint("loopKey: $key");
          subscriptionBody = {
            "purchaseId": "in_app_planify_8999_1y", //value.purchase
            "store": value.store.toString(),
            "vendorProductId": value.vendorProductId.toString(),
            "vendorTransactionId": value.vendorTransactionId.toString(),
            "purchasedAt": value.activatedAt.toString(),

            ///TODO: Uncomment the value.isSandbox for the production
            "isSandbox": value.isSandbox, //value.isSandbox,
            "isRefund": value.isRefund,
            "isConsumable": true,
            "isActive": value.isActive,
            "activatedAt": value.activatedAt.toString(),
            "renewedAt": value.renewedAt.toString(),
            "expiresAt": value.expiresAt.toString(),
            "willRenew": value.willRenew,
            "unsubscribedAt": value.unsubscribedAt
          };
        });
      } else if (product.vendorProductId == "in_app_planify_3999_1f") {
        _logger.i("VendorProductId: ${product.vendorProductId}");

        /// Getting non-Subscription response
        result?.nonSubscriptions.forEach((key, value) {
          ///Adding value in body
          debugPrint("loopKey: $key");
          subscriptionBody = {
            "purchaseId": value.first.purchaseId.toString(),
            "store": value.first.store.toString(),
            "vendorProductId": value.first.vendorProductId.toString(),
            "vendorTransactionId": value.first.vendorTransactionId.toString(),
            "purchasedAt": value.first.purchasedAt.toString(),

            ///Uncomment value.first.isSandbox for the production
            "isSandbox": value.first.isSandbox,
            "isRefund": value.first.isRefund,
            "isConsumable": value.first.isConsumable,
            "isActive": result.accessLevels['premium']?.isActive ?? false,
            "activatedAt":
                result.accessLevels['premium']?.activatedAt.toString() ?? "",
            "renewedAt":
                result.accessLevels['premium']?.renewedAt.toString() ?? "",
            "expiresAt":
                result.accessLevels['premium']?.expiresAt.toString() ?? "",
            "willRenew": result.accessLevels['premium']?.willRenew ?? false,
            "unsubscribedAt": result.accessLevels['premium']?.unsubscribedAt,
          };
        });
      } else {
        _logger.i("VendorProductId: ${product.vendorProductId}");

        /// Getting non-Subscription response
        result?.nonSubscriptions.forEach((key, value) {
          ///Adding value in body
          debugPrint("loopKey: $key");
          subscriptionBody = {
            "purchaseId": value.first.purchaseId.toString(),
            "store": value.first.store.toString(),
            "vendorProductId": value.first.vendorProductId.toString(),
            "vendorTransactionId": value.first.vendorTransactionId.toString(),
            "purchasedAt": value.first.purchasedAt.toString(),

            ///Uncomment value.first.isSandbox for the production
            "isSandbox": value.first.isSandbox,
            "isRefund": value.first.isRefund,
            "isConsumable": value.first.isConsumable,
            "isActive": result.accessLevels['premium']?.isActive ?? false,
            "activatedAt":
                result.accessLevels['premium']?.activatedAt.toString() ?? "",
            "renewedAt":
                result.accessLevels['premium']?.renewedAt.toString() ?? "",
            "expiresAt":
                result.accessLevels['premium']?.expiresAt.toString() ?? "",
            "willRenew": result.accessLevels['premium']?.willRenew ?? false,
            "unsubscribedAt": result.accessLevels['premium']?.unsubscribedAt,
          };
        });
      }

      _logger.i("premium is ${result?.accessLevels['premium']?.isActive}");
      _logger.i("subscriptionBody: $subscriptionBody");

      if (result?.accessLevels['premium']?.isActive ?? false) {
        // grant access to premium features
        _logger
            .i("accessLevels is ${result?.accessLevels['premium']?.isActive}");

        if (subscriptionBody.isNotEmpty) {
          if (context.mounted) {
            await _makeAdaptyServerSubscription(
              mapBody: subscriptionBody,
              context: context,
            );
          }
        }
      } else {
        _logger.i("make user premium");

        if (subscriptionBody.isNotEmpty) {
          if (context.mounted) {
            await _makeAdaptyServerSubscription(
              mapBody: subscriptionBody,
              context: context,
            );
          }
        }
      }

      notifyListeners();
    } on AdaptyError catch (adaptyError) {
      // handle the error
      _logger.e("onAdaptyMakePurchaseError: $adaptyError");
    } catch (e) {
      _logger.e("onAdaptyMakePurchaseError: $e");
    }
  }

  ///  Send subscription data to server
  Future<void> _makeAdaptyServerSubscription({
    required Map<String, dynamic> mapBody,
    required BuildContext context,
  }) async {
    try {
      // _loader.showAppLoaderWithoutBg(context: context);
      isAdaptyServerDone = false;

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };

      _logger.i("header: $header \n URL: $makeSubscriptionApiUrl");
      _logger.i("makeBody:$mapBody");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: makeSubscriptionApiUrl,
        myHeaders: header,
        body: mapBody,
      );
      _logger.i("onAPICallResponse: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          //Error
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          Toasts.getErrorToast(text: errorResponse.message);
          isAdaptyServerDone = false;
          isSubscriptionCompleted = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
          }
        } else {
          // User Subscription Response
          userSubscriptionResponse = await Models.getModelObject(
            Models.makeSubscriptionModel,
            response.data,
          );

          if (userSubscriptionResponse.code == 1) {
            _logger.i(
                "userSubscriptionResponse: ${userSubscriptionResponse.toJson()}");
            //Success
            Toasts.getSuccessToast(text: userSubscriptionResponse.message);
            isAdaptyServerDone = true;
            isSubscriptionCompleted = false;
            if (context.mounted) {
              _loader.hideAppLoader(context: context);
            }
          } else {
            //Error
            Toasts.getErrorToast(text: userSubscriptionResponse.message);
            isAdaptyServerDone = false;
            isSubscriptionCompleted = false;
            if (context.mounted) {
              _loader.hideAppLoader(context: context);
            }
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      _loader.hideAppLoader(context: context);
      isAdaptyServerDone = false;
      isSubscriptionCompleted = false;
      _logger.e("onError: ${e.toString()}");
    }
  }

  ///  Trip Favorite
  Future<void> radeemGiftCode({
    required String giftCode,
    required BuildContext context,
  }) async {
    try {
      _loader.showAppLoader(context: context);
      isRadeemGiftCode = false;

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };

      _logger.i("header: $header \n URL: $radeemGiftCodeApiUrl");
      Map<String, dynamic> body = {
        "code": giftCode,
      };

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: radeemGiftCodeApiUrl,
        myHeaders: header,
        body: body,
      );
      _logger.i("onAPICallResponse: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.e("errorResponse: ${errorResponse.toJson()}");
          // networkState = NetworkState.error;
          Toasts.getErrorToast(text: errorResponse.message);
          isRadeemGiftCode = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
          }
        } else {
          /// Redeem Gift Code Response
          radeemGiftCodeResponse = await Models.getModelObject(
            Models.radeemCodeModel,
            response.data,
          );

          if (radeemGiftCodeResponse.code == 1) {
            _logger.i(
                "radeemGiftCodeResponse: ${radeemGiftCodeResponse.toJson()}");
            //Success
            isRadeemGiftCode = true;
            await checkAvailableTrip();
            if (context.mounted) {
              _loader.hideAppLoader(context: context);
            }
          } else {
            //Error
            Toasts.getErrorToast(text: radeemGiftCodeResponse.message);
            isRadeemGiftCode = false;
            if (context.mounted) {
              _loader.hideAppLoader(context: context);
            }
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      _loader.hideAppLoader(context: context);
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// check Available Trip
  Future<void> checkAvailableTrip() async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $availableTripsCountApiUrl");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: availableTripsCountApiUrl,
        myHeaders: header,
      );
      _logger.i("response: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          /// Error Response
          checkAvailableTripErrorResponse = await Models.getModelObject(
            Models.checkAvailableTripErrorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");

          /// is Unlimited Purchased
          isUnlimitedPurchased =
              checkAvailableTripErrorResponse.data!.isUnlimitedPlan!;
          debugPrint("isUnlimitedPurchased: $isUnlimitedPurchased");
        } else {
          /// Check Available Trip Response
          checkAvailableTripResponse = await Models.getModelObject(
            Models.checkAvailableTripModel,
            response.data,
          );

          /// Status Code
          if (checkAvailableTripResponse.code == 1) {
            _logger.i(
                "checkAvailableTripResponse: ${checkAvailableTripResponse.toJson()}");

            /// is Unlimited Purchased
            isUnlimitedPurchased =
                checkAvailableTripResponse.data!.isUnlimitedPlan!;
            debugPrint("isUnlimitedPurchased: $isUnlimitedPurchased");

            /// Local App Cache
            await LocalAppDatabase.setUserTrips(checkAvailableTripResponse)
                .then((_) async {
              // Available Trip
              String availableTrip =
                  LocalAppDatabase.getString(Strings.tripAvailable) ?? "";

              _logger.i("availableTrip: $availableTrip");
            }).onError((error, stackTrace) {
              _logger.e("Save Error: ${error.toString()}");
            });
          } else {}
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// Adapty Restore Purchases
  Future<void> adaptyRestorePurchases() async {
    try {
      final profile = await Adapty().restorePurchases();
      // check the access level
      _logger.i("profile: $profile");
    } on AdaptyError catch (adaptyError) {
      // handle the error
      _logger.e("onAdaptyRestorePurchasesError: $adaptyError");
    } catch (e) {
      _logger.e("onAdaptyRestorePurchasesError: $e");
    }
  }
}
