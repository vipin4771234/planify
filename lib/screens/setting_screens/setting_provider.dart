// Created by Tayyab Mughal on 09/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/auth/DeleteUserAccountResponse.dart';
import 'package:planify/app_data_models/auth/LogoutResponse.dart';
import 'package:planify/app_data_models/auth/UpdateUserProfileResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/trips/CheckAvailableTripResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';

class SettingProvider extends ChangeNotifier {
  BuildContext? context;

  bool isPhotoUploaded = false;
  bool pickedImage = false;
  File? myImage;
  final _loader = Loader();
  final _logger = Logger();

  //File? _image;
  String? imgString;
  bool isUserPhotoSelected = false;
  ImagePicker? imagePicker = ImagePicker();

  ///Response
  UpdateUserProfileResponse updateUserProfileResponse =
      UpdateUserProfileResponse();
  ErrorResponse errorResponse = ErrorResponse();
  LogoutResponse logoutResponse = LogoutResponse();
  DeleteUserAccountResponse deleteUserAccountResponse =
      DeleteUserAccountResponse();

  CheckAvailableTripResponse checkAvailableTripResponse =
      CheckAvailableTripResponse();

  /// Available
  num isAvailable = 0;
  int isTripAvailable = 0;

  //Checks
  bool isLogoutSuccess = false;
  bool isSuccess = false;
  bool isAccountDelete = false;

  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isPhotoUploaded = false;
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
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.e("errorResponse: ${errorResponse.toJson()}");
          isTripAvailable = 1;
          isAvailable = 0;
        } else {
          /// Success Response
          checkAvailableTripResponse = await Models.getModelObject(
            Models.checkAvailableTripModel,
            response.data,
          );

          if (checkAvailableTripResponse.code == 1) {
            _logger.i(
                "checkAvailableTripResponse: ${checkAvailableTripResponse.toJson()}");
            isAvailable = checkAvailableTripResponse.data!.availableTripsCount!;
            _logger.i(
                "Before Remove: ${LocalAppDatabase.getString(Strings.tripAvailable)}");

            ///
            await LocalAppDatabase.clearPreferencesKey(
                keyName: Strings.tripAvailable);
            _logger.i(
                "After Remove: ${LocalAppDatabase.getString(Strings.tripAvailable)}");

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

            //Checks
            isTripAvailable = 2;
          } else {
            //Checks
            isTripAvailable = 1;
            isAvailable = 0;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isTripAvailable = 1;
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// Add New Password
  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
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
      final body = {"firstName": firstName, "lastName": lastName};
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
            response.statusCode == 400) {
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isSuccess = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            Toasts.getErrorToast(text: errorResponse.message);
          }
        } else {
          updateUserProfileResponse = await Models.getModelObject(
              Models.updateUserProfileModel, response.data);
          _logger.i(
              "updateUserProfileResponse: ${updateUserProfileResponse.toJson()}");

          /// Local App Cache
          await LocalAppDatabase.setEditProfileResponse(
                  editProfileResponse: updateUserProfileResponse)
              .then((_) async {
            String firstName =
                LocalAppDatabase.getString(Strings.loginFirstName) ?? "";
            String lastName =
                LocalAppDatabase.getString(Strings.loginLastName) ?? "";
            _logger
                .i("Updated Data-> firstName: $firstName, lastName: $lastName");
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

  /// Logout
  Future<void> userLogout({
    required BuildContext context,
  }) async {
    try {
      _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $logoutApiUrl");

      /// Call Get API
      Response? response = await NewNetworkManager.instance
          .callPostAPI(url: logoutApiUrl, myHeaders: header, body: {});
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
          isLogoutSuccess = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            Toasts.getErrorToast(text: errorResponse.message);
          }
        } else {
          logoutResponse =
              await Models.getModelObject(Models.logoutModel, response.data);
          _logger.i("logoutResponse: ${logoutResponse.toJson()}");
          isLogoutSuccess = true;
          //Clear Local Database
          LocalAppDatabase.clearPreferences();
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            //Toasts.getSuccessToast(text: logoutResponse.message);
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

  /// Logout
  Future<void> userDeleteAccount({
    required BuildContext context,
  }) async {
    try {
      _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $deleteUserApiUrl");

      /// Call Get API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: deleteUserApiUrl,
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
          //Error Response
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isAccountDelete = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            Toasts.getErrorToast(text: errorResponse.message);
          }
        } else {
          deleteUserAccountResponse = await Models.getModelObject(
            Models.deleteUserAccountModel,
            response.data,
          );
          _logger.i(
              "deleteUserAccountResponse: ${deleteUserAccountResponse.toJson()}");
          isAccountDelete = true;
          //Clear Local Database
          LocalAppDatabase.clearPreferences();
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            //Toasts.getSuccessToast(text: logoutResponse.message);
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      _loader.hideAppLoader(context: context);
      isAccountDelete = false;
      _logger.e("onError: ${e.toString()}");
    }
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
}
