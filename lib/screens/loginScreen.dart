import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kik_chat/auth.dart';
import 'package:kik_chat/screens/friendsList.dart';
import 'package:kik_chat/screens/Photographia.dart';

class LoginScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback signedIn;

  LoginScreen({this.auth, this.signedIn});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum FormType { signIn, signUp }

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  FormType _formType = FormType.signIn;
  final _formKey = GlobalKey<FormState>();

  // Photographia _photographia;

  bool validation() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }

  void validateAndSubmit() async {
    if (validation()) {
      try {
        if (_formType == FormType.signIn) {
          var user =
              await widget.auth.signInWithEmailAndPassword(email, password);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FriendsList()));
        } else {
          var user =
              await widget.auth.createUserWithEmailAndPassword(email, password);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FriendsList()));
        }
        widget.signedIn();
      } catch (e) {
        print(e);
      }
    }
  }

  void moveToSignup() {
    _formKey.currentState.reset();
    setState(() {
      // to reload the ui..
      _formType = FormType.signUp;
    });
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      // to reload the ui..
      _formType = FormType.signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: emailAndPasswordField() + logInAndRegister(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> emailAndPasswordField() {
    if (_formType == FormType.signIn) {
      return [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => email = value,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter a valid mail, like: jax@jungle.com',
          ),
        ),
        TextFormField(
          obscureText: true,
          onSaved: (value) => password = value,
          decoration:
              InputDecoration(labelText: 'Password', hintText: 'Password'),
        )
      ];
    } else {
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                FlatButton(
                  child: add_photo(),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Photographia())),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('add your photo'),
                ),
              ],
            ),
          ],
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (value) => email = value,
          validator: (value) =>
              value.isEmpty ? 'Email address can\`t be empty' : null,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter a valid mail, like: jax@jungle.com',
          ),
        ),
        TextFormField(
          obscureText: true,
          onSaved: (value) => password = value,
          validator: (value) =>
              value.isEmpty ? 'Password can\`t be empty' : null,
          decoration: InputDecoration(
              labelText: 'Password', hintText: 'Enter 6 chars at least'),
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
          // onSaved: (value) => email = value,
          validator: (value) =>
              value.isEmpty ? 'phone number can\`t be empty' : null,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            hintText: 'Enter your phone number',
          ),
        ),
      ];
    }
  }

  Widget add_photo() {
    bool imageStatus = Photographia().getImageUploadStatus();
    if (imageStatus == false) {
      return Image.asset(
        'assets/images/add_photo.png',
        width: 120.0,
        height: 120.0,
      );
    }
  }

  //formatted
  List<Widget> logInAndRegister() {
    String sign;
    String subText;
    if (_formType == FormType.signIn) {
      sign = 'sign in';
      subText = 'Register';
    } else {
      sign = 'sign up';
      subText = 'have account ? sign in';
    }
    return [
      RaisedButton(
        elevation: 5.0,
        child: Text(sign),
        onPressed: () => validateAndSubmit(),
      ),
      FlatButton(
        onPressed: () {
          if (_formType == FormType.signIn)
            moveToSignup();
          else
            moveToLogin();
        },
        child: Text(subText),
      )
    ];
  }
}
