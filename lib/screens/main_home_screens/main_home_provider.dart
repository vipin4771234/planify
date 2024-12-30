// Created by Tayyab Mughal on 08/06/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';

class MainHomeProvider extends ChangeNotifier {
  BuildContext? context;

  int selectedIndex = 0;

  // bool isNewBadge = false;

  // // Loader and Logger
  // final _loader = Loader();
  // final _logger = Logger();

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    // firebaseNotification();
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

// void isNewBadgeState() {
//   isNewBadge = false;
//   notifyListeners();
// }

//Firebase Notification
// Future<void> firebaseNotification() async {
//   /// Foreground Notification While the app running state
//   // On Message
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     try {
//       debugPrint('Got a message whilst in the foreground!');
//       debugPrint('onExplore: ${message.data}');
//       isNewBadge = true;
//     } catch (e) {
//       debugPrint("onMessageError: $e");
//     }
//   });
//
//   // On Message Opened App
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     try {
//       debugPrint('Got a message whilst in the foreground!');
//       debugPrint('onExplore: ${message.data}');
//       isNewBadge = false;
//     } catch (e) {
//       debugPrint("onMessageError: $e");
//     }
//   });
//
//   notifyListeners();
// }
}
