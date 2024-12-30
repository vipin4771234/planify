// Created by Tayyab Mughal on 27/04/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/notifications/GetMyNotificationResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';

enum NetworkState { loading, data, error, responseError }

class NotificationProvider extends ChangeNotifier {
  NetworkState networkState = NetworkState.loading;

  // Logger
  final _logger = Logger();
  bool isSuccess = false;
  int isNotifyLoading = 0;

  ErrorResponse errorResponse = ErrorResponse();
  GetMyNotificationResponse getMyNotificationResponse =
      GetMyNotificationResponse();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    isSuccess = false;

    // Foreground Notification While the app running state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification!.title}');

        await getNotification(context: context!);
        _logger.i("onNotificationAPICall");
        if (message.data['type'] == 'chat') {
          debugPrint("Type is Chat Opened");
        }
      }
    });


  }

  /// user Login
  Future<void> getNotification({
    required BuildContext context,
  }) async {
    try {
      networkState = NetworkState.loading;

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $myNotificationApiUrl");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: myNotificationApiUrl,
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
          networkState = NetworkState.error;
          isNotifyLoading = 1;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          getMyNotificationResponse = await Models.getModelObject(
            Models.getMyNotificationModel,
            response.data,
          );

          if (getMyNotificationResponse.code == 1) {
            _logger.i(
                "getMyNotificationResponse: ${getMyNotificationResponse.toJson()}");
            //Success
            isSuccess = true;
            isNotifyLoading = 2;
            networkState = NetworkState.data;
          } else {
            //Success
            isSuccess = false;
            isNotifyLoading = 1;
            networkState = NetworkState.responseError;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isNotifyLoading = 1;
      _logger.e("onError: ${e.toString()}");
    }
  }
}
