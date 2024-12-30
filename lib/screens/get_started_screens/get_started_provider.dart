import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_animations/slide_right.dart';
import 'package:planify/app_resources/app_strings.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/push_notification_service/firebase_push_notification_service.dart';
import 'package:planify/screens/main_home_screens/main_home_screen.dart';

class GetStartedProvider extends ChangeNotifier {
  BuildContext? context;
  final Logger _logger = Logger();
  bool isChecking = false;
  bool isUserLogin = false;

  Future<void> init({@required BuildContext? context}) async {
    LocalAppDatabase.init();
    this.context = context;
    isUserLogin = false;

    /// Initializing Push Notification Service
    await FirebasePushNotificationService.initializeNotification(
      userTopic: "planify",
    );

    await navigateToScreen(context: context!);
  }

  Future<void> navigateToScreen({required BuildContext context}) async {
    await Future.delayed(const Duration(
      seconds: 2,
    ));
    var email = LocalAppDatabase.getString(Strings.loginEmail);
    var token = LocalAppDatabase.getString(Strings.loginUserToken);
    _logger.d("NavigateToScreen: email: $email, token: $token");

    if (email != "" && token != "") {
      isChecking = true;
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainHomeScreen(),
            ),
            (route) => false);
      }
    } else {
      isChecking = true;
      // Login Screen
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          SlideRightRoute(
            page: const MainHomeScreen(),
          ),
        );
      }
    }
    notifyListeners();
  }
}
