import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help_buddy/secondScreen/SecondScreen.dart';
import 'package:help_buddy/welcomeScreen/components/default_button.dart';
import 'package:help_buddy/constants.dart';
import 'package:help_buddy/size_config.dart';
import 'splash_content.dart';
import '../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "You Buddy is here to help you ....\n Get all your resources here ..",
      "image": "assets/images/splash_3.png"
    },
    {
      "text": "Never miss a deadline or Class ",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "Revisit your recorded lectures whenever you want ",
      "image": "assets/images/splash_2.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: DefaultButton(
                        text: "Let's Go",
                        press: () {
                         // Navigator.pushNamed(context, '/second');
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => SecondScreen(
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 80.0,),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

