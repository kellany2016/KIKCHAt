import 'package:flutter/material.dart';
import 'package:kik_chat/screens/root_page.dart';
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
      darkTheme: ThemeData.dark(),
      title: 'KIK',
      initialRoute: '//',
      routes: {
        '//':(context) => RootPage(auth: new Auth()),
        '/': (context) => LoginScreen(),
        '/friends': (context) => FriendsList(),
        '/chat': (context) => ChatScreen()
        //TODO use named routes in the rest of files..
      },
    );
  }
}
