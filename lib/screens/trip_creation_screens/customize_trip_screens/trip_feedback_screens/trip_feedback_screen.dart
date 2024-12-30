import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/trip_creation_screens/customize_export.dart';
import 'package:provider/provider.dart';

class TripFeedbackScreen extends StatefulWidget {
  final String tripId;

  const TripFeedbackScreen({
    Key? key,
    required this.tripId,
  }) : super(key: key);

  @override
  State<TripFeedbackScreen> createState() => _TripFeedbackScreenState();
}

class _TripFeedbackScreenState extends State<TripFeedbackScreen> {
  late CustomizeTripProvider customizeTripProvider;

  //Controller
  final feedbackController = TextEditingController();
  bool onUserValidationClick = false;

  bool isSuperb = false;
  bool isGood = false;
  bool isNormal = false;
  bool isBad = false;
  bool isLoadingState = false;

  @override
  void initState() {
    // TODO: implement initState

    customizeTripProvider = CustomizeTripProvider();
    customizeTripProvider =
        Provider.of<CustomizeTripProvider>(context, listen: false);
    customizeTripProvider.init(context: context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    feedbackController.dispose();
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
      floatingActionButton: GetStartButtonWithLoader(
        title: "Submit Feedback",
        isLoadingState: isLoadingState,
        onPress: () async {
          validateInputUserData();
        },
      ).get16HorizontalPadding(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: sizes!.height,
          width: sizes!.width,
          color: AppColors.accent02,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  const GetGenericText(
                    text: "Congratulations on Creating this Awesome Trip!",
                    fontFamily: Assets.basement,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainWhite100,
                    lines: 4,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  const GetGenericText(
                    text: "Help us improve by sharing your experience",
                    fontFamily: Assets.aileron,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainWhite100,
                    lines: 2,
                  ).getAlign(),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSuperb = !isSuperb;
                        isGood = false;
                        isNormal = false;
                        isBad = false;
                      });
                    },
                    child: Container(
                      height: sizes!.heightRatio * 66,
                      width: sizes!.widthRatio * 360,
                      decoration: BoxDecoration(
                        color: AppColors.mainPureWhite,
                        borderRadius: BorderRadius.circular(10),
                        border: isSuperb
                            ? Border.all(
                                color: AppColors.mainBlack100,
                                width: 1,
                              )
                            : null,
                        boxShadow: isSuperb
                            ? [
                                const BoxShadow(
                                  color: AppColors.mainBlack100,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(
                                    -4,
                                    4,
                                  ), // changes position of shadow
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const GetGenericText(
                            text: "😍",
                            fontFamily: Assets.aileron,
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainPureWhite,
                            lines: 1,
                          ),
                          CommonPadding.sizeBoxWithWidth(width: 12),
                          const GetGenericText(
                            text: "Superb!",
                            fontFamily: Assets.basement,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSuperb = false;
                            isGood = !isGood;
                            isNormal = false;
                            isBad = false;
                          });
                        },
                        child: Container(
                          height: sizes!.heightRatio * 97,
                          width: sizes!.widthRatio * 100,
                          decoration: BoxDecoration(
                            color: AppColors.mainPureWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: isGood
                                ? Border.all(
                                    color: AppColors.mainBlack100,
                                    width: 1,
                                  )
                                : null,
                            boxShadow: isGood
                                ? [
                                    const BoxShadow(
                                      color: AppColors.mainBlack100,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(
                                          -4, 4), // changes position of shadow
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const GetGenericText(
                                text: "😊",
                                fontFamily: Assets.aileron,
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainPureWhite,
                                lines: 1,
                              ),
                              CommonPadding.sizeBoxWithHeight(height: 10),
                              const GetGenericText(
                                text: "Good",
                                fontFamily: Assets.basement,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.mainBlack100,
                                lines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSuperb = false;
                            isGood = false;
                            isNormal = !isNormal;
                            isBad = false;
                          });
                        },
                        child: Container(
                          height: sizes!.heightRatio * 97,
                          width: sizes!.widthRatio * 100,
                          decoration: BoxDecoration(
                            color: AppColors.mainPureWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: isNormal
                                ? Border.all(
                                    color: AppColors.mainBlack100,
                                    width: 1,
                                  )
                                : null,
                            boxShadow: isNormal
                                ? [
                                    const BoxShadow(
                                      color: AppColors.mainBlack100,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(
                                          -4, 4), // changes position of shadow
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const GetGenericText(
                                text: "😐",
                                fontFamily: Assets.aileron,
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainPureWhite,
                                lines: 1,
                              ),
                              CommonPadding.sizeBoxWithHeight(height: 10),
                              const GetGenericText(
                                text: "Normal",
                                fontFamily: Assets.basement,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.mainBlack100,
                                lines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSuperb = false;
                            isGood = false;
                            isNormal = false;
                            isBad = !isBad;
                          });
                        },
                        child: Container(
                          height: sizes!.heightRatio * 97,
                          width: sizes!.widthRatio * 100,
                          decoration: BoxDecoration(
                            color: AppColors.mainPureWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: isBad
                                ? Border.all(
                                    color: AppColors.mainBlack100,
                                    width: 1,
                                  )
                                : null,
                            boxShadow: isBad
                                ? [
                                    const BoxShadow(
                                      color: AppColors.mainBlack100,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(
                                          -4, 4), // changes position of shadow
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const GetGenericText(
                                text: "😞",
                                fontFamily: Assets.aileron,
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainPureWhite,
                                lines: 1,
                              ),
                              CommonPadding.sizeBoxWithHeight(height: 10),
                              const GetGenericText(
                                text: "Bad",
                                fontFamily: Assets.basement,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.mainBlack100,
                                lines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 44),
                  getTextFieldFeedbackWithValidation(
                    heading: "Add Comment (Optional)",
                    controller: feedbackController,
                    hintText: "Write your comment here...",
                    errorText:
                        onUserValidationClick ? _feedbackErrorText : null,
                    setState: setState,
                    textInputType: TextInputType.text,
                    maxLines: 8,
                  ),
                  CommonPadding.sizeBoxWithHeight(height: 90),
                ],
              ).get16HorizontalPadding(),
            ),
          ),
        ),
      ),
    );
  }

  // Email Error Handler
  String? get _feedbackErrorText {
    final text = feedbackController.value.text.trim().toString();

    // if (text.isEmpty) {
    //   return 'Can\'t be empty';
    // }
    // return null if the text is valid
    return null;
  }

  // Validate User Input Data
  void validateInputUserData() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // set onUserValidationClick = true
    setState(() => onUserValidationClick = true);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const SupportSubmittedScreen()),
    // );

    var selected = "Superb";
    if (isSuperb) {
      selected = "Superb";
    } else if (isGood) {
      selected = "Good";
    } else if (isNormal) {
      selected = "Normal";
    } else if (isBad) {
      selected = "Bad";
    } else {
      Toasts.getWarningToast(text: "Please select any experience");
    }

    var feedback = feedbackController.value.text.trim().toString();
    //Call API
    setState(() {
      isLoadingState = true;
    });
    await customizeTripProvider.userRateTrip(
      tripId: widget.tripId,
      experience: selected,
      comment: feedback,
      context: context,
    );

    //Success
    if (customizeTripProvider.isRateTrip) {
      setState(() {
        isLoadingState = false;
      });

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SupportSubmittedScreen(),
          ),
        );
      }
    } else {
      setState(() {
        isLoadingState = false;
      });
    }
  }

  /// Text Field Feedback Container [getTextFieldFeedbackWithValidation]
  Widget getTextFieldFeedbackWithValidation({
    required String heading,
    required TextEditingController controller,
    required String hintText,
    @required String? errorText,
    required Function setState,
    required TextInputType textInputType,
    required int maxLines,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
                text: "Add Comment ",
                style: TextStyle(
                  fontFamily: Assets.aileron,
                  fontSize: sizes!.fontRatio * 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainWhite100,
                ),
                children: [
                  TextSpan(
                    text: "(Optional)",
                    style: TextStyle(
                      fontFamily: Assets.aileron,
                      fontSize: sizes!.fontRatio * 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainWhite100,
                    ),
                  )
                ]),
          ),
          CommonPadding.sizeBoxWithHeight(height: 8),
          TextFormField(
            onChanged: (_) => setState(() {}),
            autocorrect: true,
            controller: controller,
            //When Keyboard will appear, text field will move up
            scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            keyboardType: textInputType,
            maxLines: maxLines,
            style: TextStyle(
              color: AppColors.mainWhite100,
              fontFamily: Assets.aileron,
              fontWeight: FontWeight.w400,
              fontSize: sizes!.fontRatio * 16,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.mainWhite100,
                fontFamily: Assets.aileron,
                fontSize: sizes!.fontRatio * 16,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.only(
                bottom: sizes!.heightRatio * 15,
                top: sizes!.heightRatio * 15,
                right: sizes!.widthRatio * 10,
                left: sizes!.widthRatio * 10,
              ),
              errorText: errorText,
              errorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.redTwoColor, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.mainWhite100, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.redTwoColor, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.mainWhite100, width: 2),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      );
}
