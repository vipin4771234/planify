import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';
import 'app_languages/language_constants.dart';
import 'app_routes/routes.dart';
import 'firebase_options.dart';
import 'providers/multi_providers.dart';
import 'package:uni_links/uni_links.dart';
import 'package:logger/logger.dart';
import 'package:device_calendar/device_calendar.dart';
//*
// [Flutter] Version: 3.10.+
// [Developer]: Tayyab Mughal [Full-Stack Mobile Application Engineer]
// [Github]: https://www.github.com/tayyabmughal676
// [Upwork]: https://www.upwork.com/freelancers/~01d478bbabdfa2e861
// [Email]: mailto:tayyabmughal676@gmail.com
// *//

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Main.dart-> Handling a background message ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();
  //Initializing the firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Tiktok sdk initialise
  // TikTokSDK.instance.setup(clientKey: 'aw80fa1woog09gzc');
  // var permissionsGranted = await deviceCalendarPlugin.hasPermissions();
  var permissionsGranted = await deviceCalendarPlugin.requestPermissions();
  print("permissionG ${permissionsGranted.data}");
  // if (permissionsGranted.isSuccess &&
  //     (permissionsGranted.data == null || permissionsGranted.data == false)) {
  //   permissionsGranted = await deviceCalendarPlugin.requestPermissions();
  //   if (!permissionsGranted.isSuccess ||
  //       permissionsGranted.data == null ||
  //       permissionsGranted.data == false) {
  //     return;
  //   }
  // }
  var format = NumberFormat.simpleCurrency(locale: Platform.localeName);
  print(
      '${format.currencySymbol} ${format.currencyName} currencySymboldfjlksfjlsdjfd');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('currencyName',
      format.currencyName != null ? format.currencyName! : 'EURO');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  // Foreground Notification While the app running state
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Main.dart -> Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      debugPrint(
          'Main.dart -> Message also contained a notification: ${message.notification!.title}');
      if (message.data['type'] == 'chat') {
        debugPrint("Type is Chat Opened");
      }
    }
  });

  // When User click the notification and the app will response
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    debugPrint("onMessageOpenedApp: ${event.data}");
    if (event.data['type'] == 'chat') {
      debugPrint("Type is Chat Opened");
    }
  });

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent // optional
        ),
  );

  ///Adapty IO
  try {
    Adapty().activate();
    await Adapty().setLogLevel(AdaptyLogLevel.info);
  } on AdaptyError catch (adaptyError) {
    debugPrint("onAdaptyError: $adaptyError");
  } catch (e) {
    debugPrint("onAdaptyError: $e");
  }

  ///RevenueCat In-App Purchase + Subscription
  // await Purchases.setDebugLogsEnabled(true);
  // if (Platform.isIOS) {
  //   debugPrint("RevenueCat-iOS");
  //   PurchasesConfiguration configuration = PurchasesConfiguration(appleApiKey);
  //   await Purchases.configure(configuration);
  // } else {
  //   debugPrint("RevenueCat-Android");
  // }

  // Get the initial locale values
  final String defaultSystemLocale = Platform.localeName;
  debugPrint("defaultSystemLocale: $defaultSystemLocale");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();

  //ADD THIS FUNCTION TO HANDLE DEEP LINKS
//    Future<Null> initUniLinks()async{
//      try{
//         Uri initialLink = await getInitialUri();
//         print(initialLink);
//      } on PlatformException {
//        print('platfrom exception unilink');
//      }
//    }
// //CALL THE FUNCTION
//    initUniLinks();

  /// Universal setLocale Function
  static void setLocale(BuildContext context, Locale newLocale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }
}

class MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  /// set Locale
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then(
      (locale) => {
        setLocale(locale),
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiProviders,
      child: MaterialApp(
        title: "Planify",
        key: key,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Basement"),
        initialRoute: AppRoutes.getStartedScreen,
        routes: AppRoutes.routes,

        /// These Lines for Localization
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
      ),
    );
  }
}
