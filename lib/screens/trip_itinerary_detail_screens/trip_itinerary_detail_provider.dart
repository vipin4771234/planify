// Created by Tayyab Mughal on 20/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/trips/GetTripDetailByIdResponse.dart';
import 'package:planify/app_data_models/trips/TripFavoriteResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetailProvider extends ChangeNotifier {
  BuildContext? context;

  DateTime? timestamp;
  String? formattedDate;

  // Loader and Logger
  // final _loader = Loader();
  final _logger = Logger();

  bool isTripDetailLoaded = false;
  ErrorResponse errorResponse = ErrorResponse();
  GetTripDetailByIdResponse getTripDetailByIdResponse =
      GetTripDetailByIdResponse();
  TripFavoriteResponse tripFavoriteResponse = TripFavoriteResponse();

  bool isTripSaved = false;
  int isTripDetailLoading = 0;

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isTripDetailLoaded = false;
  }

  Future<void> openServiceUrl({required String serviceUrl}) async {
    final Uri url = Uri.parse(serviceUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Toasts.getErrorToast(text: "Could not launch $url");
      throw Exception('Could not launch $url');
    }
  }

  /// Get Trip and User Counts
  Future<void> getTripDetailById({
    required String tripId,
  }) async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$getTripDetailByIdApiUrl/$tripId";
      _logger.i("header: $header \n URL: $url");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: url,
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
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          // networkState = NetworkState.error;
          isTripDetailLoading = 1;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// Get Trip Detail Response
          getTripDetailByIdResponse = await Models.getModelObject(
            Models.getTripDetailModel,
            response.data,
          );

          if (getTripDetailByIdResponse.code == 1) {
            _logger.i(
              "getTripDetailByIdResponse: ${getTripDetailByIdResponse.toJson()}",
            );

            // Date Time Parse
            timestamp = DateTime.parse(
              getTripDetailByIdResponse.data!.trip!.createdAt.toString(),
            );
            formattedDate =
                "${timestamp!.day}/${timestamp!.month}/${timestamp!.year}";
            //Success
            isTripDetailLoading = 2;
          } else {
            isTripDetailLoading = 1;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isTripDetailLoading = 1;
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
      var url = "$markTripFavoriteApiUrl/$tripId";

      _logger.i("---------header: $header \n URL: $isLike");
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
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");

          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          // User Support
          tripFavoriteResponse = await Models.getModelObject(
            Models.tripFavoriteModel,
            response.data,
          );

          if (tripFavoriteResponse.code == 1) {
            _logger.i("tripFavoriteResponse: ${tripFavoriteResponse.toJson()}");
            //Success
            //Toasts.getSuccessToast(text: tripFavoriteResponse.message);
            if (tripFavoriteResponse.toJson()['message'] ==
                "Trip Disliked Successfully") {
              Toasts.getSuccessToast(text: "Trip Unsaved Successfully");
              isTripSaved = false;
              _logger.i("isTripSavedifff: $isTripSaved");
            } else {
              isTripSaved = true;
              Toasts.getSuccessToast(text: "Trip Saved Successfully");
              _logger.i("isTripSavedelseee: $isTripSaved");
            }
          } else {
            //Error
            Toasts.getErrorToast(text: tripFavoriteResponse.message);
            isTripSaved = isTripSaved;
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
