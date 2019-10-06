import 'package:flutter/material.dart';
import 'screens/loginScreen.dart';
import 'screens/chatScreen.dart';
import 'screens/friendsList.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      title: 'KIK',
      initialRoute: '/',
      routes: {
        '/': (context)=> LoginScreen(),
        '/first': (context)=> FriendsList(),
        '/second': (context)=> ChatScreen()
      },
    );
  }
}
