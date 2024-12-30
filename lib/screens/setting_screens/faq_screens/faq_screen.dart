// Created by Tayyab Mughal on 18/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/project_widgets.dart';
import 'package:planify/screens/setting_screens/faq_screens/faq_provider.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  // Provider
  late FaqProvider faqProvider;

  bool isOpened = false;
  int currentIndex = 0;

  final appBar = AppBar(
    foregroundColor: AppColors.mainBlack100,
    backgroundColor: AppColors.mainWhiteBg,
    elevation: 0,
  );

  final questionAndAnswersList = [
    {
      "question": "Can I trust the generated itineraries from Planify.holiday?",
      "answer":
          "Absolutely! Our AI technology is designed to take into account your personal preferences, necessities, and interests to create the perfect itinerary for you. Think of it as having a personal travel assistant who knows exactly what you like and need."
    },
    {
      "question":
          "What if I change my mind about certain activities or places on the itinerary?",
      "answer":
          "No problem! Our app allows you to easily modify or customize your itinerary at any time. Simply input your new preferences or remove any activities you're no longer interested in, and the AI will adjust your itinerary accordingly."
    },
    {
      "question": "Is Planify.holiday only for certain types of travelers?",
      "answer":
          "Not at all! Planify.holiday is perfect for all types of travelers, from solo adventurers to families and everything in between. Our AI technology is designed to create personalized itineraries for any type of traveler, no matter their preferences or necessities."
    },
    {
      "question": "What if I have a question or need help with my itinerary?",
      "answer":
          "We're always here to help! Our customer support team is available 24/7 to assist you with any questions or concerns you may have. You can reach us via email or through our in-app support feature."
    },
    {
      "question": "Can Planify.holiday help me plan international trips?",
      "answer":
          "Absolutely! Our AI technology is designed to create personalized itineraries for any destination, whether it's domestic or international. Just input your destination and preferences, and let the AI do the rest!"
    },
    {
      "question": "Is Planify.holiday environmentally friendly?",
      "answer":
          "Yes, we are committed to promoting sustainable tourism and minimizing our impact on the environment. Our AI technology is designed to create itineraries that prioritize eco-friendly activities and transportation options, so you can travel with a clear conscience."
    },
    {
      "question": "Can I use Planify.holiday for business trips?",
      "answer":
          "Of course! Our AI technology can create itineraries that prioritize business meetings, networking events, and other work-related activities, while still providing opportunities for leisure and relaxation."
    },
  ];

  @override
  void initState() {
    super.initState();

    faqProvider = FaqProvider();
    faqProvider = Provider.of<FaqProvider>(context, listen: false);
    faqProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // faqProvider.getFaqDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<FaqProvider>(context, listen: true);
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: AppColors.mainWhiteBg,
        child: SafeArea(
          child: Column(
            children: [
              const GetGenericText(
                text: "Frequently Asked Questions",
                fontFamily: Assets.basement,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.greyScale1000,
                lines: 2,
              ).getAlign(),
              CommonPadding.sizeBoxWithHeight(height: 14),

              /// List of FAQ
              Expanded(
                child: ListView.builder(
                  itemCount: questionAndAnswersList.length,
                  itemBuilder: (context, index) {
                    //Data
                    var data = questionAndAnswersList[index];
                    var question = data['question'].toString();
                    var answer = data['answer'].toString();

                    return faqContainer(
                      faqNumber: index + 1,
                      index: index,
                      onPress: () {
                        setState(() {
                          isOpened = !isOpened;
                          currentIndex = index;
                        });
                      },
                      isOpened: isOpened,
                      question: question,
                      answer: answer,
                    );
                  },
                ),
              )
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  // Faq Container
  Widget faqContainer({
    required String question,
    required String answer,
    required int faqNumber,
    required Function onPress,
    required bool isOpened,
    required int index,
  }) =>
      GestureDetector(
        onTap: () => onPress.call(),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GetGenericText(
                      text: question,
                      fontFamily: Assets.basement,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.mainBlack100,
                      lines: 3,
                    ),
                  ),
                  (index == currentIndex && isOpened == true)
                      ? SvgPicture.asset(
                          "assets/svg/top_arrow_icon.svg",
                          height: sizes!.heightRatio * 24,
                          width: sizes!.widthRatio * 24,
                        )
                      : SvgPicture.asset(
                          "assets/svg/down_arrow_icon.svg",
                          height: sizes!.heightRatio * 24,
                          width: sizes!.widthRatio * 24,
                        ),
                ],
              ),
              Visibility(
                visible: (index == currentIndex && isOpened == true),
                child: CommonPadding.sizeBoxWithHeight(height: 8),
              ),
              Visibility(
                visible: (index == currentIndex && isOpened == true),
                child: GetGenericText(
                  text: answer,
                  fontFamily: Assets.aileron,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.pastelsGreyFiveColor,
                  lines: 10,
                ),
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
              const Divider(
                color: AppColors.gray4Color,
                thickness: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 8),
            ],
          ),
        ),
      );
}
