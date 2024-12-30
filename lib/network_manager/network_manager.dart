import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_resources/app_toasts.dart';

import 'models.dart';

class NetworkManager {
  // App Logger
  static final _logger = Logger();

  /// Call Post API
  static Future<dynamic> callPostApi({
    String? url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? myHeaders,
    dynamic modelName,
  }) async {
    try {
      var dio = Dio();
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        Response response = await dio.post(
          url!,
          options: Options(headers: myHeaders),
          data: body,
          queryParameters: parameters,
        );
        switch (response.statusCode) {
          case 201:
            dynamic modelObject =
                await Models.getModelObject(modelName, response.data);
            if (modelObject.code == 1) {
              return modelObject;
            } else {
              Toasts.getErrorToast(text: modelObject.message);
            }
            return null;
          case 200:
            dynamic modelObject =
                await Models.getModelObject(modelName, response.data);
            if (modelObject.code == 1) {
              return modelObject;
            } else {
              Toasts.getErrorToast(text: modelObject.message);
            }
            return null;
          case 500:
            _logger.e("error500");
            return null;
          default:
            Toasts.getErrorToast(text: "Http Code Not Match Error");
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "No Internet Connection Available");
        _logger.e("No Internet Connection Available");
        return null;
      }
    } on DioError catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 400:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return errorResponse;
          case 401:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 500:
            _logger.e("DioError500: ${errorResponse.toJson()}");
            //Toasts.getErrorToast(text: "Internal Server Error");
            return errorResponse;
          default:
            Toasts.getErrorToast(text: "badHappenedError");
            return errorResponse;
        }
      } else {
        Toasts.getErrorToast(text: "badHappenedError");
      }
    } on Exception {
      Toasts.getErrorToast(text: "badHappenedError");
      return null;
    }
  }

  /// Call Get API
  static Future<dynamic> callGetApi(
      {String? url,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders,
      dynamic modelName}) async {
    try {
      var dio = Dio();
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        Response response = await dio.get(url!,
            options: Options(headers: myHeaders), queryParameters: parameters);
        switch (response.statusCode) {
          case 200:
            dynamic getModelObj =
                await Models.getModelObject(modelName, response.data);
            if (getModelObj.code == 1) {
              _logger.d("getModelObj: $getModelObj");
              return getModelObj;
            } else {
              _logger.d("getModelObj: $getModelObj");
              Toasts.getErrorToast(text: getModelObj.message);
            }
            return null;
          case 500:
            _logger.e("500: Error: ${response.data}");
            return null;
          default:
            Toasts.getErrorToast(text: "Http Code Not Match Error.");
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "No Internet Connection Available");
        _logger.e("No Internet Connection Available");

        return null;
      }
    } on DioError catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        _logger.e("errorResponse: ${errorResponse.toJson()}");
        switch (ex.response!.statusCode) {
          case 400:
            _logger.e("400: Error: ${errorResponse.toJson()}");
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 401:
            _logger.e("401: Error: ${errorResponse.toJson()}");
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 500:
            _logger.e("500: Error: ${errorResponse.toJson()}");
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          default:
            Toasts.getErrorToast(text: "badHappenedError");
            return;
        }
      } else {
        Toasts.getErrorToast(text: "badHappenedError");
      }
    } on Exception {
      Toasts.getErrorToast(text: "badHappenedError");
      return;
    }
  }

  /// Call Put API
  static Future<dynamic> callPutApi({
    String? url,
    dynamic body,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? myHeaders,
    dynamic modelName,
  }) async {
    try {
      var dio = Dio();
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        Response response = await dio.put(url!,
            options: Options(headers: myHeaders),
            data: body,
            queryParameters: parameters);
        switch (response.statusCode) {
          case 200:
            dynamic modelObject =
                await Models.getModelObject(modelName, response.data);
            if (modelObject.code == 1) {
              _logger.e("200: Success: $modelObject");
              return modelObject;
            } else {
              Toasts.getErrorToast(text: modelObject.message);
            }
            return null;
          case 500:
            _logger.e("500: Error: ${response.data}");
            return null;
          default:
            Toasts.getErrorToast(text: "Http Code Not Match Error");
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "No Internet Connection Available");
        _logger.e("No Internet Connection Available");
        return null;
      }
    } on DioError catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 400:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 401:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 500:
            Toasts.getErrorToast(text: "Internal Server Error");
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          default:
            Toasts.getErrorToast(text: "badHappenedError");
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "badHappenedError");
      }
    } on Exception {
      Toasts.getErrorToast(text: "badHappenedError");
      return null;
    }
  }

  /// Call Patch API
  static Future<dynamic> callPatchApi(
      {String? url,
      dynamic body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders,
      dynamic modelName}) async {
    try {
      var dio = Dio();
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        Response response = await dio.patch(url!,
            options: Options(headers: myHeaders),
            data: body,
            queryParameters: parameters);
        switch (response.statusCode) {
          case 200:
            dynamic modelObject =
                await Models.getModelObject(modelName, response.data);
            if (modelObject.code == 1) {
              return modelObject;
            } else {
              Toasts.getErrorToast(text: modelObject.message);
            }
            return null;

          default:
            Toasts.getErrorToast(text: "Http Code Not Match Error");
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "No Internet Connection Available");
        _logger.e("No Internet Connection Available");

        return null;
      }
    } on DioError catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 400:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 401:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 500:
            Toasts.getErrorToast(text: "Internal Server Error");
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          default:
            Toasts.getErrorToast(text: "badHappenedError");
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "badHappenedError");
      }
    } on Exception {
      Toasts.getErrorToast(text: "badHappenedError");
      return null;
    }
  }

  /// Call Delete API
  static Future<dynamic> callDeleteApi(
      {String? url,
      dynamic body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders,
      dynamic modelName}) async {
    try {
      var dio = Dio();
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        Response response = await dio.delete(url!,
            options: Options(headers: myHeaders),
            data: body,
            queryParameters: parameters);
        switch (response.statusCode) {
          case 200:
            dynamic modelObject =
                await Models.getModelObject(modelName, response.data);
            if (modelObject.code == 1) {
              return modelObject;
            } else {
              Toasts.getErrorToast(text: modelObject.message);
            }
            return null;

          default:
            Toasts.getErrorToast(text: "Http Code Not Match Error");
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "No Internet Connection Available");
        _logger.e("No Internet Connection Available");

        return null;
      }
    } on DioError catch (ex) {
      if (ex.response != null) {
        ErrorResponse errorResponse =
            await Models.getModelObject(Models.errorModel, ex.response?.data);
        switch (ex.response!.statusCode) {
          case 400:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          case 401:
            Toasts.getErrorToast(text: errorResponse.data?.message);
            return null;
          default:
            Toasts.getErrorToast(text: "badHappenedError");
            return null;
        }
      } else {
        Toasts.getErrorToast(text: "badHappenedError");
      }
    } on Exception {
      Toasts.getErrorToast(text: "Exception Error.");
      return null;
    }
  }
}
