// Created by Tayyab Mughal on 21/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/support/UserSupportResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';

enum NetworkState { loading, data, error, responseError }

class SupportProvider extends ChangeNotifier {
  NetworkState networkState = NetworkState.loading;
  BuildContext? context;

  // Loader and Logger
  final _loader = Loader();
  final _logger = Logger();

  bool isSupportSubmitted = false;
  UserSupportResponse userSupportResponse = UserSupportResponse();
  ErrorResponse errorResponse = ErrorResponse();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isSupportSubmitted = false;
  }

  /// Post Support Message
  Future<void> postSupportMessage(
      {required String message, required BuildContext context}) async {
    try {
      _loader.showAppLoader(context: context);
      networkState = NetworkState.loading;
      isSupportSubmitted = false;

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $userSupportContactApiUrl");
      Map<String, dynamic> body = {"supportMessage": message};

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: userSupportContactApiUrl,
        myHeaders: header,
        body: body,
      );
      _logger.i("response: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400) {
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          networkState = NetworkState.error;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          // User Support
          userSupportResponse = await Models.getModelObject(
            Models.userSupportContactModel,
            response.data,
          );

          if (userSupportResponse.code == 1) {
            _logger.i("userSupportResponse: ${userSupportResponse.toJson()}");
            //Success
            //Toasts.getSuccessToast(text: userSupportResponse.message);
            networkState = NetworkState.data;
            isSupportSubmitted = true;
            if (context.mounted) {
              _loader.hideAppLoader(context: context);
            }
          } else {
            //Error
            networkState = NetworkState.responseError;
            Toasts.getSuccessToast(text: userSupportResponse.message);
            isSupportSubmitted = false;
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
}
