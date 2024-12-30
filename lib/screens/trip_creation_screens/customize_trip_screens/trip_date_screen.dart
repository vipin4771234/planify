// Created by Tayyab Mughal on 24/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TripDateScreen extends StatefulWidget {
  final String relationship;
  final String numberOfMembers;
  final String budget;
  final String budgetType;
  final String moodType;

  const TripDateScreen({
    Key? key,
    required this.relationship,
    required this.numberOfMembers,
    required this.budget,
    required this.budgetType,
    required this.moodType,
  }) : super(key: key);

  @override
  State<TripDateScreen> createState() => _TripDateScreenState();
}

class _TripDateScreenState extends State<TripDateScreen> {
  // Date Picker
  String _selectedDate = '';
  String _dateCount = '';
  String _range =
      '${DateFormat('MMM dd yyyy').format(DateTime.now()).toString()} - ${DateFormat('MMM dd yyyy').format(DateTime.now().add(const Duration(days: 4))).toString()}';
  String _rangeCount = '';

  bool isDoesnotCare = false;

  String startingDate = '';
  String endDate = '';
  int numberOfDays = 0;

  @override
  void initState() {
    super.initState();

    ///Default Value
    numberOfDays = 5;
  }

  @override
  void dispose() {
    super.dispose();
  }

  // On Selection Changed
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat("MMM dd yyyy").format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat("MMM dd yyyy").format(args.value.endDate ?? args.value.startDate)}';

        startingDate = DateFormat("MMM dd yyyy").format(args.value.startDate);
        endDate = DateFormat("MMM dd yyyy")
            .format(args.value.endDate ?? args.value.startDate);

        /// Calander Dating Difference
        final test01 = args.value.startDate;
        final test02 = args.value.endDate;
        if (test02 != null) {
          numberOfDays = test02.difference(test01).inDays + 1;
          debugPrint("difference: $numberOfDays");
        }

        debugPrint(
            "_range: $_range, -> startingDate: $startingDate, endDate: $endDate ");
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        debugPrint("_selectedDate: $_selectedDate");
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
        debugPrint("_dateCount: $_dateCount");
      } else {
        _rangeCount = args.value.length.toString();
        debugPrint("_rangeCount: $_rangeCount");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        },
      ).get16HorizontalPadding(),
      body: Container(
        height: sizes!.height,
        width: sizes!.width,
        decoration: const BoxDecoration(
          color: AppColors.accent02,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonPadding.sizeBoxWithHeight(height: 30),
                const GetGenericText(
                  text: 'When do you intend to go to the trip? 🗓',
                  fontFamily: Assets.basement,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.mainWhite,
                  lines: 3,
                ),
                CommonPadding.sizeBoxWithHeight(height: 30),
                const GetGenericText(
                  text: "Starting Trip Date",
                  fontFamily: Assets.aileron,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainWhite,
                  lines: 1,
                ).getAlign(),
                CommonPadding.sizeBoxWithHeight(height: 8),
                // Starting Trip Date
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: sizes!.heightRatio * 50,
                    width: sizes!.widthRatio * 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: AppColors.mainWhite),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizes!.widthRatio * 12,
                        vertical: sizes!.heightRatio * 14,
                      ),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetGenericText(
                                text: _range,
                                fontFamily: Assets.aileron,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.mainWhite,
                                lines: 1,
                              ),
                              // SvgPicture.asset(
                              //   "assets/svg/calendar_icon.svg",
                              //   height: sizes!.heightRatio * 24,
                              //   width: sizes!.widthRatio * 24,
                              //   color: AppColors.mainBlack100,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 12),
                const GetGenericText(
                  text:
                      "Note: For now, you can only generate Trips of maximum 5 days",
                  fontFamily: Assets.aileron,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mainWhite,
                  lines: 2,
                ).getAlign(),
                CommonPadding.sizeBoxWithHeight(height: 24),

                /// Date Range Picker
                SfDateRangePicker(
                  minDate: DateTime.now(),
                  // backgroundColor: AppColors.mainPureWhite,
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  rangeSelectionColor: AppColors.rangePickerColor,
                  startRangeSelectionColor: AppColors.accent3,
                  endRangeSelectionColor: AppColors.accent3,
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    cellDecoration: BoxDecoration(
                      color: AppColors.pastelsGreyColor,
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                    ),
                    todayTextStyle: const TextStyle(
                      // fontFamily: Assets.aileron,
                      // fontSize: sizes!.fontRatio * 20,
                      // fontWeight: FontWeight.w400,
                      color: AppColors.mainBlack100,
                    ),
                  ),
                  // selectionTextStyle: TextStyle(
                  //   color: AppColors.redOneColor,
                  // ),
                  selectionColor: AppColors.mainWhite,
                  todayHighlightColor: AppColors.mainWhite,
                  initialSelectedRange: PickerDateRange(
                    DateTime.now(),
                    DateTime.now().add(
                      const Duration(days: 4),
                    ),
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 10),

                GestureDetector(
                  onTap: () {
                    validateDataWithoutDate(
                      numberOfDays: "5",
                    );
                    setState(() {
                      isDoesnotCare = !isDoesnotCare;
                    });
                  },
                  child: Container(
                    height: sizes!.heightRatio * 52,
                    width: sizes!.widthRatio * 360,
                    margin: const EdgeInsets.only(bottom: 80),
                    decoration: BoxDecoration(
                      color: AppColors.tripWithColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: GetGenericText(
                        text: "🤷🏻‍ I don't care about dates",
                        fontFamily: Assets.aileron,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.mainWhite,
                        lines: 1,
                      ),
                    ),
                  ),
                ),
                CommonPadding.sizeBoxWithHeight(height: 10),
              ],
            ).get16HorizontalPadding(),
          ),
        ),
      ),
    );
  }

  void validateData() async {
    debugPrint("numberOfDays: $numberOfDays");

    if (numberOfDays <= 1) {
      Toasts.getErrorToast(text: "You can choose upto 5 days.");
    } else if (numberOfDays > 5) {
      Toasts.getErrorToast(text: "You can choose upto 5 days only.");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TripLocationScreen(
            relationship: widget.relationship,
            numberOfMembers: widget.numberOfMembers,
            budget: widget.budget,
            budgetType: widget.budgetType,
            moodType: widget.moodType,
            startingDate: startingDate,
            endDate: endDate,
            numberOfDays: '$numberOfDays',
          ),
        ),
      );
    }
  }

  void validateDataWithoutDate({
    required String numberOfDays,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TripLocationScreen(
          relationship: widget.relationship,
          numberOfMembers: widget.numberOfMembers,
          budget: widget.budget,
          budgetType: widget.budgetType,
          moodType: widget.moodType,
          startingDate: "I don't care",
          endDate: "I don't care",
          numberOfDays: numberOfDays,
        ),
      ),
    );
  }
}
