import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help_buddy/thirdScreen/AssignmentsDate.dart';
import 'package:help_buddy/thirdScreen/ClassesLectures.dart';
import 'package:help_buddy/thirdScreen/ResoourcesAndMaterial.dart';
import 'package:help_buddy/thirdScreen/TomorrowSchedule.dart';

class ResourceScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyResourcePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyResourcePage extends StatefulWidget {


  @override
  _MyResourcePageState createState() => _MyResourcePageState();
}

class _MyResourcePageState extends State<MyResourcePage> {

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c2551),//0xFF21BFBD
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.info_outline),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.exit_to_app),
                          color: Colors.white,
                          onPressed: () async {
                              await _auth.signOut();
                              Navigator.pop(context);
                              Navigator.pop(context);

                          },
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Help',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text('Buddy',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        child: ListView(children: [
                          _buildFoodItem1('assets/tomorrowSchedule.png',
                              'Tomorrow Schedule', ''),
                          _buildFoodItem2('assets/assignments.png',
                              'Assignments Due Dates', ''),
                          _buildFoodItem3('assets/resources.png',
                              'Resources and Material', ''),
                          _buildFoodItem4(
                              'assets/lecture.png', 'Classes Lectures', '')
                        ]))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Container(
                    //   height: 55.0,
                    //   width: 50.0,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //         color: Colors.grey,
                    //         style: BorderStyle.solid,
                    //         width: 1.0),
                    //     borderRadius: BorderRadius.circular(10.0),
                    //   ),
                    //   child: Center(
                    //     child: Icon(Icons.search, color: Colors.black),
                    //   ),
                    // ),
                    // Container(
                    //   height: 55.0,
                    //   width: 50.0,
                    //   decoration: BoxDecoration(
                    //     border: Border.all(
                    //         color: Colors.grey,
                    //         style: BorderStyle.solid,
                    //         width: 1.0),
                    //     borderRadius: BorderRadius.circular(10.0),
                    //   ),
                    //   child: Center(
                    //     child: Icon(Icons.account_circle, color: Colors.black),
                    //   ),
                    // ),
                    SizedBox(width: 200,),
                    Container(
                      height: 55.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFF1C1428)),
                      child: Center(
                          child: Text('Contact Us',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 15.0))),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFoodItem1(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 35.0),
        child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
              // ));
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (context) => TomorrowSchedule(
              //               heroTag: imgPath,
              //             )));
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => TomorrowSchedule(
                    heroTag: imgPath,
                  ),
                ),
              );
            },
            // FinalScreen(heroTag: imgPath,foodName: foodName,foodPrice: price,)
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: imgPath,
                      child: Image(
                          image: AssetImage(imgPath),
                          fit: BoxFit.cover,
                          height: 65.0,
                          width: 65.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foodName,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        Text(price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                                color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.black,
                    onPressed: () {})
              ],
            )));
  }

  Widget _buildFoodItem2(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 35.0),
        child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
              // ));
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (context) => AssignmentsDate(
              //               heroTag: imgPath,
              //             )));
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => AssignmentsDate(
                    heroTag: imgPath,
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: imgPath,
                      child: Image(
                          image: AssetImage(imgPath),
                          fit: BoxFit.cover,
                          height: 65.0,
                          width: 65.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foodName,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        Text(price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                                color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.black,
                    onPressed: () {})
              ],
            )));
  }

  Widget _buildFoodItem3(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 35.0),
        child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
              // ));
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (context) => ResourcesAndMaterial(
              //               heroTag: imgPath,
              //             )));
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => ResourcesAndMaterial(
                    heroTag: imgPath,
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: imgPath,
                      child: Image(
                          image: AssetImage(imgPath),
                          fit: BoxFit.cover,
                          height: 65.0,
                          width: 65.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foodName,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        Text(price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                                color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.black,
                    onPressed: () {})
              ],
            )));
  }

  Widget _buildFoodItem4(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 35.0),
        child: InkWell(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
              // ));
              // Navigator.push(
              //   context,
              //   new MaterialPageRoute(
              //     builder: (context) => ClassesLectures(
              //       heroTag: imgPath,
              //     ),
              //   ),
              // );
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
                  pageBuilder: (_, __, ___) => ClassesLectures(
                    heroTag: imgPath,
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(children: [
                  Hero(
                      tag: imgPath,
                      child: Image(
                          image: AssetImage(imgPath),
                          fit: BoxFit.cover,
                          height: 65.0,
                          width: 65.0)),
                  SizedBox(width: 10.0),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foodName,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        Text(price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                                color: Colors.grey))
                      ])
                ])),
                IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.black,
                    onPressed: () {})
              ],
            )));
  }
}
