import 'package:planify/screens/get_started_screens/get_started_screen.dart';

/// App Routes
class AppRoutes {
  static const String getStartedScreen = '/';

  // static const String loginScreen = '/';

  static final routes = {
    getStartedScreen: (context) => const GetStartedScreen(),
    // loginScreen: (context) => const LoginScreen(),
  };
}
