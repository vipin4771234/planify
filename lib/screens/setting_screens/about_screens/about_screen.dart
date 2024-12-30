// Created by Tayyab Mughal on 18/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/get_generic_text_widget.dart';
import 'package:planify/screens/setting_screens/about_screens/about_provider.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AboutUsProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.mainBlack100,
        backgroundColor: AppColors.mainWhiteBg,
        elevation: 0,
      ),
      body: Container(
        color: AppColors.mainWhiteBg,
        child: SafeArea(
          child: Column(
            children: [
              const GetGenericText(
                text: "About Us",
                fontFamily: Assets.basement,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.greyScale1000,
                lines: 1,
              ).getAlign(),
              CommonPadding.sizeBoxWithHeight(height: 12),
              const GetGenericText(
                text:
                    "Welcome to Planify.holiday, the app that does the boring stuff so you can focus on having a blast on your next trip!\n\n"
                    "We know that planning a vacation can be a real pain in the butt. Figuring out where to go, what to do, and where to stay can be overwhelming, not to mention time-consuming. But fear not, fellow Gen Z-ers and Millennials! Planify. holiday is here to save the day (or, well, your holiday).\n\n"
                    "With our super-duper AI algorithms, we'll create a personalized trip itinerary just for you. All you have to do is tell us your preferences and necessities, and we'll take care of the rest. Want to hit up all the best foodie spots? We got you. Prefer outdoor adventures? No problemo. Need to find the most Instagrammable spots? We've got your back.\n\n"
                    "And the best part? Our app is designed to be as fun and engaging as possible. Whether you're a solo traveler, a couple on a romantic getaway, or a group of friends looking to let loose, Planify holiday has got you covered.\n\n"
                    "In short, Planify holiday is the app that takes the stress out of travel planning and helps you make the most of your time off.",
                fontFamily: Assets.aileron,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.greyScale900,
                lines: 30,
              )
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }
}
