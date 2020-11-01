import 'package:flutter/material.dart';

import 'package:help_buddy/constants.dart';
import 'package:help_buddy/size_config.dart';


class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key, this.text, this.image,
  }) : super(key: key);
  final String text,image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "Help Buddy",
          // style: TextStyle(
          //   fontSize: getProportionateScreenWidth(36),
          //   color: Color(0xff0c2551),
          //   fontWeight: FontWeight.bold,
          // ),
          style: TextStyle(
            fontFamily: 'Cardo',
            fontSize: getProportionateScreenWidth(36),
            color: Color(0xff0C2551),
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 20,),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontSize: 15.5,
            fontWeight: FontWeight.bold,
            color: Color(0xff8f9db5),
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
