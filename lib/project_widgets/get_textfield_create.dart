// Created by Tayyab Mughal on 24/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planify/app_resources/app_resources.dart';

import 'get_generic_text_widget.dart';

class GetTextFieldCreate extends StatelessWidget {
  final String heading;
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final Function setState;
  final TextInputType textInputType;
  final int maxLines;

  const GetTextFieldCreate({
    Key? key,
    required this.heading,
    required this.hintText,
    required this.controller,
    this.errorText,
    required this.setState,
    required this.textInputType,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetGenericText(
          text: heading,
          fontFamily: Assets.aileron,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.mainWhite,
          lines: 1,
        ),
        CommonPadding.sizeBoxWithHeight(height: 8),
        TextFormField(
          onChanged: (_) => setState(() {}),
          autocorrect: true,
          controller: controller,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          //When Keyboard will appear, text field will move up
          scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          keyboardType: textInputType,
          maxLines: maxLines,
          style: const TextStyle(
            color: AppColors.mainWhite,
            fontFamily: Assets.aileron,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.mainWhite,
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
            errorText: errorText,
            errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.mainWhite, width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.mainWhite, width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.mainWhite, width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.mainWhite, width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }
}
