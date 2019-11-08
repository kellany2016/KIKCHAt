import 'package:flutter/material.dart';
import 'package:kik_chat/constants.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

enum WelcomeStatus { welcomed, notWelcomed }

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  //TODO handle to go to the rootPage if the user already used the app..
  WelcomeStatus welcomeStatus = WelcomeStatus.notWelcomed;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      upperBound: 75,
      lowerBound: 15,
      duration: Duration(seconds: 1),
      vsync: this,
    );
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '++',
                        style: TextStyle(
                            fontFamily: 'LuckiestGuy',
                            fontSize: controller.value,
                            color: KmyColors[2]),
                      ),
                      Text(
                        'KIK',
                        style: TextStyle(
                            fontFamily: 'LuckiestGuy',
                            fontSize: 75,
                            color: KmyColors[2]),
                      ),
                    ],
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
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
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
              'Made with love in Alexandria',
              style: TextStyle(color: KmyColors[1]),
            ),
          ],
        ),
      ),
    );
  }
}
