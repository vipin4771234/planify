// Created by Tayyab Mughal on 17/02/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/get_generic_text_widget.dart';
import 'package:planify/screens/notification_screens/notification_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationProvider notificationProvider;

  @override
  void initState() {
    // TODO: implement initState

    notificationProvider = NotificationProvider();
    notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    notificationProvider.init(context: context);

    //Get Notification
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationProvider.getNotification(context: context);
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.mainBlack100,
        backgroundColor: AppColors.mainWhiteBg,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.mainWhiteBg,
          child: Column(
            children: [
              // Notification Header
              Padding(
                padding: EdgeInsets.only(left: sizes!.widthRatio * 16),
                child: RichText(
                  // textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Notifications',
                    style: TextStyle(
                      fontFamily: Assets.basement,
                      fontSize: sizes!.fontRatio * 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.greyScale1000,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            ' (${notificationProvider.getMyNotificationResponse.data?.myNotifications?.length ?? 0})',
                        style: TextStyle(
                          fontFamily: Assets.basement,
                          fontSize: sizes!.fontRatio * 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyScale1000,
                        ),
                      ),
                    ],
                  ),
                ).getAlign(),
              ),
              CommonPadding.sizeBoxWithHeight(height: 14),

              // Notification Container
              notificationProvider.isNotifyLoading == 2
                  ? notificationProvider.getMyNotificationResponse.data!
                          .myNotifications!.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: notificationProvider
                                    .getMyNotificationResponse
                                    .data!
                                    .myNotifications
                                    ?.length ??
                                1,
                            itemBuilder: (context, index) {
                              // Data
                              var data = notificationProvider
                                  .getMyNotificationResponse
                                  .data!
                                  .myNotifications![index];

                              //Title
                              var title = data.title.toString();
                              var message = data.message.toString();
                              var createdAt = data.createdAt.toString();
                              var parse = DateTime.parse(createdAt);

                              // Notification Container
                              return notificationContainer(
                                title: title,
                                message: message,
                                createdAt: parse,
                                index: index,
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Center(
                            child: GetGenericText(
                              text: "No Notifications!",
                              fontFamily: Assets.aileron,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainWhite,
                              lines: 2,
                            ),
                          ),
                        )
                  : notificationProvider.isNotifyLoading == 1
                      ? Center(
                          child: GetGenericText(
                            text: notificationProvider.errorResponse.message ??
                                "",
                            fontFamily: Assets.aileron,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainBlack100,
                            lines: 2,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  // Notification Container
  Widget notificationContainer({
    required String title,
    required String message,
    required DateTime createdAt,
    required int index,
  }) =>
      Container(
        // height: sizes!.heightRatio * 92,
        width: sizes!.width,
        decoration: BoxDecoration(
          color: index == 0 ? AppColors.pastelsGreyColor : null,
          border: index != 0
              ? const Border(
                  top: BorderSide(
                    color: AppColors.mainGray5Divider,
                  ),
                )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizes!.widthRatio * 16,
            vertical: sizes!.heightRatio * 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/png/android12logo.png'),
              ),
              CommonPadding.sizeBoxWithWidth(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetGenericText(
                    text: message,
                    fontFamily: Assets.aileron,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBlack100,
                    lines: 5,
                  ),
                  GetGenericText(
                    text: "".getTimeAgoString(timeNow: createdAt),
                    //DateTime.now()
                    fontFamily: Assets.aileron,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.pastelsGreySevenColor,
                    lines: 1,
                  ),
                ],
              ),
              const Spacer(),
              index == 0
                  ? const GetGenericText(
                      text: "‼",
                      fontFamily: Assets.aileron,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                      lines: 1,
                    )
                  : Container(),
            ],
          ),
        ),
      );
}
