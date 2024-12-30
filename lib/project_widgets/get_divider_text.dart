import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';

import 'get_generic_text_widget.dart';

class GetDividerText extends StatelessWidget {
  const GetDividerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.gray4Color,
            thickness: 1,
          ),
        ),
        CommonPadding.sizeBoxWithWidth(width: 12),
        const GetGenericText(
          text: "or",
          fontFamily: Assets.aileron,
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: AppColors.mainWhite100,
          lines: 1,
        ),
        CommonPadding.sizeBoxWithWidth(width: 12),
        const Expanded(
          child: Divider(
            color: AppColors.gray4Color,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
