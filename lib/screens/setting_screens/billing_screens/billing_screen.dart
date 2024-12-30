// Created by Tayyab Mughal on 02/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/project_widgets/get_generic_text_widget.dart';
import 'package:planify/screens/setting_screens/billing_screens/billing_provider.dart';
import 'package:provider/provider.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  late BillingProvider billingProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    billingProvider = BillingProvider();
    billingProvider = Provider.of<BillingProvider>(context, listen: false);
    billingProvider.init(context: context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      billingProvider.getUserSubscriptions();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<BillingProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainWhiteBg,
        elevation: 0,
        foregroundColor: AppColors.mainBlack100,
      ),
      body: Container(
        color: AppColors.mainWhiteBg,
        child: SafeArea(
          child: Column(
            children: [
              const GetGenericText(
                text: "Billing Details",
                fontFamily: Assets.basement,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.mainBlack100,
                lines: 1,
              ).getAlign(),
              CommonPadding.sizeBoxWithHeight(height: 18),

              // Billing Detail
              billingProvider.isBillingLoaded == 2
                  ? billingProvider.getMySubscriptionResponse.data!.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: billingProvider
                                .getMySubscriptionResponse.data!.length,
                            itemBuilder: (context, index) {
                              // Data
                              var data = billingProvider
                                  .getMySubscriptionResponse.data![index];
                              var price = data.subscriptionPlan!.vendorProductId
                                  .toString();
                              var purchaseDate = data.purchasedAt.toString();

                              // Container
                              return _billingDetails(
                                price: price,
                                purchaseDate: purchaseDate,
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: GetGenericText(
                            text: "Sorry! There is no subscription available",
                            fontFamily: Assets.basement,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 2,
                            textAlign: TextAlign.center,
                          ),
                        )
                  : billingProvider.isBillingLoaded == 1
                      ? Center(
                          child: GetGenericText(
                            text: billingProvider.errorResponse.message
                                .toString(),
                            fontFamily: Assets.basement,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mainBlack100,
                            lines: 2,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  // Billing Details
  Widget _billingDetails({
    required String price,
    required String purchaseDate,
  }) {
    var type = "Trips";
    var newPrice = "0000";
    if (price == "in_app_planify_8999_1y") {
      newPrice = "8.99";
      type = "Unlimited Trips";
    } else if (price == "in_app_planify_3999_1f") {
      newPrice == "3.99";
      type = "5 Trips";
    } else {
      newPrice == "1.99";
      type = "1 Trips";
    }
    var parse = DateTime.parse(purchaseDate);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: sizes!.heightRatio * 6,
      ),
      child: Container(
        height: sizes!.heightRatio * 110,
        width: sizes!.widthRatio * 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.billingColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizes!.widthRatio * 20,
            vertical: sizes!.heightRatio * 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const GetGenericText(
                    text: "Bought Package:",
                    fontFamily: Assets.aileron,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBlack100,
                    lines: 1,
                  ),
                  GetGenericText(
                    text: type,
                    fontFamily: Assets.aileron,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBlack100,
                    lines: 1,
                  ),
                ],
              ),
              CommonPadding.sizeBoxWithHeight(height: 12),
              GetGenericText(
                text: "Price: \$$newPrice",
                fontFamily: Assets.aileron,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.mainBlack100,
                lines: 1,
              ),
              CommonPadding.sizeBoxWithHeight(height: 4),
              GetGenericText(
                text:
                    "Purchase Date: ${parse.day}/${parse.month}/${parse.year}",
                fontFamily: Assets.aileron,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.pastelsGreyEightColor,
                lines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
