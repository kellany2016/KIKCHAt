import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;
final _firestore = Firestore.instance;
var id_counter = 0;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

List<Color> myColors = [
  Color(0xFF012d4a),
  Color(0xFF014753),
  Color(0xFF016392),
  Color(0xFF01839d),
  Color(0xFFaacfe2),
  Color(0xFFd7dcde),
];

class _ChatScreenState extends State<ChatScreen> {
  String msgSent = 'Hello Cutie! ';

  String textFieldValue;
  TextEditingController controlText = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chatting(),
      backgroundColor: myColors[5],
    );
  }

  Chatting() => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MessageBubble(),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: myColors[1],
                          width: 2.5,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      //TODO controller is better here
                      setState(() {
                        msgSent = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    //TODO send msg
                  },
                  color: myColors[0],
                ),
              ],
            ),
          ],
        ),
      );
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isCurrentUser, this.id});

  final id;
  final String text, sender;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(text),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(20, 40)),
        color: myColors[4],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('rasael')
            .orderBy('id', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('nothing to show...'),
            );
          }
          var messages = snapshot.data.documents.reversed;

          List<MessageBubble> messagesWidget = [];
          for (var message in messages) {
            print("hi ${message.data['text']}");
            final messageText = message.data['text'];
            final messageSender = message.data['sender'];
            var messageId = message.data['id'];
            final currentUser = loggedInUser.email;
            final bool ismCurrentUser = currentUser == messageSender;
            final messageWidget = MessageBubble(
              text: messageText,
              sender: messageSender,
              isCurrentUser: ismCurrentUser,
              id: messageId,
            );
            if (id_counter < messageId) id_counter = messageId;
            messagesWidget.add(messageWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messagesWidget,
            ),
          );
        });
  }
}
