// Created by Tayyab Mughal on 21/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/auth/UpdateUserProfileResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';

class CurrencyProvider extends ChangeNotifier {
  BuildContext? context;

  // Loader and Logger
  final _loader = Loader();
  final _logger = Logger();

  bool isSuccess = false;

  UpdateUserProfileResponse updateUserProfileResponse =
      UpdateUserProfileResponse();
  ErrorResponse errorResponse = ErrorResponse();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isSuccess = false;
  }

  /// Add New Password
  Future<void> updateUserCurrency({
    required String currency,
    required BuildContext context,
  }) async {
    try {
      _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $updateUserProfileApiUrl");
      //body
      final body = {"currency": currency};
      debugPrint("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPatchAPI(
        url: updateUserProfileApiUrl,
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
          /// Error Response
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isSuccess = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            Toasts.getErrorToast(text: errorResponse.message);
          }
        } else {
          /// Success
          updateUserProfileResponse = await Models.getModelObject(
            Models.updateUserProfileModel,
            response.data,
          );
          _logger.i(
              "updateUserProfileResponse: ${updateUserProfileResponse.toJson()}");

          /// Local App Cache
          await LocalAppDatabase.setUserCurrency(updateUserProfileResponse)
              .then((_) async {
            String userCurrency =
                LocalAppDatabase.getString(Strings.userCurrency) ?? "";

            _logger.i("userCurrency: $userCurrency");
          }).onError((error, stackTrace) {
            _logger.e("Save Error: ${error.toString()}");
          });

          isSuccess = true;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            // Toasts.getSuccessToast(text: updateUserProfileResponse.message);
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
