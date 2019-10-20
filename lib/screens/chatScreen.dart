import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kik_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String msgSent = 'Hello Cutie! ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chatting(),
      backgroundColor: KmyColors[5],
    );
  }

  Chatting() => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Bubble(msgSent),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: KmyColors[1],
                          width: 2.5,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      //TODO N controller is better here
                      setState(() {
                        msgSent = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    //TODO N send msg
                  },
                  color: KmyColors[0],
                ),
              ],
            ),
          ],
        ),
      );

  Bubble(String msg) {
    return Container(
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(msg),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(20, 40)),
        color: KmyColors[4],
      ),
    );
  }
}
