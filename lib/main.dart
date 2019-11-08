import 'package:flutter/material.dart';
import 'package:kik_chat/constants.dart';
import 'package:kik_chat/screens/root_page.dart';
import 'package:kik_chat/screens/welcome_screen.dart';

import 'auth.dart';
import 'screens/chatScreen.dart';
import 'screens/friendsList.dart';
import 'screens/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: KmyColors[0],
        accentColor: KmyColors[3],
        buttonColor: KmyColors[2],
        backgroundColor: KmyColors[5],
      ),
      darkTheme: ThemeData.dark(),
      title: 'KIK',
      initialRoute: '/chat',
      routes: {
        '/': (context) => Welcome(),
        '//': (context) => RootPage(auth: new Auth()),
        '/login': (context) => LoginScreen(),
        '/friends': (context) => FriendsList(),
        '/chat': (context) => ChatScreen(),
        //TODO use named routes in the rest of files..
      },
    );
  }
}
