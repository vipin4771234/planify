import 'package:planify/app_data_models/auth/LoginResponse.dart';
import 'package:planify/app_data_models/auth/RegisterResponse.dart';
import 'package:planify/app_data_models/auth/UpdateUserProfileResponse.dart';
import 'package:planify/app_data_models/trips/CheckAvailableTripResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_resources/app_resources.dart';

class LocalAppDatabase {
  static String? userImage;
  var time = DateTime;

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String? getString(String key, [String? defValue]) {
    if (LocalAppDatabase._prefsInstance != null) {
      return _prefsInstance?.getString(key) ?? defValue ?? "";
    }
    return null;
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static bool getMyBool(String key, [bool? defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? true;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static int getInt(String key, [int? defValue]) {
    return _prefsInstance?.getInt(key) ?? defValue ?? 0;
  }

  static Future setUploadImage(uploadProfilePictureResponse) async {
    LocalAppDatabase.setString(
        Strings.filePath, uploadProfilePictureResponse.data!.message!);
  }

  static Future setUserImage(image) async {
    await LocalAppDatabase.setString(Strings.userImageKey, image ?? "");
  }

  static String? getUserImage() {
    userImage = LocalAppDatabase.getString(Strings.userImageKey)!;
    return userImage;
  }

  static Future setLoginResponse(LoginResponse loginResponse) async {
    await LocalAppDatabase.setString(
        Strings.loginUserToken, loginResponse.data?.accessToken ?? "");
    await LocalAppDatabase.setString(
        Strings.loginUserId, loginResponse.data?.user?.id ?? "");
    await LocalAppDatabase.setString(
        Strings.loginFirstName, loginResponse.data?.user?.firstName ?? "");
    await LocalAppDatabase.setString(
        Strings.loginLastName, loginResponse.data?.user?.lastName ?? "");
    await LocalAppDatabase.setString(
        Strings.loginEmail, loginResponse.data?.user?.email ?? "");
    await LocalAppDatabase.setString(Strings.userChannelType,
        loginResponse.data?.user?.userChannelType ?? "");
    // await LocalAppDatabase.setString(Strings.tripAvailable,
    //     loginResponse.data?.user?.tripsAvailable.toString() ?? "");
    await LocalAppDatabase.setString(Strings.userCurrency,
        loginResponse.data?.user?.currency.toString() ?? "0");
  }

  static Future setRegisterResponse(RegisterResponse registerResponse) async {
    await LocalAppDatabase.setString(
        Strings.loginUserToken, registerResponse.data?.accessToken ?? "");
    await LocalAppDatabase.setString(
        Strings.loginUserId, registerResponse.data?.user?.id ?? "");

    //First And Last Name
    // await LocalAppDatabase.setString(
    //     Strings.loginFirstName, registerResponse.data?.user?.firstName ?? "");
    // await LocalAppDatabase.setString(
    //     Strings.loginLastName, registerResponse.data?.user?.lastName ?? "");

    await LocalAppDatabase.setString(
        Strings.loginEmail, registerResponse.data?.user?.email ?? "");
    await LocalAppDatabase.setString(Strings.userChannelType,
        registerResponse.data?.user?.userChannelType ?? "");
    // await LocalAppDatabase.setString(Strings.tripAvailable,
    //     loginResponse.data?.user?.tripsAvailable.toString() ?? "");
    await LocalAppDatabase.setString(Strings.userCurrency,
        registerResponse.data?.user?.currency.toString() ?? "0");
  }

  static Future setRegisterProfileResponse(
      UpdateUserProfileResponse updateUserProfileResponse) async {
    await LocalAppDatabase.setString(
        Strings.loginUserId, updateUserProfileResponse.data?.user?.id ?? "");
    await LocalAppDatabase.setString(Strings.loginFirstName,
        updateUserProfileResponse.data?.user?.firstName ?? "");
    await LocalAppDatabase.setString(Strings.loginLastName,
        updateUserProfileResponse.data?.user?.lastName ?? "");
    await LocalAppDatabase.setString(
        Strings.loginEmail, updateUserProfileResponse.data?.user?.email ?? "");
    await LocalAppDatabase.setString(Strings.userChannelType,
        updateUserProfileResponse.data?.user?.userChannelType ?? "");
    await LocalAppDatabase.setString(Strings.userCurrency,
        updateUserProfileResponse.data?.user?.currency.toString() ?? "0");
  }

  static Future setUserCurrency(
      UpdateUserProfileResponse updateUserProfileResponse) async {
    await LocalAppDatabase.setString(
      Strings.userCurrency,
      updateUserProfileResponse.data?.user?.currency.toString() ?? "0",
    );
  }

  static Future setUserTrips(
      CheckAvailableTripResponse checkAvailableTripResponse) async {
    await LocalAppDatabase.setString(
      Strings.tripAvailable,
      checkAvailableTripResponse.data?.availableTripsCount.toString() ?? "0",
    );
  }

  static Future setEditProfileResponse({
    required UpdateUserProfileResponse editProfileResponse,
  }) async {
    await LocalAppDatabase.setString(Strings.loginFirstName,
        editProfileResponse.data?.user?.firstName ?? "");
    await LocalAppDatabase.setString(
        Strings.loginLastName, editProfileResponse.data?.user?.lastName ?? "");
  }

  static Future<void> updateUserProfile(
      {required String? userName,
      required String? departmentType,
      required String? instagramLink,
      required String? linkedinLink}) async {
    await LocalAppDatabase.setString(Strings.loginUserName, userName ?? "");

    await LocalAppDatabase.setString(
        Strings.loginUserLinkedinLink, linkedinLink ?? "");
    await LocalAppDatabase.setString(
        Strings.loginUserInstagramLink, instagramLink ?? "");
  }

  static Future<void> updateUserUniversity(
      {required String? userUniversity}) async {
    await LocalAppDatabase.setString(
        Strings.loginUserUniversity, userUniversity ?? "");
  }

  static Future<void> updateUserProfilePicture({
    required String? profilePicture,
  }) async {
    await LocalAppDatabase.setString(
        Strings.loginProfilePicture, profilePicture ?? "");
  }

  static clearPreferences() {
    _prefsInstance?.clear();
  }

  /// Single Key Remove
  static clearPreferencesKey({required String keyName}) {
    _prefsInstance?.remove(keyName);
  }
}
