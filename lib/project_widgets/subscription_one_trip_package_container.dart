import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';

class SubscriptionOneTripPackageContainer extends StatelessWidget {
  final String title;
  final String price;
  final Function onPress;

  const SubscriptionOneTripPackageContainer(
      {Key? key,
      required this.onPress,
      required this.title,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress.call(),
      child: Container(
        height: sizes!.heightRatio * 180,
        width: sizes!.widthRatio * 361,
        decoration: BoxDecoration(
          color: AppColors.gray7Color,
          border: Border.all(color: AppColors.mainBlack100, width: 3),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.mainBlack100,
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(-4, 4), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: sizes!.heightRatio * 10,
            horizontal: sizes!.widthRatio * 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CommonPadding.sizeBoxWithHeight(height: 12),
              GetGenericText(
                text: title,
                fontFamily: Assets.aileron,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.mainBlack100,
                lines: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              GetGenericText(
                text: price,
                fontFamily: Assets.basement,
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: AppColors.mainBlack100,
                lines: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const Divider(
                color: AppColors.mainBlack100,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 10),
              const GetGenericText(
                text: "10 iterations",
                fontFamily: Assets.aileron,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.mainBlack100,
                lines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
