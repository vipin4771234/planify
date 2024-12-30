// Created by Tayyab Mughal on 11/06/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/trips/GetTripInfoResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTripGeneratedProvider extends ChangeNotifier {
  BuildContext? context;

  DateTime? timestamp;
  String? formattedDate;

  // Loader and Logger
  final _loader = Loader();
  final _logger = Logger();

  bool isTripDetailLoaded = false;
  ErrorResponse errorResponse = ErrorResponse();
  GetTripInfoResponse getTripInfoResponse = GetTripInfoResponse();

  bool isTripSaved = false;
  int isTripDetailLoading = 0;
  int isRegenerating = 0;
  int isPreviousLoading = 0;
  bool regenerateIteration = false;

  bool isVideoSaving = false;

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
  Future<void> getTripInfoById({
    required String tripId,
  }) async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$getTripInfoApiUrl/$tripId";
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
          getTripInfoResponse = await Models.getModelObject(
            Models.getTripInfoModel,
            response.data,
          );

          if (getTripInfoResponse.code == 1) {
            _logger.i(
              "getTripDetailByIdResponse: ${getTripInfoResponse.toJson()}",
            );
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

  /// Regenerate Trip Iteration
  Future<void> regenerateTripIteration({
    required String tripId,
    required String iterationId,
    required BuildContext context,
  }) async {
    try {
      // _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$regenerateTripApiUrl/$iterationId";
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
          /// Error Response/Handling
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.e("errorResponse: ${errorResponse.toJson()}");
          isRegenerating = 1;
          regenerateIteration = false;
          // if (context.mounted) {
          //   _loader.hideAppLoader(context: context);
          // }
          Toasts.getErrorToast(text: errorResponse.data!.message.toString());
        } else {
          /// Success Handling
          _logger.i("regenerateIterationResponse:${response.data}");
          regenerateIteration = true;
          await getTripInfoById(tripId: tripId);

          /// When use try to reuse the trip iteration then load the latest trip data
          //await _refreshTripData(tripId: tripId);
          // if (context.mounted) {
          //   _loader.hideAppLoader(context: context);
          // }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isRegenerating = 1;
      _loader.hideAppLoader(context: context);
      _logger.e("onError: ${e.toString()}");
    }
  }

  // Save Trip Video
  Future<void> saveTripVideo({
    required String tripVideoTitle,
    required String tripVideoUrl,
    required BuildContext context,
  }) async {
    // is Permission
    try {
      bool isPermission = await _requestPermission();
      //
      if (isPermission == true) {
        isVideoSaving = true;

        ///
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
        await Dio().download(
          fileUrl,
          savePath,
          options: Options(
              sendTimeout: const Duration(minutes: 2), //10 * 60 * 1000
              receiveTimeout: const Duration(minutes: 2) //10 * 60 * 1000,
              ),
          onReceiveProgress: (count, total) {
            // var videoProgress = (count / total * 100).toStringAsFixed(0);
            debugPrint("${(count / total * 100).toStringAsFixed(0)}%");
            // debugPrint("$videoProgress%");
          },
        );

        ///Save File in Storage
        final result = await SaverGallery.saveFile(
          file: savePath,
          androidExistNotSave: false,
          name: '$tripVideoTitle.mp4',
          androidRelativePath: "Movies/planify.holiday",
        );

        final xFilePath = XFile(savePath);
        if (result.isSuccess) {
          isVideoSaving = false;
          await Share.shareXFiles([xFilePath]);

          debugPrint(result.toString());
          _logger.i("result: $result");
          Toasts.getSuccessToast(text: "The trip video saved.");
        } else {
          isVideoSaving = false;
          Toasts.getSuccessToast(text: "Server error.");
        }
      } else {
        await _requestPermission();
      }
      notifyListeners();
    } catch (e) {
      isVideoSaving = false;
      _logger.e('erorrrrorr----> $e');
    }
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
