import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'friendsList.dart';
import 'package:kik_chat/auth.dart';
class RootPage extends StatefulWidget {
  final BaseAuth auth;
  RootPage({this.auth});
  @override
  State<StatefulWidget> createState() => new RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;
  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus =
        userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedout() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
       return LoginScreen(auth: widget.auth, signedIn: signedIn);
      case AuthStatus.signedIn:
        return FriendsList(
          auth: widget.auth,
          signedOut: _signedout,
        );
    }
  }
}
