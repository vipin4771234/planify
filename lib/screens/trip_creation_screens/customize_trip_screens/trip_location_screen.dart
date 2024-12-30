// Created by Tayyab Mughal on 24/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:provider/provider.dart';

class TripLocationScreen extends StatefulWidget {
  final String relationship;
  final String numberOfMembers;
  final String budget;
  final String budgetType;
  final String moodType;
  final String startingDate;
  final String endDate;
  final String numberOfDays;

  const TripLocationScreen({
    Key? key,
    required this.relationship,
    required this.numberOfMembers,
    required this.budget,
    required this.budgetType,
    required this.moodType,
    required this.startingDate,
    required this.endDate,
    required this.numberOfDays,
  }) : super(key: key);

  @override
  State<TripLocationScreen> createState() => _TripLocationScreenState();
}

class _TripLocationScreenState extends State<TripLocationScreen> {
  // Provider

  late CustomizeTripProvider customizeTripProvider;

  bool isChooseByContinent = true;
  bool isChooseByCountry = false;
  bool isChooseByCity = false;
  bool isOpenLocation = false;

  bool onUserValidationClick = false;

  /// Controllers
  final _cityController = TextEditingController();
  final _travellingFromController = TextEditingController();

  var _selectContinent = "Europe";
  var _selectCountry = "Select Country";

