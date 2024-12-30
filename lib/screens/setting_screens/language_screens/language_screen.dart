// Created by Tayyab Mughal on 18/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/app_languages/language_constants.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/main.dart';
import 'package:planify/project_widgets/get_generic_text_widget.dart';

enum LanguageCode {
  en,
  es,
  fr,
  it,
}

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Current Language
  int isCurrentLanguage = 0;

  final appBar = AppBar(
    foregroundColor: AppColors.mainBlack100,
    backgroundColor: AppColors.mainWhiteBg,
    elevation: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getLanguageCode().then((value) {
    //   isCurrentLanguage = int.parse(value);
    //   debugPrint("isCurrentLanguage:$isCurrentLanguage");
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: AppColors.mainWhiteBg,
        child: SafeArea(
          child: Column(
            children: [
              const GetGenericText(
                text: "Language Selection",
                fontFamily: Assets.basement,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.greyScale1000,
                lines: 1,
              ).getAlign(),
              CommonPadding.sizeBoxWithHeight(height: 14),
              // English Language
              englishLanguage(
                onPress: () {},
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              const Divider(
                color: AppColors.mainGray4Divider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              // Spanish Language
              spanishLanguage(
                onPress: () {},
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              const Divider(
                color: AppColors.mainGray4Divider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              // French Language
              frenchLanguage(
                onPress: () {},
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              const Divider(
                color: AppColors.mainGray4Divider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              // Italian Language
              italianLanguage(
                onPress: () {},
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              const Divider(
                color: AppColors.mainGray4Divider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              // Chinese Language
              chineseLanguage(
                onPress: () {},
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              const Divider(
                color: AppColors.mainGray4Divider,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  // English Language
  Widget englishLanguage({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/svg/eng_flag.svg"),
              CommonPadding.sizeBoxWithWidth(width: 12),
              const GetGenericText(
                  text: "English",
                  fontFamily: Assets.aileron,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainBlack100,
                  lines: 1),
              const Spacer(),
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    return AppColors.primaryBlueColor;
                  }),
                  activeColor: AppColors.primaryBlueColor,
                  value: 0,
                  groupValue: isCurrentLanguage,
                  onChanged: (value) {
                    setState(() {
                      isCurrentLanguage = value!;
                      returnCurrentLanguage(language: isCurrentLanguage);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

  // Spanish Language
  Widget spanishLanguage({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/svg/spain_flag.svg"),
              CommonPadding.sizeBoxWithWidth(width: 12),
              const GetGenericText(
                  text: "Spanish",
                  fontFamily: Assets.aileron,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainBlack100,
                  lines: 1),
              const Spacer(),
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    return AppColors.primaryBlueColor;
                  }),
                  activeColor: AppColors.primaryBlueColor,
                  value: 1,
                  groupValue: isCurrentLanguage,
                  onChanged: (value) {
                    setState(() {
                      isCurrentLanguage = value!;
                      returnCurrentLanguage(language: isCurrentLanguage);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

  // French Language
  Widget frenchLanguage({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/svg/fran_flag.svg"),
              CommonPadding.sizeBoxWithWidth(width: 12),
              const GetGenericText(
                  text: "French",
                  fontFamily: Assets.aileron,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainBlack100,
                  lines: 1),
              const Spacer(),
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    return AppColors.primaryBlueColor;
                  }),
                  activeColor: AppColors.primaryBlueColor,
                  value: 2,
                  groupValue: isCurrentLanguage,
                  onChanged: (value) {
                    setState(() {
                      isCurrentLanguage = value!;
                      returnCurrentLanguage(language: isCurrentLanguage);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

  // Italian Language
  Widget italianLanguage({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/svg/italy_flag.svg"),
              CommonPadding.sizeBoxWithWidth(width: 12),
              const GetGenericText(
                  text: "Italian",
                  fontFamily: Assets.aileron,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainBlack100,
                  lines: 1),
              const Spacer(),
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    return AppColors.primaryBlueColor;
                  }),
                  activeColor: AppColors.primaryBlueColor,
                  value: 3,
                  groupValue: isCurrentLanguage,
                  onChanged: (value) {
                    setState(() {
                      isCurrentLanguage = value!;
                      returnCurrentLanguage(language: isCurrentLanguage);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

  // Chinese Language
  Widget chineseLanguage({
    required Function onPress,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/svg/chinese_flag.svg"),
              CommonPadding.sizeBoxWithWidth(width: 12),
              const GetGenericText(
                  text: "Chinese",
                  fontFamily: Assets.aileron,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainBlack100,
                  lines: 1),
              const Spacer(),
              Transform.scale(
                scale: 1.5,
                child: Radio(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    return AppColors.primaryBlueColor;
                  }),
                  activeColor: AppColors.primaryBlueColor,
                  value: 4,
                  groupValue: isCurrentLanguage,
                  onChanged: (value) {
                    setState(() {
                      isCurrentLanguage = value!;
                      returnCurrentLanguage(language: isCurrentLanguage);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      );

  ///
  /// Language(1, "🇺🇸", "English", "en"),
  //       Language(2, "🇪🇸", "Spanish", "es"),
  //       Language(3, "🇫🇷", "French", "fr"),
  //       Language(4, "🇮🇹", "Italian", "it"),
  //       // Language(5, "🇨🇳", "Chinese", "ch"),
  ///
  ///
  // Return/Select Current Language
  void returnCurrentLanguage({
    required int language,
  }) async {
    switch (language) {
      case 0:
        Toasts.getWarningToast(text: "Language is changed to English");
        Locale locale = await setLocale('en');
        if (context.mounted) {
          MyApp.setLocale(context, locale);
        }
        break;
      case 1:
        Toasts.getWarningToast(text: "Language is changed to  Spanish");
        Locale locale = await setLocale('es');
        if (context.mounted) {
          MyApp.setLocale(context, locale);
        }
        break;
      case 2:
        Toasts.getWarningToast(text: "Language is changed to French");
        Locale locale = await setLocale('fr');
        if (context.mounted) {
          MyApp.setLocale(context, locale);
        }
        break;
      case 3:
        Toasts.getWarningToast(text: "Language is changed to Italian");
        Locale locale = await setLocale('it');
        if (context.mounted) {
          MyApp.setLocale(context, locale);
        }
        break;
      case 4:
        Toasts.getWarningToast(text: "Language is changed to Chinese");
        break;
      default:
    }
  }
}
