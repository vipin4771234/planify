import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class VerifyButtonContainer extends StatelessWidget {
  final String title;
  final Function onPress;

  const VerifyButtonContainer({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress.call(),
      child: Container(
        height: sizes!.heightRatio * 50,
        width: sizes!.widthRatio * 100,
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.mainBlack,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.mainBlack,
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: GradientText(
          title,
          style: TextStyle(
            fontSize: sizes!.fontRatio * 18,
            fontWeight: FontWeight.w800,
            //fontFamily: "Basement-Bold",
          ),
          colors: const [
            AppColors.getStartGradientOne,
            AppColors.getStartGradientTwo,
            AppColors.getStartGradientThree,
          ],
        )),
      ),
    );
  }
}
