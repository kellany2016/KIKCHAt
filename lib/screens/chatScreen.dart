import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:kik_chat/constants.dart';

import '../auth.dart';

FirebaseUser loggedInUser;

class ChatScreen extends StatelessWidget {
  String msgSent = 'Hello Cutie! ';
  FlutterSound flutterSound = FlutterSound();
  String textFieldValue;
  TextEditingController controlText = TextEditingController();
  bool isRecording = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatting(),
      backgroundColor: KmyColors[5],
    );
  }

  chatting() {
    TextEditingController myController = TextEditingController();
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MessageStream(),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: KmyColors[0],
                        width: 2.5,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    msgSent = value;
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  FireStoring().send(msgSent);
                  myController.clear();
                },
                color: KmyColors[1],
              ),
              InkWell(
                onTap: () async {
                  if (!isRecording) {
                    isRecording = true;
                    print('is recording');
                    String path = await flutterSound.startRecorder(null);
                    print("PAths is $path");
                  } else {
                    isRecording = false;
                    String result = await flutterSound.stopRecorder();
                    print('stopped Recoding and result is $result');
                  }
                },
                child: Icon(
                  Icons.mic,
                  color: KmyColors[1],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isCurrentUser, this.id});
  final MainAxisAlignment myAlignment = MainAxisAlignment.end;
  final MainAxisAlignment hisAlignment = MainAxisAlignment.start;
  final id;
  final String text, sender;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCurrentUser ? myAlignment : hisAlignment,
      children: <Widget>[
        Container(
//          transform: Matrix4.rotationZ(isCurrentUser ? 0.1 : -0.1),
          child: Text(
            text,
            style:
                TextStyle(color: isCurrentUser ? KmyColors[0] : KmyColors[5]),
          ),
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 40)),
            color: isCurrentUser ? KmyColors[4] : KmyColors[2],
          ),
        ),
      ],
    );
  }
}

class MessageStream extends StatelessWidget {
  static int i = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FireStoring.chatRoomStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('send the first message...'),
            );
          }
          var messages = snapshot.data.documents.reversed;

          List<MessageBubble> messagesWidget = [];
          for (var message in messages) {
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];
            var messageId = message.data['number'];
            //  final currentUser = loggedInUser.email;
            //final bool ismCurrentUser = currentUser == messageSender;
            final messageWidget = MessageBubble(
              isCurrentUser: ++i % 3 == 0 ? false : true,
              text: messageText,
              sender: messageSender,
            );
            if (FireStoring.lastId < messageId) FireStoring.lastId = messageId;
            messagesWidget.add(messageWidget);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messagesWidget,
            ),
          );
        });
  }
}
