import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:help_buddy/constants.dart';
import 'package:help_buddy/welcomeScreen/screens/splash_screen.dart';
import 'secondScreen/SecondScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Help Buddy',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Muli",
        textTheme: TextTheme(
          bodyText1: TextStyle(color: kTextColor),
          bodyText2: TextStyle(color: kTextColor),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: SplashScreen(),
      //we use routeName so that we dont need to remember the name
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => SplashScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
        // '/third': (context) => ThirdScreen(),
      },
    );
  }
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var email = prefs.getString('email');
//   runApp(MaterialApp(home: email == true ? SecondScreen() : ResourceScreen()));
// }
//import 'routs.dart';
// initialRoute: SplashScreen.routeName,
// routes: routes,