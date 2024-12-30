// Created by Tayyab Mughal on 27/04/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/auth/AddNewPasswordResponse.dart';
import 'package:planify/app_data_models/auth/ForgotPasswordResponse.dart';
import 'package:planify/app_data_models/auth/VerifyOTPCodeResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/network_manager/manager.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  // Loader and Logger
  final _loader = Loader();
  final _logger = Logger();

  ///Checks
  bool isSuccess = false;
  bool isOTPSuccess = false;
  bool isPasswordSuccess = false;

  /// Responses
  ErrorResponse errorResponse = ErrorResponse();
  ForgotPasswordResponse forgotPasswordResponse = ForgotPasswordResponse();
  VerifyOtpCodeResponse verifyOtpCodeResponse = VerifyOtpCodeResponse();
  AddNewPasswordResponse addNewPasswordResponse = AddNewPasswordResponse();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    isSuccess = false;
    isOTPSuccess = false;
    isPasswordSuccess = false;
  }

  /// Forgot Password
  Future<void> forgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      // _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      debugPrint("URL: $forgotPasswordApiUrl");

      final body = {"email": email};
      debugPrint("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: forgotPasswordApiUrl,
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
          //Error Response
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.e("errorResponse: ${errorResponse.toJson()}");
          Toasts.getWarningToast(text: errorResponse.message.toString());
          isSuccess = false;
        } else {
          //Response
          forgotPasswordResponse = await Models.getModelObject(
            Models.forgotPasswordModel,
            response.data,
          );
          // Code == 1
          if (forgotPasswordResponse.code == 1) {
            _logger.i(
                "forgotPasswordResponse: ${forgotPasswordResponse.toJson()}");
            isSuccess = true;
          } else {
            _logger.e(
                "forgotPasswordResponse: ${forgotPasswordResponse.toJson()}");
            isSuccess = false;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isSuccess = false;
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// Forgot Password
  Future<void> resendForgotPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      debugPrint("URL: $forgotPasswordApiUrl");

      final body = {"email": email};
      debugPrint("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: forgotPasswordApiUrl,
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
          //Error Response
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.e("errorResponse: ${errorResponse.toJson()}");
          Toasts.getWarningToast(text: errorResponse.message.toString());
          isSuccess = false;
          //
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
          }
        } else {
          //Response
          forgotPasswordResponse = await Models.getModelObject(
            Models.forgotPasswordModel,
            response.data,
          );
          // Code == 1
          if (forgotPasswordResponse.code == 1) {
            _logger.i(
                "forgotPasswordResponse: ${forgotPasswordResponse.toJson()}");
            isSuccess = true;
            //
            if (context.mounted) {
              _loader.hideAppLoader(context: context);
            }
          } else {
            _logger.e(
                "forgotPasswordResponse: ${forgotPasswordResponse.toJson()}");
            isSuccess = false;
            //
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
      isSuccess = false;
      //
      if (context.mounted) {
        _loader.hideAppLoader(context: context);
      }
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// Verify OTP Code
  Future<void> verifyOTPCode({
    required String email,
    required num code,
    required BuildContext context,
  }) async {
    try {
      _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      debugPrint("URL: $verifyOTPApiUrl");
      //body
      final body = {"email": email, "otp": code};
      debugPrint("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: verifyOTPApiUrl,
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
          isOTPSuccess = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            Toasts.getErrorToast(text: errorResponse.message);
          }
        } else {
          verifyOtpCodeResponse = await Models.getModelObject(
              Models.verifyOTPCodeModel, response.data);
          _logger.i("verifyOtpCodeResponse: ${verifyOtpCodeResponse.toJson()}");
          isOTPSuccess = true;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            //Toasts.getSuccessToast(text: verifyOtpCodeResponse.message);
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

  /// Add New Password
  Future<void> addNewPassword({
    required String password,
    required String verificationToken,
    required BuildContext context,
  }) async {
    try {
      _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      debugPrint("URL: $addNewPasswordApiUrl");
      //body
      final body = {
        "password": password,
        "verificationToken": verificationToken
      };

      debugPrint("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: addNewPasswordApiUrl,
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
          isPasswordSuccess = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            Toasts.getErrorToast(text: errorResponse.message);
          }
        } else {
          addNewPasswordResponse = await Models.getModelObject(
              Models.addNewPasswordModel, response.data);
          _logger
              .i("addNewPasswordResponse: ${addNewPasswordResponse.toJson()}");
          isPasswordSuccess = true;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            //Toasts.getSuccessToast(text: addNewPasswordResponse.message);
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
