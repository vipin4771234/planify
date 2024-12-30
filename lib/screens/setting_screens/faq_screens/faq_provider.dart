// Created by Tayyab Mughal on 21/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';

class FaqProvider extends ChangeNotifier {
  BuildContext? context;

  // // Loader and Logger
  // final _loader = Loader();
  // final _logger = Logger();

  bool isFaqLoaded = false;

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isFaqLoaded = false;
  }

  /// Get Trip and User Counts
// Future<void> getFaqDetail() async {
//   try {
//     _loader.showAppLoader(context: context!);
//     Map<String, dynamic> header = {"Content-Type": "application/json"};
//     debugPrint("URL: $getFaqDetailApiUrl");
//
//     /// Get Call
//     faqDetailResponse = await NetworkManager.callGetApi(
//       url: getFaqDetailApiUrl,
//       myHeaders: header,
//       modelName: Models.getFaqDetailModel,
//     );
//
//     if (faqDetailResponse.code == 1) {
//       _logger.i("getTripAndUserResponse: ${faqDetailResponse.toJson()}");
//       _loader.hideAppLoader(context: context!);
//       isFaqLoaded = true;
//       notifyListeners();
//     } else {
//       debugPrint("getTripAndUserResponse: Something wrong");
//     }
//   } catch (e) {
//     _loader.hideAppLoader(context: context!);
//     _logger.e("onError: ${e.toString()}");
//   }
// }
}
