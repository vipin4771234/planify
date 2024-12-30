// Created by Tayyab Mughal on 29/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/auth/LoginResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';
import 'package:planify/push_notification_service/firebase_push_notification_service.dart';

class LoginProvider extends ChangeNotifier {
  // Loader and Logger
  //final _loader = Loader();
  final _logger = Logger();

  bool isDataLoaded = false;
  LoginResponse loginResponse = LoginResponse();
  ErrorResponse errorResponse = ErrorResponse();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    isDataLoaded = false;
  }

  /// user Login
  Future<void> userAuthLogin({
    required String email,
    required String password,
    required String channelType,
    required BuildContext context,
  }) async {
    try {
      /// Header
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      debugPrint("URL: $loginApiUrl");

      final body = {
        "email": email,
        "password": password,
        "user_channel_type": channelType
      };
      debugPrint("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: loginApiUrl,
        myHeaders: header,
        body: body,
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
          _logger.e("errorResponse: ${errorResponse.toJson()}");
          Toasts.getErrorToast(text: errorResponse.message.toString());
          isDataLoaded = false;
        } else {
          // Login Response
          loginResponse = await Models.getModelObject(
            Models.loginModel,
            response.data,
          );

          if (loginResponse.code == 1) {
            _logger.i("registerResponse: ${loginResponse.toJson()}");
            var email = loginResponse.data!.user!.email.toString();

            /// Initializing Push Notification Service
            await FirebasePushNotificationService.initializeNotification(
              userTopic: email,
            );

            // Toasts.getSuccessToast(text: loginResponse.message.toString());

            /// Local App Cache
            await LocalAppDatabase.setLoginResponse(loginResponse)
                .then((_) async {
              String firstName =
                  LocalAppDatabase.getString(Strings.loginFirstName) ?? "";
              String lastName =
                  LocalAppDatabase.getString(Strings.loginLastName) ?? "";
              String userChannelType =
                  LocalAppDatabase.getString(Strings.userChannelType) ?? "";
              String loginEmail =
                  LocalAppDatabase.getString(Strings.loginEmail) ?? "";
              String savedToken =
                  LocalAppDatabase.getString(Strings.loginUserToken) ?? "";
              String tripAvailable =
                  LocalAppDatabase.getString(Strings.tripAvailable) ?? "";
              String userCurrency =
                  LocalAppDatabase.getString(Strings.userCurrency) ?? "";

              _logger.i(
                  "firstName: $firstName, lastName: $lastName, userChannelType: $userChannelType, userCurrency: $userCurrency, tripAvailable:$tripAvailable, loginEmail: $loginEmail, savedToken: $savedToken");
            }).onError((error, stackTrace) {
              _logger.e("Save Error: ${error.toString()}");
            });

            //Checks
            isDataLoaded = true;
          } else {
            //Checks
            isDataLoaded = false;
            Toasts.getErrorToast(text: loginResponse.message);
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isDataLoaded = false;
      _logger.e("onError: ${e.toString()}");
    }
  }
}
