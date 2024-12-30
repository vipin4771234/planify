// Created by Tayyab Mughal on 20/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/gift/GenerateGiftCodeResponse.dart';
import 'package:planify/app_data_models/trips/CheckAvailableTripResponse.dart';
import 'package:planify/app_data_models/trips/GetPublicTripResponse.dart';
import 'package:planify/app_data_models/trips/GetTripStatsResponse.dart';
import 'package:planify/app_data_models/trips/TripFavoriteResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreProvider extends ChangeNotifier {
  BuildContext? context;

  // Loader and Logger
  final _loader = Loader();
  final _logger = Logger();

  bool isCountedLoaded = false;
  bool isPublicTripLoaded = false;
  int isPublicTrip = 0;
  bool isTripSaved = false;
  bool isGiftCode = false;

  bool isVideoSaving = false;

  String tripCount = "0000";
  String userCount = "0000";

  /// Available
  num isAvailable = -1;
  bool isTripAvailable = false;
  bool isNewNotificationShowBadge = false;

  ErrorResponse errorResponse = ErrorResponse();
  GetTripStatsResponse getTripStatsResponse = GetTripStatsResponse();
  GetPublicTripResponse getPublicTripResponse = GetPublicTripResponse();
  TripFavoriteResponse tripFavoriteResponse = TripFavoriteResponse();
  GenerateGiftCodeResponse generateGiftCodeResponse =
      GenerateGiftCodeResponse();
  CheckAvailableTripResponse checkAvailableTripResponse =
      CheckAvailableTripResponse();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isCountedLoaded = false;
    isPublicTripLoaded = false;

    /// Foreground Notification While the app running state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        debugPrint('Got a message whilst in the foreground!');

        _logger.i('onExplore: ${message.data}');
        var isType = message.data['type'];
        debugPrint("isType: $isType");

        isNewNotificationShowBadge = true;
        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification: ${message.notification!.title}, ${message.notification!.body}');

          ///_showTripReadyAlert(context: context);
        }

        if (isType == 'trip') {
          _logger.i("NotificationType is: $isType");
        } else if (isType == "video") {
          _logger.i("NotificationType is: $isType");
        } else {
          _logger.i("NotificationType is: $isType");
        }
      } catch (e) {
        _logger.e("onMessageError: $e");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        debugPrint('Got a message whilst in the foreground!');
        isNewNotificationShowBadge = false;
      } catch (e) {
        debugPrint("onMessageError: $e");
      }
    });

    //notifyListeners();
  }

  void isNewBadgeState() {
    isNewNotificationShowBadge = false;
    notifyListeners();
  }

  /// Open Service Url
  Future<void> openServiceUrl({required String serviceUrl}) async {
    final Uri url = Uri.parse(serviceUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Toasts.getErrorToast(text: "Could not launch $url");
      throw Exception('Could not launch $url');
    }
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
          isTripAvailable = false;
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
            isTripAvailable = true;
          } else {
            //Checks
            isTripAvailable = false;
            isAvailable = 0;
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

  /// Get Trip and User Counts
  Future<void> getTripAndUserCounts() async {
    try {
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      _logger.i("URL: $getTripStatsApiUrl");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: getTripStatsApiUrl,
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

          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isCountedLoaded = false;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// Success Response
          getTripStatsResponse = await Models.getModelObject(
            Models.getTripAndUserCountsModel,
            response.data,
          );

          ///Response Status
          if (getTripStatsResponse.code == 1) {
            _logger.i("getTripStatsResponse: ${getTripStatsResponse.toJson()}");
            isCountedLoaded = true;
            tripCount = getTripStatsResponse.data!.tripsCount.toString();
            userCount = getTripStatsResponse.data!.usersCount.toString();
          } else {
            isCountedLoaded = false;
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

  ///  Generate Gift Code
  Future<void> giftCodeGenerator({
    required BuildContext context,
  }) async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $giftCodeGeneratorApiUrl");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: giftCodeGeneratorApiUrl,
        myHeaders: header,
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
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isGiftCode = false;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// Success Response
          generateGiftCodeResponse = await Models.getModelObject(
            Models.giftCodeModel,
            response.data,
          );

          /// Status Code
          if (generateGiftCodeResponse.code == 1) {
            _logger.i(
                "generateGiftCodeResponse: ${generateGiftCodeResponse.toJson()}");
            //Success
            // Toasts.getSuccessToast(text: generateGiftCodeResponse.message);
            isGiftCode = true;
          } else {
            //Error
            Toasts.getSuccessToast(text: generateGiftCodeResponse.message);
            isGiftCode = false;
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
  }) async {
    try {
      isTripSaved = false;

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$markTripFavoriteApiUrl/$tripId";

      _logger.i("header: $header \n URL: $url");
      Map<String, dynamic> body = {"isSaved": isLike};
      debugPrint("body: $body");

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
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// Success Response
          tripFavoriteResponse = await Models.getModelObject(
            Models.tripFavoriteModel,
            response.data,
          );

          /// Status Code
          if (tripFavoriteResponse.code == 1) {
            _logger.i("tripFavoriteResponse: ${tripFavoriteResponse.toJson()}");
            //Success
            // Toasts.getSuccessToast(text: tripFavoriteResponse.message);
            await getAllPublicTripsWithToken();
            isTripSaved = true;
          } else {
            //Error
            Toasts.getSuccessToast(text: tripFavoriteResponse.message);
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

  /// Get All Public Trips
  Future<void> getAllPublicTripsWithoutToken() async {
    try {
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      var url = "$getAllPublicTripApiUrl?limit=50";
      debugPrint("URL: $url");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: url,
        myHeaders: header,
      );
      _logger.i("onAPICallResponse: ${response!.data}");

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
          isPublicTripLoaded = false;
          isPublicTrip = 1;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// Success Response
          getPublicTripResponse = await Models.getModelObject(
            Models.getAllPublicTripModel,
            response.data,
          );

          /// Status Code
          if (getPublicTripResponse.code == 1) {
            _logger.i(
              "getPublicTripResponse: ${getPublicTripResponse.toJson()}",
            );
            isPublicTripLoaded = true;
            isPublicTrip = 2;
          } else {
            isPublicTripLoaded = false;
            isPublicTrip = 1;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isPublicTrip = 1;
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// Get All Public Trips
  Future<void> getAllPublicTripsWithToken() async {
    try {
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$getAllPublicTripApiUrl?limit=50";
      debugPrint("URL: $url, header: $header");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: url,
        myHeaders: header,
      );
      _logger.i("onAPICallResponse: ${response!.data}");

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
          isPublicTripLoaded = false;
          isPublicTrip = 1;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// Success Response
          getPublicTripResponse = await Models.getModelObject(
            Models.getAllPublicTripModel,
            response.data,
          );

          /// Status Code
          if (getPublicTripResponse.code == 1) {
            _logger.i(
              "getPublicTripResponse: ${getPublicTripResponse.toJson()}",
            );
            isPublicTripLoaded = true;
            isPublicTrip = 2;
          } else {
            isPublicTripLoaded = false;
            isPublicTrip = 1;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isPublicTrip = 1;
      _logger.e("onError: ${e.toString()}");
    }
  }

  Future<void> saveVideo({
    required String tripVideoTitle,
    required String tripVideoUrl,
    required BuildContext context,
  }) async {
    bool isPermission = await _requestPermission();
    if (isPermission == true) {
      if (context.mounted) {
        _loader.showAppLoaderWithoutBg(context: context);
      }
      final dirPath = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!.path}/planify.holiday',
      );
      _logger.i("dirPath: $dirPath");

      final dir = await getTemporaryDirectory();
      final savePath = "${dir.path}/$tripVideoTitle.mp4";
      //"${dir.path}/${DateTime.now().millisecondsSinceEpoch}.mp4";
      debugPrint("savePath: $savePath");
      String fileUrl = tripVideoUrl;
      //Download Video
      isVideoSaving = true;
      await Dio().download(
        fileUrl,
        savePath,
        options: Options(
            sendTimeout: const Duration(minutes: 2), //10 * 60 * 1000
            receiveTimeout: const Duration(minutes: 2) //10 * 60 * 1000,
            ),
        onReceiveProgress: (count, total) {
          debugPrint("${(count / total * 100).toStringAsFixed(0)}%");
        },
      );

      ///Save File in Storage
      final result = await SaverGallery.saveFile(
        file: savePath,
        androidExistNotSave: false,
        name: '$tripVideoTitle.mp4',
        androidRelativePath: "Movies/planify.holiday",
      );

      final xFilePath = XFile(savePath); //.writeAsBytesSync(bytes);
      if (result.isSuccess) {
        if (context.mounted) {
          _loader.hideAppLoader(context: context);
        }
        await Share.shareXFiles([xFilePath], text: "Share trip video");
        debugPrint(result.toString());
        _logger.i("result: $result");
        Toasts.getSuccessToast(text: "The trip video saved.");
      } else {
        Toasts.getSuccessToast(text: "Server error.");
        if (context.mounted) {
          _loader.hideAppLoader(context: context);
        }
      }
    } else {
      await _requestPermission();
    }
    notifyListeners();
  }

  /// Request Permission
  Future<bool> _requestPermission() async {
    bool statuses;
    if (Platform.isAndroid) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;

      /// [androidExistNotSave]
      /// On Android, if true, the save path already exists, it is not saved. Otherwise, it is saved
      /// 在安卓平台上,如果是true,则保存路径已存在就不在保存,否则保存

      /// is androidExistNotSave = true,write as follows:
      statuses = await Permission.storage.request().isGranted;

      /// is androidExistNotSave = false,write as follows:
      statuses =
          sdkInt < 29 ? await Permission.storage.request().isGranted : true;
      // statuses = await Permission.storage.request().isGranted;
      _logger.d('storage Permission: $statuses');
      notifyListeners();
      return statuses;
    } else {
      statuses = await Permission.photosAddOnly.request().isGranted;
      _logger.d('photo Permission: $statuses');
      notifyListeners();
      return statuses;
    }
  }
}