  @override
  void initState() {
    super.initState();

    customizeTripProvider = CustomizeTripProvider();
    customizeTripProvider =
        Provider.of<CustomizeTripProvider>(context, listen: false);
    customizeTripProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      customizeTripProvider.getAllContinents(context: context);
      customizeTripProvider.getCountriesByContinent(
        continentName: _selectContinent,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cityController.dispose();
    _travellingFromController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CustomizeTripProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.accent02,
        foregroundColor: AppColors.mainBlack100,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetStartFullBlackButton(
          title: "Continue",
          onPress: () {
            validateData();
          }).get16HorizontalPadding(),
      body: Container(
        color: AppColors.accent02,
        height: sizes!.height,
        width: sizes!.width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                CommonPadding.sizeBoxWithHeight(height: 30),
                const GetGenericText(
                  text: 'Choose location for your trip 🗺',
                  fontFamily: Assets.basement,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite,
                  lines: 3,
                ),
                CommonPadding.sizeBoxWithHeight(height: 20),
                const GetGenericText(
                  text: "Where are you travelling from?",
                  fontFamily: Assets.basement,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite,
                  lines: 1,
                ).getAlign(),
                CommonPadding.sizeBoxWithHeight(height: 16),
                TextFormField(
                  onChanged: (_) => setState(() {}),
                  autocorrect: true,
                  controller: _travellingFromController,
                  //When Keyboard will appear, text field will move up
                  scrollPadding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.mainWhite,
                    fontFamily: Assets.aileron,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "Eg London, United Kingdom",
                    hintStyle: TextStyle(
                      color: AppColors.mainWhite.withOpacity(0.5),
                      fontFamily: Assets.aileron,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.only(
                      bottom: sizes!.heightRatio * 15,
                      top: sizes!.heightRatio * 15,
                      right: sizes!.widthRatio * 10,
                      left: sizes!.widthRatio * 10,
                    ),
                    // errorText: errorText,
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.redTwoColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.mainWhite,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: onUserValidationClick ? _travellingFrom : null,
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.redTwoColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColors.mainWhite,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 20),
                const GetGenericText(
                  text: "Where are you travelling to?",
                  fontFamily: Assets.basement,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite,
                  lines: 1,
                ).getAlign(),
                CommonPadding.sizeBoxWithHeight(height: 10),

                /// TextFields
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: AppColors.mainBlack100,
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          return AppColors.mainBlack100;
                        }),
                        value: isChooseByContinent,
                        onChanged: (value) {
                          setState(() {
                            isChooseByContinent = value!;
                          });
                        },
                      ),
                    ),
                    const GetGenericText(
                      text: "Choose by Continent",
                      fontFamily: Assets.aileron,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainWhite,
                      lines: 1,
                    )
                  ],
                ),
                Visibility(
                  visible: isChooseByContinent,
                  child: Padding(
                    padding: EdgeInsets.only(left: sizes!.widthRatio * 40),
                    child: Container(
                      height: sizes!.heightRatio * 50,
                      width: sizes!.widthRatio * 360,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.mainWhite,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                          child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        icon: Padding(
                          padding: EdgeInsets.only(
                            right: sizes!.widthRatio * 10,
                          ),
                          child: SvgPicture.asset(
                            "assets/svg/dropmenu_icon.svg",
                            height: sizes!.heightRatio * 12,
                            width: sizes!.widthRatio * 12,
                            color: AppColors.mainWhite,
                          ),
                        ),
                        hint: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: sizes!.widthRatio * 10,
                          ),
                          child: GetGenericText(
                            text: _selectContinent,
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainWhite,
                            lines: 1,
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: Assets.aileron,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.mainBlack100,
                        ),
                        underline: const SizedBox(),
                        isExpanded: true,
                        items: customizeTripProvider.continentNameList
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: GetGenericText(
                              text: value,
                              fontFamily: Assets.aileron,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.mainBlack100,
                              lines: 1,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectContinent = value!;
                            // Toasts.getWarningToast(
                            //     text: "Selected: $_selectContinent");
                          });
                          customizeTripProvider.getCountriesByContinent(
                            continentName: _selectContinent,
                          );
                        },
                      )),
                    ),
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 10),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: AppColors.mainBlack100,
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          return AppColors.mainBlack100;
                        }),
                        value: isChooseByCountry,
                        onChanged: (value) {
                          setState(() {
                            isChooseByCountry = value!;
                            // isChooseByContinent = false;
                          });
                        },
                      ),
                    ),
                    const GetGenericText(
                      text: "Choose by Country",
                      fontFamily: Assets.aileron,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainWhite,
                      lines: 1,
                    )
                  ],
                ),
                Visibility(
                  visible: isChooseByCountry,
                  child: Padding(
                    padding: EdgeInsets.only(left: sizes!.widthRatio * 40),
                    child: Container(
                      height: sizes!.heightRatio * 50,
                      width: sizes!.widthRatio * 360,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.mainWhite,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                          child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        icon: Padding(
                          padding:
                              EdgeInsets.only(right: sizes!.widthRatio * 10),
                          child: SvgPicture.asset(
                            "assets/svg/dropmenu_icon.svg",
                            height: sizes!.heightRatio * 12,
                            width: sizes!.widthRatio * 12,
                            color: AppColors.mainWhite,
                          ),
                        ),
                        hint: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: sizes!.widthRatio * 10,
                          ),
                          child: GetGenericText(
                            text: _selectCountry,
                            fontFamily: Assets.aileron,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainWhite,
                            lines: 1,
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: Assets.aileron,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.mainBlack100,
                        ),
                        underline: const SizedBox(),
                        isExpanded: true,
                        items: customizeTripProvider.countryNameList
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: GetGenericText(
                              text: value,
                              fontFamily: Assets.aileron,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.mainBlack100,
                              lines: 1,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectCountry = value!;
                            // Toasts.getWarningToast(
                            //     text: "Selected: $_selectCountry");
                          });
                        },
                      )),
                    ),
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 10),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: AppColors.mainBlack100,
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          return AppColors.mainBlack100;
                        }),
                        value: isChooseByCity,
                        onChanged: (value) {
                          setState(() {
                            isChooseByCity = value!;

                            // isChooseByContinent = false;
                            // isChooseByCountry = false;
                          });
                        },
                      ),
                    ),
                    const GetGenericText(
                      text: "Choose by City",
                      fontFamily: Assets.aileron,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainWhite100,
                      lines: 1,
                    )
                  ],
                ),
                Visibility(
                  visible: isChooseByCity,
                  child: Padding(
                    padding: EdgeInsets.only(left: sizes!.widthRatio * 40),
                    child: TextFormField(
                      onChanged: (_) => setState(() {}),
                      autocorrect: true,
                      controller: _cityController,
                      //When Keyboard will appear, text field will move up
                      scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppColors.mainWhite100,
                        fontFamily: Assets.aileron,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        hintText: "Ex:- Madrid",
                        hintStyle: const TextStyle(
                          color: AppColors.mainWhite100,
                          fontFamily: Assets.aileron,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: EdgeInsets.only(
                          bottom: sizes!.heightRatio * 15,
                          top: sizes!.heightRatio * 15,
                          right: sizes!.widthRatio * 10,
                          left: sizes!.widthRatio * 10,
                        ),
                        errorText: onUserValidationClick ? _cityTo : null,
                        // errorText: errorText,
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.redTwoColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.mainWhite100,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.redTwoColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.mainWhite100,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 10),
                const GetDividerText(),
                CommonPadding.sizeBoxWithHeight(height: 10),

                /// Surprise Me Container
                GestureDetector(
                  onTap: () {
                    validateDataWithSurpriseMe();
                    setState(() {
                      isOpenLocation = !isOpenLocation;
                    });
                  },
                  child: Container(
                    height: sizes!.heightRatio * 96,
                    width: sizes!.widthRatio * 360,
                    decoration: BoxDecoration(
                      color: AppColors.lowBlackColor,
                      borderRadius: BorderRadius.circular(10),
                      border: isOpenLocation
                          ? Border.all(
                              color: AppColors.mainBlack,
                              width: 3,
                            )
                          : null,
                    ),
                    child: const Center(
                      child: GetGenericText(
                        text: "Surprise me, I am open to any\nlocation 😜",
                        fontFamily: Assets.aileron,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mainWhite100,
                        lines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 90),
              ],
            ).get16HorizontalPadding(),
          ),
        ),
      ),
    );
  }

  String? get _travellingFrom {
    final text = _travellingFromController.value.text.trim().toString();

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  String? get _cityTo {
    final text = _cityController.value.text.trim().toString();
    // debugPrint("texttexttexttext: $text");
    if (isChooseByCity && text.isEmpty) {
      return 'Can\'t be empty';
    }
    // debugPrint("texttexttexttext: $text");
    // return null if the text is valid
    return null;
  }

  void validateData() async {
    FocusManager.instance.primaryFocus?.unfocus();
    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    var travellingFrom = _travellingFromController.value.text.trim().toString();
    var city = _cityController.value.text.trim().toString();
    if (isChooseByCountry) {}
    // && city != ''

    if (_travellingFrom == null && _cityTo == null) {
      var destinationLocation = "$_selectContinent , $_selectCountry, $city";
      debugPrint("destinationLocation: $destinationLocation");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TripAmenitiesScreen(
            relationship: widget.relationship,
            numberOfMembers: widget.numberOfMembers,
            budget: widget.budget,
            budgetType: widget.budgetType,
            moodType: widget.moodType,
            startingDate: widget.startingDate,
            endDate: widget.endDate,
            numberOfDays: widget.numberOfDays,
            destinationLocation: destinationLocation,
            departureLocation: travellingFrom,
            country: _selectCountry,
          ),
        ),
      );
    }
    // else {
    //   Toasts.getErrorToast(text: "The field is required.");
    // }
  }

  void validateDataWithSurpriseMe() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripAmenitiesScreen(
          relationship: widget.relationship,
          numberOfMembers: widget.numberOfMembers,
          budget: widget.budget,
          budgetType: widget.budgetType,
          moodType: widget.moodType,
          startingDate: widget.startingDate,
          endDate: widget.endDate,
          numberOfDays: widget.numberOfDays,
          destinationLocation: "Surprise me",
          departureLocation: "Surprise me",
          country: "Surprise me",
        ),
      ),
    );
  }
}
