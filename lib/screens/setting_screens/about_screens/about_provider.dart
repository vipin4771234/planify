// Created by Tayyab Mughal on 21/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:planify/app_resources/app_resources.dart';

class AboutUsProvider extends ChangeNotifier {
  BuildContext? context;

  // Loader and Logger
  final _loader = Loader();
  final _logger = Logger();

  bool isAboutUsLoaded = false;

  // Init
  Future<void> init({@required BuildContext? context}) async {
    this.context = context;
    isAboutUsLoaded = false;
  }
}
