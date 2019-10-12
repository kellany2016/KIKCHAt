import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            Bubble(msgSent),
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

  Bubble(String msg) {
    return Container(
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(msg),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.elliptical(20, 40)),
        color: myColors[4],
      ),
    );
  }
}
