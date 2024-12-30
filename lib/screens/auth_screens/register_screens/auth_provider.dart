// Created by Tayyab Mughal on 09/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/auth/RegisterResponse.dart';
import 'package:planify/app_data_models/auth/UpdateUserProfileResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/api_url.dart';
import 'package:planify/network_manager/models.dart';
import 'package:planify/network_manager/new_network_manager.dart';
import 'package:planify/push_notification_service/firebase_push_notification_service.dart';

class AuthProvider extends ChangeNotifier {
  BuildContext? context;

  bool isUserRegistered = false;
  bool isUserProfile = false;

  bool pickedImage = false;
  File? myImage;

  // final _loader = Loader();
  final _logger = Logger();

  //File? _image;
  String? imgString;
  bool isUserPhotoSelected = false;
  ImagePicker? imagePicker = ImagePicker();

  RegisterResponse registerResponse = RegisterResponse();
  UpdateUserProfileResponse updateUserProfileResponse =
      UpdateUserProfileResponse();
  ErrorResponse errorResponse = ErrorResponse();

  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
  }

  /// GetImage From Gallery
  Future<void> getImageFromGallery() async {
    final XFile? image =
        await imagePicker?.pickImage(source: ImageSource.gallery);
    if (image != null) {
      myImage = File(image.path);
      pickedImage = true;
      isUserPhotoSelected = true;
      //imgString = baseUrl + _signUpPhotoProvider.myImage!.path;
      imgString = "baseUrl${myImage!.path}";
      debugPrint("AvatarImage: $imgString");
    }

    if (pickedImage) {
      final bytes = myImage!.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      _logger.d("pickedImageFileSizeInMB: ${mb.round()}");

      /// await uploadSignUpPhoto(image: myImage, userToken: userToken);
      debugPrint("myImage: $myImage");
      pickedImage = false;
    }

    notifyListeners();
  }

  /// user Register
  Future<void> userRegister({
    required String email,
    required String password,
    required String channelType,
    required BuildContext context,
  }) async {
    try {
      //_loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      debugPrint("URL: $registerApiUrl");

      final body = {
        "email": email,
        "password": password,
        "user_channel_type": channelType,
        "avatar":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQj7X3-fd9S3Mvo_zUbMdEOg0biq8hNQ9Bzng&usqp=CAU"
      };

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: registerApiUrl,
        myHeaders: header,
        body: body,
      );

      ///Response not null
      if (response != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          // Error Response
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.e("errorResponse: ${errorResponse.toJson()}");
          isUserRegistered = false;
          Toasts.getErrorToast(text: errorResponse.message.toString());
        } else {
          // Register Response
          registerResponse = await Models.getModelObject(
            Models.registerModel,
            response.data,
          );
          // Register Response code == 1
          if (registerResponse.code == 1) {
            _logger.i("registerResponse: ${registerResponse.toJson()}");
            //Toasts.getSuccessToast(text: registerResponse.message.toString());
            isUserRegistered = true;

            var email = registerResponse.data!.user!.email.toString();

            /// Initializing Push Notification Service
            await FirebasePushNotificationService.initializeNotification(
              userTopic: email,
            );

            /// Local App Cache
            await LocalAppDatabase.setRegisterResponse(registerResponse)
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
                  "Step01: firstName: $firstName, lastName: $lastName, userChannelType: $userChannelType, userCurrency: $userCurrency, tripAvailable:$tripAvailable, loginEmail: $loginEmail, savedToken: $savedToken");
            }).onError((error, stackTrace) {
              _logger.e("Save Error: ${error.toString()}");
            });
          } else {
            isUserRegistered = false;
            // Toasts.getErrorToast(text: registerResponse.message.toString());
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }

      notifyListeners();
    } catch (e) {
      isUserRegistered = false;
      _logger.e("onError ${e.toString()}");
    }
  }

  /// user Register
  Future<void> userProfileUpdate({
    required String firstName,
    required String lastName,
    required String userToken,
    required BuildContext context,
  }) async {
    try {
      //_loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": userToken
      };
      debugPrint("header: $header,  URL: $updateUserProfileApiUrl");

      final body = {
        "firstName": firstName,
        "lastName": lastName,
        "currency": "USD"
      };

      debugPrint("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPatchAPI(
        url: updateUserProfileApiUrl,
        myHeaders: header,
        body: body,
      );

      ///Response not null
      if (response != null) {
        /// Check the status Code
        if (response.statusCode == 500 ||
            response.statusCode == 401 ||
            response.statusCode == 400 ||
            response.statusCode == 404) {
          // Error Response
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.e("errorResponse: ${errorResponse.toJson()}");
          isUserProfile = false;
          Toasts.getErrorToast(text: errorResponse.message.toString());
        } else {
          // Register Response
          updateUserProfileResponse = await Models.getModelObject(
            Models.updateUserProfileModel,
            response.data,
          );
          // updateUserProfileResponse code == 1
          if (updateUserProfileResponse.code == 1) {
            _logger.i(
              "updateUserProfileResponse: ${updateUserProfileResponse.toJson()}",
            );
            // Toasts.getSuccessToast(
            //     text: updateUserProfileResponse.message.toString());
            isUserProfile = true;

            /// Local App Cache
            await LocalAppDatabase.setRegisterProfileResponse(
                    updateUserProfileResponse)
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
                  "Step02: firstName: $firstName, lastName: $lastName, userChannelType: $userChannelType, userCurrency: $userCurrency, tripAvailable:$tripAvailable, loginEmail: $loginEmail, savedToken: $savedToken");
            }).onError((error, stackTrace) {
              _logger.e("Save Error: ${error.toString()}");
            });
          } else {
            isUserProfile = false;
            Toasts.getErrorToast(
              text: updateUserProfileResponse.message.toString(),
            );
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }

      notifyListeners();
    } catch (e) {
      isUserProfile = false;
      _logger.e("onError ${e.toString()}");
    }
  }
}
