// Created by Tayyab Mughal on 02/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/local_app_database/local_app_database.dart';
import 'package:planify/project_widgets/get_generic_text_widget.dart';
import 'package:planify/screens/setting_screens/currency_setting_screens/currency_provider.dart';
import 'package:provider/provider.dart';

class CurrencySettingScreen extends StatefulWidget {
  const CurrencySettingScreen({Key? key}) : super(key: key);

  @override
  State<CurrencySettingScreen> createState() => _CurrencySettingScreenState();
}

class _CurrencySettingScreenState extends State<CurrencySettingScreen> {
  // final listOfCurrency = ["\$ USD", "€ EURO"];
  final listOfCurrency = ["USD", "EURO", "INR"];
  // var selectCurrency =
  //     LocalAppDatabase.getString(Strings.userCurrency)?.toUpperCase() ?? "USD";
  String selectCurrency = 'EURO';

  late CurrencyProvider currencyProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrency();
    currencyProvider = CurrencyProvider();
    currencyProvider = Provider.of<CurrencyProvider>(context, listen: false);
    currencyProvider.init(context: context);
  }

  Future<String?> getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var curr = prefs.getString('currencyName');
    print("currcurrcurr $curr");
    setState(() {
      selectCurrency = curr!;
    });
    return curr;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CurrencyProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainWhiteBg,
        elevation: 0,
        foregroundColor: AppColors.mainBlack100,
      ),
      body: Container(
        color: AppColors.mainWhiteBg,
        child: SafeArea(
          child: Column(
            children: [
              const GetGenericText(
                text: "Currency Settings",
                fontFamily: Assets.basement,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.mainBlack100,
                lines: 1,
              ).getAlign(),
              CommonPadding.sizeBoxWithHeight(height: 18),
              Container(
                height: sizes!.heightRatio * 50,
                width: sizes!.widthRatio * 360,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.mainBlack100,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    icon: Padding(
                      padding: EdgeInsets.only(right: sizes!.widthRatio * 10),
                      child: SvgPicture.asset(
                        "assets/svg/dropmenu_icon.svg",
                        height: sizes!.heightRatio * 12,
                        width: sizes!.widthRatio * 12,
                        color: AppColors.mainBlack100,
                      ),
                    ),
                    hint: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizes!.widthRatio * 10,
                      ),
                      child: GetGenericText(
                        text: selectCurrency,
                        fontFamily: Assets.aileron,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mainBlack100,
                        lines: 1,
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: Assets.aileron,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainBlack100,
                    ),
                    underline: const SizedBox(),
                    isExpanded: true,
                    // value: currencyProvider.,
                    items: listOfCurrency.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: GetGenericText(
                          text: value,
                          fontFamily: Assets.aileron,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainBlack100,
                          lines: 1,
                        ),
                      );
                    }).toList(),
                    onChanged: null,
                  ),
                ),
              ),
              CommonPadding.sizeBoxWithHeight(height: 16),
              const GetGenericText(
                text:
                    "This setting will change the default currency in which Budget will be shown in the Trip creation process.",
                fontFamily: Assets.aileron,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.mainBlack100,
                lines: 3,
              )
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }
}
