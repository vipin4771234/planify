// Created by Tayyab Mughal on 12/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String appLanguageCode = 'languageCode';
const String isCurrentLanguage = "0";

//languages code
const String appEnglishLang = 'en';
const String appSpanishLang = 'es';
const String appFrenchLang = 'fr';
const String appItalianLang = 'it';
const String appChineseLang = 'ch';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(appLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(appLanguageCode) ?? appEnglishLang;
  return _locale(languageCode);
}

Future<void> setLanguageCode(String isCurrentLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(isCurrentLanguage, isCurrentLanguage);
}

Future<String> getLanguageCode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var currentLanguage = prefs.getString(isCurrentLanguage) ?? "0";
  debugPrint("currentLanguage: $currentLanguage");
  return currentLanguage;
}

/// Locale
Locale _locale(String languageCode) {
  switch (languageCode) {
    case appEnglishLang:
      return const Locale(appEnglishLang, "");
    case appSpanishLang:
      return const Locale(appSpanishLang, "");
    case appFrenchLang:
      return const Locale(appFrenchLang, "");
    case appItalianLang:
      return const Locale(appItalianLang, "");
    // case CHINESE:
    //   return const Locale(CHINESE, "");
    default:
      return const Locale(appEnglishLang, "");
  }
}

/// return translation
AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
