import 'welcomeScreen/screens/splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:help_buddy/welcomeScreen/screens/splash_screen.dart';

//we use name route
//All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
};