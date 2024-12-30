// Created by Tayyab Mughal on 03/05/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/subscriptions/GetMySubscriptionResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';

class BillingProvider extends ChangeNotifier {
  BuildContext? context;

  // Loader and Logger
  // final _loader = Loader();
  final _logger = Logger();

  int isBillingLoaded = 0;

  GetMySubscriptionResponse getMySubscriptionResponse =
      GetMySubscriptionResponse();
  ErrorResponse errorResponse = ErrorResponse();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
  }

  /// Load User Subscriptions
  Future<void> getUserSubscriptions() async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $getMySubscriptionApiUrl");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: getMySubscriptionApiUrl,
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
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          //Fail
          isBillingLoaded = 1;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          // Get My Subscription
          getMySubscriptionResponse = await Models.getModelObject(
            Models.getMySubscriptionModel,
            response.data,
          );

          if (getMySubscriptionResponse.code == 1) {
            _logger.i(
              "getMySubscriptionResponse: ${getMySubscriptionResponse.toJson()}",
            );
            //Success
            isBillingLoaded = 2;
          } else {
            //Fail
            isBillingLoaded = 1;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isBillingLoaded = 1;
      _logger.e("onError: ${e.toString()}");
    }
  }
}
