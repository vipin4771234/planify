import 'package:planify/app_data_models/auth/AddNewPasswordResponse.dart';
import 'package:planify/app_data_models/auth/DeleteUserAccountResponse.dart';
import 'package:planify/app_data_models/auth/ForgotPasswordResponse.dart';
import 'package:planify/app_data_models/auth/LoginResponse.dart';
import 'package:planify/app_data_models/auth/LogoutResponse.dart';
import 'package:planify/app_data_models/auth/RegisterResponse.dart';
import 'package:planify/app_data_models/auth/UpdateUserProfileResponse.dart';
import 'package:planify/app_data_models/auth/VerifyOTPCodeResponse.dart';
import 'package:planify/app_data_models/country/GetAllContinentsResponse.dart';
import 'package:planify/app_data_models/country/GetAllCountriesResponse.dart';
import 'package:planify/app_data_models/country/GetCountryByContinentResponse.dart';
import 'package:planify/app_data_models/error_model/CheckAvailableTripErrorResponse.dart';
import 'package:planify/app_data_models/error_model/error_model.dart';
import 'package:planify/app_data_models/gift/GenerateGiftCodeResponse.dart';
import 'package:planify/app_data_models/gift/RadeemGiftCodeResponse.dart';
import 'package:planify/app_data_models/notifications/GetAllNotificationResponse.dart';
import 'package:planify/app_data_models/notifications/GetMyNotificationResponse.dart';
import 'package:planify/app_data_models/subscriptions/GetMySubscriptionResponse.dart';
import 'package:planify/app_data_models/subscriptions/UserSubscriptionResponse.dart';
import 'package:planify/app_data_models/support/UserSupportResponse.dart';
import 'package:planify/app_data_models/trips/CheckAvailableTripResponse.dart';
import 'package:planify/app_data_models/trips/CreateTripResponse.dart';
import 'package:planify/app_data_models/trips/GetMyTripResponse.dart';
import 'package:planify/app_data_models/trips/GetPublicTripResponse.dart';
import 'package:planify/app_data_models/trips/GetTripDetailByIdResponse.dart';
import 'package:planify/app_data_models/trips/GetTripInfoResponse.dart';
import 'package:planify/app_data_models/trips/GetTripStatsResponse.dart';
import 'package:planify/app_data_models/trips/PreviousTripIterationResponse.dart';
import 'package:planify/app_data_models/trips/ShareTripResponse.dart';
import 'package:planify/app_data_models/trips/TripFavoriteResponse.dart';
import 'package:planify/app_data_models/trips/UserRateTripResponse.dart';

class Models {
  static const String errorModel = "ERROR_MODEL";

  // Trips
  static const String getTripAndUserCountsModel = "getTripAndUserCountsModel";
  static const String getAllPublicTripModel = "getAllPublicTripModel";
  static const String getTripDetailModel = "getTripDetailModel";
  static const String getMyTripModel = "getMyTripModel";
  static const String createTripModel = "createTripModel";
  static const String tripFavoriteModel = "tripFavoriteModel";
  static const String rateTripModel = "rateTripModel";
  static const String giftCodeModel = "giftCodeModel";
  static const String radeemCodeModel = "radeemCodeModel";
  static const String checkAvailableTripModel = "checkAvailableTripModel";
  static const String checkAvailableTripErrorModel =
      "checkAvailableTripErrorModel";
  static const String shareTripModel = "shareTripModel";
  static const String previousIterationTripModel = "previousIterationTripModel";
  static const String redeemGiftCodeModel = "redeemGiftCodeModel";
  static const String getTripInfoModel = "getTripInfoModel";

  /// Misc
  static const String getFaqDetailModel = "getFaqDetailModel";
  static const String getAboutUsModel = "getAboutUsModel";
  static const String userSupportContactModel = "userSupportContactModel";

  /// Continent
  static const String getAllContinentModel = "getAllContinentModel";
  static const String getAllCountriesModel = "getAllCountriesModel";
  static const String getCountriesByContinentModel =
      "getCountriesByContinentModel";

  ///Subscription
  static const String getMySubscriptionModel = "getMySubscriptionModel";
  static const String makeSubscriptionModel = "makeSubscriptionModel";

  /// Auth
  static const String loginModel = "loginModel";
  static const String registerModel = "registerModel";
  static const String forgotPasswordModel = "forgotPasswordModel";
  static const String verifyOTPCodeModel = "verifyOTPCodeModel";
  static const String addNewPasswordModel = "addNewPasswordModel";
  static const String updateUserProfileModel = "updateUserProfileModel";
  static const String logoutModel = "logoutModel";
  static const String deleteUserAccountModel = "deleteUserAccountModel";

  /// Get All Notifications
  static const String getAllNotificationsModel = "getAllNotificationsModel";
  static const String getMyNotificationModel = "getMyNotificationModel";

  static Future<dynamic> getModelObject(
    String modelName,
    Map<String, dynamic> json,
  ) async {
    switch (modelName) {
      case deleteUserAccountModel:
        return DeleteUserAccountResponse.fromJson(json);
      case getTripInfoModel:
        return GetTripInfoResponse.fromJson(json);
      case makeSubscriptionModel:
        return UserSubscriptionResponse.fromJson(json);
      case previousIterationTripModel:
        return PreviousTripIterationResponse.fromJson(json);
      case shareTripModel:
        return ShareTripResponse.fromJson(json);
      case getMyNotificationModel:
        return GetMyNotificationResponse.fromJson(json);
      case checkAvailableTripModel:
        return CheckAvailableTripResponse.fromJson(json);
      case checkAvailableTripErrorModel:
        return CheckAvailableTripErrorResponse.fromJson(json);
      case radeemCodeModel:
        return RadeemGiftCodeResponse.fromJson(json);
      case giftCodeModel:
        return GenerateGiftCodeResponse.fromJson(json);
      case rateTripModel:
        return UserRateTripResponse.fromJson(json);
      case tripFavoriteModel:
        return TripFavoriteResponse.fromJson(json);
      case userSupportContactModel:
        return UserSupportResponse.fromJson(json);
      case createTripModel:
        return CreateTripResponse.fromJson(json);
      case registerModel:
        return RegisterResponse.fromJson(json);
      case loginModel:
        return LoginResponse.fromJson(json);
      case forgotPasswordModel:
        return ForgotPasswordResponse.fromJson(json);
      case verifyOTPCodeModel:
        return VerifyOtpCodeResponse.fromJson(json);
      case addNewPasswordModel:
        return AddNewPasswordResponse.fromJson(json);
      case updateUserProfileModel:
        return UpdateUserProfileResponse.fromJson(json);
      case getMySubscriptionModel:
        return GetMySubscriptionResponse.fromJson(json);
      case getCountriesByContinentModel:
        return GetCountryByContinentResponse.fromJson(json);
      case getAllContinentModel:
        return GetAllContinentsResponse.fromJson(json);
      case getAllCountriesModel:
        return GetAllCountriesResponse.fromJson(json);
      case getTripDetailModel:
        return GetTripDetailByIdResponse.fromJson(json);
      case getAllPublicTripModel:
        return GetPublicTripResponse.fromJson(json);
      case getTripAndUserCountsModel:
        return GetTripStatsResponse.fromJson(json);
      case getAllNotificationsModel:
        return GetAllNotificationResponse.fromJson(json);
      case errorModel:
        return ErrorResponse.fromJson(json);
      case logoutModel:
        return LogoutResponse.fromJson(json);
      case getMyTripModel:
        return GetMyTripResponse.fromJson(json);
    }
  }
}
