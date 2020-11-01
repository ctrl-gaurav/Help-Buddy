import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = Firestore.instance;

class ClassesLectures extends StatefulWidget {
  final heroTag;

  const ClassesLectures({Key key, this.heroTag});
  @override
  _ClassesLecturesState createState() => _ClassesLecturesState();
}

class _ClassesLecturesState extends State<ClassesLectures> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async{
  //   final messages = await _firestore.collection("messages").getDocuments();
  //   for(var message in messages.documents){
  //     print(message.data());
  //   }
  // }

  void messagesStreams() async {
    await for (var snapshot
        in _firestore.collection('ClassesLectures').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: null,
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.assessment),
      //       onPressed: () {
      //         messagesStreams();
      //         // _auth.signOut();
      //         // Navigator.pop(context);
      //         //Implement logout functionality
      //       },
      //     )
      //   ],
      //   title: Text('Tomorrow Schedule'),
      //   backgroundColor: Colors.orange,
      // ),

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
                height: 20.0,
              ),
              Container(
                child: Hero(
                  tag: widget.heroTag,
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(widget.heroTag),
                              fit: BoxFit.contain)),
                      height: 150.0,
                      width: 150.0),
                ),
              ),
              SizedBox(
                width: 10.0,
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                child: Text(
                  'Classes Lectures',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_forward),
                      iconSize: 30,
                      color: Colors.black,
                      onPressed: () {}),
                ],
              ),
              Center(
                child: InkWell(
                  child: Container(
                    height: 55.0,
                    width: 125.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xff0c2551)),
                    child: FlatButton(
                      onPressed: () {
                        launch(
                            'https://mujmanipal-my.sharepoint.com/:f:/g/personal/gaurav_199301159_muj_manipal_edu/Erf1SjRpqgFNvsIxwYT3hA8BRuxZt4-BFdxlW1azk2xvag?e=eUadci');
                      },
                      child: Text(
                        'Watch Here ',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  onTap: () => launch(
                      'https://mujmanipal-my.sharepoint.com/:f:/g/personal/gaurav_199301159_muj_manipal_edu/Erf1SjRpqgFNvsIxwYT3hA8BRuxZt4-BFdxlW1azk2xvag?e=eUadci'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Container(
                      child: Text(
                      'For now you can watch or download all recorded lectures from OneDrive',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              MessagesStream(),

              // Container(
              //   decoration: BoxDecoration(
              //     border: Border(
              //       top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
              //     ),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       Expanded(
              //         child: TextField(
              //           controller: messageTextController,
              //           onChanged: (value) {
              //             messageText = value;
              //           },
              //           decoration: InputDecoration(
              //             contentPadding: EdgeInsets.symmetric(
              //                 vertical: 10.0, horizontal: 20.0),
              //             hintText: 'Hi there...',
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       ),
              //       FlatButton(
              //         onPressed: () {
              //           messageTextController.clear();
              //           _firestore.collection("ClassesLectures").add({
              //             'Text': messageText,
              //             'time': FieldValue.serverTimestamp(),
              //             //'sender': "gaurav@email.com",
              //           });
              //         },
              //         child: Text(
              //           'Send',
              //           style: TextStyle(
              //             color: Colors.orangeAccent,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 18.0,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("ClassesLectures")
          .orderBy('time', descending: false)
          .snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data()['Text'];
          final messageTime = message.data()['time'] as Timestamp;
          //final messageSender = message.data()['sender'];

          final messageBubble = MessageBubble(
            //sender: messageSender,
            text: messageText,
            time: messageTime,
          );
          messageBubbles.add(messageBubble);
          //messageBubbles.sort((a, b) => b.time.compareTo(a.time));
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.time});

  final String sender;
  final String text;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text(sender,
          // style: TextStyle(
          //   fontSize: 12.0,
          //   color: Colors.black54,
          // ),
          // ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 10.0,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
