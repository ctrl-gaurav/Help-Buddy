import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;

class AssignmentsDate extends StatefulWidget {
  final heroTag;

  const AssignmentsDate({Key key, this.heroTag});
  @override
  _AssignmentsDateState createState() => _AssignmentsDateState();
}

class _AssignmentsDateState extends State<AssignmentsDate> {
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
    in _firestore.collection('AssignmentsDate').snapshots()) {
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
                  'Assignments Date',
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
              MessagesStream(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Hi there...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection("AssignmentsDate").add({
                          'NewAssignment': messageText,
                          'time': FieldValue.serverTimestamp(),
                          //'sender': "gaurav@email.com",
                        });
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
          .collection("AssignmentsDate")
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
          final messageText = message.data()['NewAssignment'];
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
