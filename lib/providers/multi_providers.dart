// Created by Tayyab Mughal on 09/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:planify/screens/auth_screens/forgot_password_screens/forgot_password_provider.dart';
import 'package:planify/screens/auth_screens/login_screens/login_provider.dart';
import 'package:planify/screens/auth_screens/register_screens/auth_provider.dart';
import 'package:planify/screens/get_started_screens/get_started_provider.dart';
import 'package:planify/screens/main_home_screens/explore_screens/explore_provider.dart';
import 'package:planify/screens/main_home_screens/main_home_provider.dart';
import 'package:planify/screens/main_home_screens/my_trip_screens/my_trip_provider.dart';
import 'package:planify/screens/main_home_screens/my_trip_screens/trip_generated_screens/my_trip_generated_provider.dart';
import 'package:planify/screens/notification_screens/notification_provider.dart';
import 'package:planify/screens/setting_screens/about_screens/about_provider.dart';
import 'package:planify/screens/setting_screens/billing_screens/billing_provider.dart';
import 'package:planify/screens/setting_screens/currency_setting_screens/currency_provider.dart';
import 'package:planify/screens/setting_screens/faq_screens/faq_provider.dart';
import 'package:planify/screens/setting_screens/setting_provider.dart';
import 'package:planify/screens/setting_screens/support_screens/support_provider.dart';
import 'package:planify/screens/subscription_screens/subscription_provider.dart';
import 'package:planify/screens/trip_creation_screens/customize_trip_provider.dart';
import 'package:planify/screens/trip_itinerary_detail_screens/trip_itinerary_detail_provider.dart';
import 'package:provider/provider.dart';

final multiProviders = [
  ChangeNotifierProvider<MyTripGeneratedProvider>(
    create: (_) => MyTripGeneratedProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<MainHomeProvider>(
    create: (_) => MainHomeProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<CurrencyProvider>(
    create: (_) => CurrencyProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<BillingProvider>(
    create: (_) => BillingProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<GetStartedProvider>(
    create: (_) => GetStartedProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SettingProvider>(
    create: (_) => SettingProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ForgotPasswordProvider>(
    create: (_) => ForgotPasswordProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<ExploreProvider>(
    create: (_) => ExploreProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<TripDetailProvider>(
    create: (_) => TripDetailProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<FaqProvider>(
    create: (_) => FaqProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<AboutUsProvider>(
    create: (_) => AboutUsProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SupportProvider>(
    create: (_) => SupportProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<CustomizeTripProvider>(
    create: (_) => CustomizeTripProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<SubscriptionProvider>(
    create: (_) => SubscriptionProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<LoginProvider>(
    create: (_) => LoginProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<NotificationProvider>(
    create: (_) => NotificationProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<MyTripProvider>(
    create: (_) => MyTripProvider(),
    lazy: true,
  ),
  ChangeNotifierProvider<CustomizeTripProvider>(
    create: (_) => CustomizeTripProvider(),
    lazy: true,
  ),
];
