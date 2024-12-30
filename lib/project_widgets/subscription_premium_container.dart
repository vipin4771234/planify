import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';

class SubscriptionPremiumContainer extends StatelessWidget {
  final String offerTitle;
  final String tripTitle;
  final String tripPrice;
  final String tripRealPrice;
  final CustomTimerController controller;
  final Function onPress;

  const SubscriptionPremiumContainer({
    Key? key,
    required this.offerTitle,
    required this.tripTitle,
    required this.tripPrice,
    required this.tripRealPrice,
    required this.controller,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress.call(),
      child: Container(
        // height: sizes!.heightRatio * 300,
        width: sizes!.widthRatio * 360,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.subscriptionGradientColorOne,
                AppColors.subscriptionGradientColorTwo,
                AppColors.subscriptionGradientColorThree,
              ]),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 3,
            color: AppColors.mainBlack100,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.mainBlack100,
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(-4, 4), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonPadding.sizeBoxWithHeight(height: 10),
            Container(
              height: sizes!.heightRatio * 24,
              width: sizes!.widthRatio * 100,
              decoration: BoxDecoration(
                color: AppColors.savingColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.mainBlack100,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: GetGenericText(
                  text: offerTitle,
                  fontFamily: Assets.aileron,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainBlack100,
                  lines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ).getAlign().get16HorizontalPadding(),
            CommonPadding.sizeBoxWithHeight(height: 8),
            GetGenericText(
              text: tripTitle,
              fontFamily: Assets.aileron,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.mainPureWhite,
              lines: 1,
            ).getAlign().get16HorizontalPadding(),
            CommonPadding.sizeBoxWithHeight(height: 8),
            GetGenericText(
              text: tripPrice,
              fontFamily: Assets.basement,
              fontSize: 38,
              fontWeight: FontWeight.w800,
              color: AppColors.mainPureWhite,
              lines: 3,
            ).getAlign().get16HorizontalPadding(),
            CommonPadding.sizeBoxWithHeight(height: 8),
            Text(
              tripRealPrice,
              style: const TextStyle(
                fontFamily: Assets.aileron,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.mainPureWhite,
                decoration: TextDecoration.lineThrough,
              ),
            ).getAlign().get16HorizontalPadding(),
            CommonPadding.sizeBoxWithHeight(height: 8),
            Container(
              height: sizes!.heightRatio * 24,
              width: sizes!.widthRatio * 174,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.redOneColor,
                border: Border.all(color: AppColors.redTwoColor, width: 1),
              ),
              child: Center(
                child: CustomTimer(
                  controller: controller,
                  builder: (state, time) {
                    // debugPrint("seconds:${time.seconds}");
                    // Build the widget you want!🎉
                    return GetGenericText(
                      text:
                          "Discount ending in ${time.hours}:${time.minutes}:${time.seconds}",
                      fontFamily: Assets.aileron,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppColors.redTwoColor,
                      lines: 1,
                    );
                  },
                ),
              ),
            ).getAlign().get16HorizontalPadding(),
            CommonPadding.sizeBoxWithHeight(height: 10),
            const Divider(
              color: AppColors.mainBlack100,
              thickness: 1,
            ).get16HorizontalPadding(),
            CommonPadding.sizeBoxWithHeight(height: 10),
            const GetGenericText(
              text: "10 iterations per trip",
              fontFamily: Assets.aileron,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.mainPureWhite,
              lines: 1,
            ).getAlign().get16HorizontalPadding(),
            CommonPadding.sizeBoxWithHeight(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/svg/greeny_heart_icon.svg"),
                CommonPadding.sizeBoxWithWidth(width: 8),
                const Expanded(
                  child: GetGenericText(
                    text:
                        "With this purchase, you are contributing to remove CO2 from the atmosphere and support sustainability",
                    fontFamily: Assets.aileron,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainPureWhite,
                    lines: 3,
                  ),
                )
              ],
            ).get16HorizontalPadding(),
            CommonPadding.sizeBoxWithHeight(height: 20),
          ],
        ),
      ),
    );
  }
}
