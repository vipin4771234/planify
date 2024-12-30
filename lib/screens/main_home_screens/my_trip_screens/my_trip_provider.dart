// Created by Tayyab Mughal on 28/04/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/trips/GetMyTripResponse.dart';
import 'package:planify/app_data_models/trips/ShareTripResponse.dart';
import 'package:planify/app_data_models/trips/TripFavoriteResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTripProvider extends ChangeNotifier {
  BuildContext? context;
  final _logger = Logger();

  bool isSuccess = false;
  int isTripLoading = 0;

  bool isShareTripSaved = false;
  bool isTripSaved = false;

  ErrorResponse errorResponse = ErrorResponse();
  GetMyTripResponse getMyTripResponse = GetMyTripResponse();
  ShareTripResponse shareTripResponse = ShareTripResponse();
  TripFavoriteResponse tripFavoriteResponse = TripFavoriteResponse();

  ///Refresh the list
  var isSelectOption = "created";

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isSuccess = false;

    /// Foreground Notification While the app running state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        debugPrint('Got a message whilst in the foreground!');

        _logger.i('onExplore: ${message.data}');
        var isType = message.data['type'];
        debugPrint("isType: $isType");

        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification: ${message.notification!.title}, ${message.notification!.body}');

          ///_showTripReadyAlert(context: context);
        }

        if (isType == 'trip') {
          _logger.i("NotificationType is: $isType");
        } else if (isType == "video") {
          await getMyTrips(sortType: "created");
          _logger.i("NotificationType is: $isType");
        } else {
          _logger.i("NotificationType is: $isType");
        }
      } catch (e) {
        _logger.e("onMessageError: $e");
      }
    });
  }

  Future<void> openServiceUrl({required String serviceUrl}) async {
    final Uri url = Uri.parse(serviceUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Toasts.getErrorToast(text: "Could not launch $url");
      throw Exception('Could not launch $url');
    }
  }

  // Select Dropdown Option
  Future<void> selectDropdownOption({
    required String selectTripSort,
  }) async {
    if (selectTripSort == "Created by me") {
      isSelectOption = "created";
      await getMyTrips(sortType: "created");
    } else if (selectTripSort == "Saved by me") {
      isSelectOption = "saved";
      await getMyTrips(sortType: "saved");
    } else if (selectTripSort == "Shared with me") {
      isSelectOption = "shared";
      await getMyTrips(sortType: "shared");
    } else {
      Toasts.getWarningToast(text: "Selected: $selectTripSort");
    }
    notifyListeners();
  }

  /// Get Trip and User Counts
  Future<void> getMyTrips({
    required String sortType,
  }) async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$getMyTripApiUrl?sort=$sortType";
      _logger.i("header: $header \n URL: $url");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: url,
        myHeaders: header,
      );
      _logger.i("onAPICall: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          /// Error Response
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isSuccess = false;
          isTripLoading = 1;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// Get My Trip Response
          getMyTripResponse = await Models.getModelObject(
            Models.getMyTripModel,
            response.data,
          );

          if (getMyTripResponse.code == 1) {
            _logger.i("getMyTripResponse: ${getMyTripResponse.toJson()}");
            //Success
            isSuccess = true;
            isTripLoading = 2;
          } else {
            //Toasts.getErrorToast(text: getMyTripResponse.message);
            //Success
            isSuccess = false;
            isTripLoading = 1;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isTripLoading = 1;
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// Get Trip and User Counts
  Future<void> shareTripSave({
    required String shareCode,
  }) async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $tripShareTripApiUrl");
      final body = {
        "shareCode": shareCode,
      };

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: tripShareTripApiUrl,
        myHeaders: header,
        body: body,
      );
      _logger.i("onAPICall: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          /// Error Response
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isShareTripSaved = false;

          Toasts.getErrorToast(text: errorResponse.data!.message.toString());
        } else {
          /// Share Trip Response
          shareTripResponse = await Models.getModelObject(
            Models.shareTripModel,
            response.data,
          );

          /// Status Code
          if (shareTripResponse.code == 1) {
            _logger.i("shareTripResponse: ${shareTripResponse.toJson()}");
            //Success
            isShareTripSaved = false;
            await getMyTrips(sortType: isSelectOption);
          } else {
            Toasts.getErrorToast(
                text: shareTripResponse.data!.message.toString());
            //fail
            isShareTripSaved = false;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      _logger.e("onError: ${e.toString()}");
    }
  }

  ///  Trip Favorite
  Future<void> markTripFavorite({
    required String tripId,
    required bool isLike,
    required BuildContext context,
  }) async {
    try {
      isTripSaved = false;

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };

      ///URL
      var url = "$markTripFavoriteApiUrl/$tripId";
      _logger.i("header: $header \n URL: $url");

      ///Body
      Map<String, dynamic> body = {"isSaved": isLike};

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: url,
        myHeaders: header,
        body: body,
      );
      _logger.i("onTripFavoriteResponse: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          /// Error Response
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// User Support
          tripFavoriteResponse = await Models.getModelObject(
            Models.tripFavoriteModel,
            response.data,
          );

          /// Status Code
          if (tripFavoriteResponse.code == 1) {
            _logger.i("tripFavoriteResponse: ${tripFavoriteResponse.toJson()}");
            //Success
            // Toasts.getSuccessToast(text: tripFavoriteResponse.message);
            isTripSaved = true;
            await getMyTrips(sortType: isSelectOption);
          } else {
            //Error
            Toasts.getErrorToast(text: tripFavoriteResponse.message);
            isTripSaved = false;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      _logger.e("onError: ${e.toString()}");
    }
  }
}
