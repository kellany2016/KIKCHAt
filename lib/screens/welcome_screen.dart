import 'package:flutter/material.dart';
import 'package:kik_chat/constants.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    '++KIK',
                    style: TextStyle(
                        fontFamily: 'LuckiestGuy',
                        fontSize: 75,
                        color: KmyColors[2]),
                  ),
                  Text(
                    'Chat with same friends',
                    style: TextStyle(fontSize: 20, color: KmyColors[0]),
                  ),
                ],
              ),
            ),

//            SizedBox(
//              height: 60,
//            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 60),
              color: KmyColors[0],
              elevation: 5.0,
              child: Text(
                'Get started',
                style: TextStyle(color: KmyColors[5]),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Made with love in Egypt',
              style: TextStyle(color: KmyColors[1]),
            ),
          ],
        ),
      ),
    );
  }
}
