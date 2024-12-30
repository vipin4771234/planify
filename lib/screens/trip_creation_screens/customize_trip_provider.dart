// Created by Tayyab Mughal on 21/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_data_models/country/GetAllContinentsResponse.dart';
import 'package:planify/app_data_models/country/GetAllCountriesResponse.dart';
import 'package:planify/app_data_models/country/GetCountryByContinentResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/trips/CheckAvailableTripResponse.dart';
import 'package:planify/app_data_models/trips/CreateTripResponse.dart';
import 'package:planify/app_data_models/trips/PreviousTripIterationResponse.dart';
import 'package:planify/screens/main_home_screens/main_home_screen.dart';
import 'package:planify/app_data_models/trips/UserRateTripResponse.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/network_manager/manager.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomizeTripProvider extends ChangeNotifier {
  BuildContext? context;

  // Loader and Logger
  final _loader = Loader();
  final _logger = Logger();

  bool isTripCreated = false;
  bool isRateTrip = false;
  bool isTripAvailable = false;
  bool isGenerating = true;
  num isAvailable = -1;
  bool regenerateIteration = false;
  bool isReuseIteration = false;

  int isRegenerating = 0;
  int isPreviousLoading = 0;

  List<String> continentNameList = [];
  List<String> countryNameList = [];

  /// Countries / Continents
  GetAllContinentsResponse getAllContinentsResponse =
      GetAllContinentsResponse();
  GetCountryByContinentResponse getCountryByContinentResponse =
      GetCountryByContinentResponse();
  GetAllCountriesResponse getAllCountriesResponse = GetAllCountriesResponse();
  ErrorResponse errorResponse = ErrorResponse();
  CreateTripResponse createTripResponse = CreateTripResponse();

  UserRateTripResponse userRateTripResponse = UserRateTripResponse();
  CheckAvailableTripResponse checkAvailableTripResponse =
      CheckAvailableTripResponse();

  PreviousTripIterationResponse previousTripIterationResponse =
      PreviousTripIterationResponse();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    // isDataLoaded = false;
  }

  Future<void> openServiceUrl({required String serviceUrl}) async {
    final Uri url = Uri.parse(serviceUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Toasts.getErrorToast(text: "Could not launch $url");
      throw Exception('Could not launch $url');
    }
  }

  /// Reuse Trip Iteration
  Future<void> reuseTripIteration({
    required String tripId,
    required String iterationId,
    required BuildContext context,
  }) async {
    try {
      _loader.showAppLoader(context: context);

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$reuseTripApiUrl/$iterationId";
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
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isReuseIteration = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
          }
          Toasts.getErrorToast(text: errorResponse.data!.message.toString());
        } else {
          _logger.i("reuseIterationResponse:${response.data}");
          await _refreshTripData(tripId: tripId);
          isReuseIteration = true;

          /// Previous Trip Iteration Response
          // createTripResponse = await Models.getModelObject(
          //   Models.createTripModel,
          //   response.data,
          // );
          //
          // if (createTripResponse.code == 1) {
          //   _logger.i("onRegenerate: ${createTripResponse.toJson()}");
          //   isRegenerating = 2;
          //   if (context.mounted) {
          //     _loader.hideAppLoader(context: context);
          //   }
          //   Toasts.getSuccessToast(text: createTripResponse.message.toString());
          // } else {
          //   isRegenerating = 1;
          //   if (context.mounted) {
          //     _loader.hideAppLoader(context: context);
          //   }
          //   Toasts.getErrorToast(text: createTripResponse.message.toString());
          // }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isRegenerating = 1;
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
      _loader.showAppLoader(context: context);

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
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
          }
          Toasts.getErrorToast(text: errorResponse.data!.message.toString());
        } else {
          /// Success Handling
          _logger.i("regenerateIterationResponse:${response.data}");
          regenerateIteration = true;

          /// When use try to reuse the trip iteration then load the latest trip data
          await _refreshTripData(tripId: tripId);
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
          }

          /// Previous Trip Iteration Response
          // createTripResponse = await Models.getModelObject(
          //   Models.createTripModel,
          //   response.data,
          // );
          //
          // if (createTripResponse.code == 1) {
          //   _logger.i("onRegenerate: ${createTripResponse.toJson()}");
          //   isRegenerating = 2;
          //   if (context.mounted) {
          //     _loader.hideAppLoader(context: context);
          //   }
          //   Toasts.getSuccessToast(text: createTripResponse.message.toString());
          // } else {
          //   isRegenerating = 1;
          //   if (context.mounted) {
          //     _loader.hideAppLoader(context: context);
          //   }
          //   Toasts.getErrorToast(text: createTripResponse.message.toString());
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

  /// load Previous Iteration By Id
  Future<void> loadPreviousIterationById({
    required String iterationId,
  }) async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$previousIterationTripApiUrl/$iterationId";

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
          /// Error Response
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isPreviousLoading = 1;
        } else {
          /// Previous Trip Iteration Response
          previousTripIterationResponse = await Models.getModelObject(
            Models.previousIterationTripModel,
            response.data,
          );

          if (previousTripIterationResponse.code == 1) {
            _logger.i(
                "previousTripIterationResponse: ${previousTripIterationResponse.toJson()}");
            isPreviousLoading = 2;
          } else {
            isPreviousLoading = 1;
          }
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      isPreviousLoading = 1;
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// check Available Trip
  Future<void> checkAvailableTrip({
    required BuildContext context,
  }) async {
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
            // set Avaialble Trips
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

  /// user Rate Trip
  Future<void> userRateTrip({
    required String tripId,
    required String experience,
    required String comment,
    required BuildContext context,
  }) async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$rateTripApiUrl/$tripId";
      _logger.i("header: $header \n URL: $url");

      final body = {"rating": 0, "experience": experience, "comment": comment};
      debugPrint("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: url,
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
          errorResponse = await Models.getModelObject(
            Models.errorModel,
            response.data,
          );
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isRateTrip = false;
        } else {
          userRateTripResponse = await Models.getModelObject(
            Models.rateTripModel,
            response.data,
          );

          if (userRateTripResponse.code == 1) {
            _logger.i("userRateTripResponse: ${userRateTripResponse.toJson()}");

            //Checks
            isRateTrip = true;
          } else {
            //Checks
            isRateTrip = false;
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

  /// user Login
  Future<void> createdNewTrip({
    required String country,
    required String numberOfDays,
    required String budget,
    required String numberOfMembers,
    required String relationship,
    required String budgetType,
    required String mood,
    required String fromDate,
    required String toDate,
    required String destinationLocation,
    required String departureLocation,
    required BuildContext context,
  }) async {
    try {
      isGenerating = false;

      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      _logger.i("header: $header \n URL: $createTripApiUrl");

      final body = {
        "country": country,
        "days": numberOfDays,
        "budget": budget,
        "numberOfMembers": numberOfMembers,
        "relationship": relationship,
        "budgetType": budgetType,
        "mood": mood,
        "fromDate": fromDate,
        "toDate": toDate,
        "destinationLocation": destinationLocation,
        "departureLocation": departureLocation
      };
      _logger.i("body: $body");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callPostAPI(
        url: createTripApiUrl,
        myHeaders: header,
        body: body,
      );
      _logger.i("onAPICallResponse: ${response!.data}");

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
          isTripCreated = false;
          isGenerating = false;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          // Decode Json
          createTripResponse = await Models.getModelObject(
            Models.createTripModel,
            response.data,
          );

          // Code = 1
          if (createTripResponse.code == 1) {
            _logger
                .i("createTripResponse -> 1: ${createTripResponse.toJson()}");
            //Checks
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainHomeScreen()),
                (route) => false);
            isTripCreated = true;
            isGenerating = true;
          } else {
            _logger.i("onCodeZeroError -> 0: ${createTripResponse.toJson()}");
            //Checks
            isTripCreated = false;
            isGenerating = true;
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

  /// Refresh the Trip Data
  Future<void> _refreshTripData({required String tripId}) async {
    try {
      /// Header
      Map<String, dynamic> header = {
        "Content-Type": "application/json",
        "Authorization": LocalAppDatabase.getString(Strings.loginUserToken)
      };
      var url = "$refreshTripInfoApiUrl/$tripId";
      _logger.i("header: $header \n URL: $url");

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
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          /// Create Trip Response
          createTripResponse = await Models.getModelObject(
            Models.createTripModel,
            response.data,
          );

          // Code = 1
          if (createTripResponse.code == 1) {
            _logger
                .i("createTripResponse -> 1: ${createTripResponse.toJson()}");
            //Checks
          } else {
            _logger.i("onCodeZeroError -> 0: ${createTripResponse.toJson()}");
            //Checks
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

  /// Get All Continents
  Future<void> getAllContinents({
    required BuildContext context,
  }) async {
    try {
      continentNameList.clear();
      _loader.showAppLoader(context: context);
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      debugPrint("URL: $getAllContinentsApiUrl");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: getAllContinentsApiUrl,
        myHeaders: header,
      );
      _logger.i("onAPICallResponse: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 || response.statusCode == 401) {
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isTripCreated = false;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
            Toasts.getErrorToast(text: errorResponse.message);
          }
        } else {
          getAllContinentsResponse = await Models.getModelObject(
              Models.getAllContinentModel, response.data);
          _logger.i(
              "getAllContinentsResponse: ${getAllContinentsResponse.toJson()}");

          var length = getAllContinentsResponse.data!.continents!.length;
          for (var i = 0; i < length; i++) {
            var name =
                getAllContinentsResponse.data?.continents?[i].name.toString();
            continentNameList.add(name!);
          }

          //Checks
          isTripCreated = true;
          if (context.mounted) {
            _loader.hideAppLoader(context: context);
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

  /// Get All Countries
  Future<void> getAllCountries() async {
    try {
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      debugPrint("URL: $getAllCountriesApiUrl");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: getAllCountriesApiUrl,
        myHeaders: header,
      );
      _logger.i("response: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 || response.statusCode == 401) {
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isTripCreated = false;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          getAllCountriesResponse = await Models.getModelObject(
              Models.getAllCountriesModel, response.data);
          _logger.i(
              "getAllCountriesResponse: ${getAllCountriesResponse.toJson()}");
          //Checks
          isTripCreated = true;
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      _logger.e("onError: ${e.toString()}");
    }
  }

  /// Get Countries by Continent
  Future<void> getCountriesByContinent({
    required String continentName,
  }) async {
    try {
      countryNameList.clear();
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      var url = "$getCountryByContinentApiUrl$continentName";
      debugPrint("URL: $url");

      /// Call Post API
      Response? response = await NewNetworkManager.instance.callGetAPI(
        url: url,
        myHeaders: header,
      );
      _logger.i("response: ${response!.data}");

      ///Response not null
      if (response.data != null) {
        /// Check the status Code
        if (response.statusCode == 500 || response.statusCode == 401) {
          errorResponse =
              await Models.getModelObject(Models.errorModel, response.data);
          _logger.i("errorResponse: ${errorResponse.toJson()}");
          isTripCreated = false;
          Toasts.getErrorToast(text: errorResponse.message);
        } else {
          getCountryByContinentResponse = await Models.getModelObject(
              Models.getCountriesByContinentModel, response.data);
          _logger.i(
              "getCountryByContinentResponse: ${getCountryByContinentResponse.toJson()}");
          var length = getCountryByContinentResponse.data!.countries!.length;
          for (var i = 0; i < length; i++) {
            var name = getCountryByContinentResponse.data?.countries?[i].name
                .toString();
            countryNameList.add(name!);
          }
          //Checks
          isTripCreated = true;
        }
      } else {
        _logger.e("return Response is: $response");
      }
      notifyListeners();
    } catch (e) {
      _logger.e("onError: ${e.toString()}");
    }
  }
}
