import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';

class GetChipContainer extends StatelessWidget {
  final String title;
  final bool isSelected;
  final int width;
  final Function onPress;

  const GetChipContainer(
      {Key? key,
      required this.title,
      required this.isSelected,
      required this.width,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress.call(),
      child: Container(
        height: sizes!.heightRatio * 52,
        width: sizes!.widthRatio * width,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainPureWhite : AppColors.tripWithColor,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(
                  color: AppColors.mainBlack,
                  width: 3,
                )
              : null,
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: AppColors.mainBlack,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: Offset(-4, 4), // changes position of shadow
                  ),
                ]
              : null,
        ),
        child: Center(
          child: GetGenericText(
            text: title,
            fontFamily: Assets.aileron,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColors.mainBlack100,
            lines: 1,
          ),
        ),
      ),
    );
  }
}
