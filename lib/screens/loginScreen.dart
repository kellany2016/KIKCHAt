import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kik_chat/auth.dart';
import 'package:kik_chat/constants.dart';
import 'package:kik_chat/screens/Photographia.dart';
import 'package:kik_chat/screens/friendsList.dart';

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: emailAndPasswordField() + logInAndRegister(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> emailAndPasswordField() {
    if (_formType == FormType.signIn) {
      return [
        Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                alignment: Alignment.center,
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/wave.jpg',
                ),
              )),
        ),
        Text(
          'A7la Chat',
          style: TextStyle(fontSize: 50, color: KmyColors[1]),
        ),
        SizedBox(
          height: 40,
        ),
        CustomTextField((value) => email = value, 'Email Address',
            'Enter a valid mail, like: jax@jungle.com'),
        SizedBox(
          height: 10,
        ),
        CustomTextField((value) => password = value, 'Password', 'Password'),
        SizedBox(
          height: 10,
        ),
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
      subText = 'Create an account';
    } else {
      sign = 'sign up';
      subText = 'have account ? sign in';
    }
    return [
      RaisedButton(
        color: KmyColors[0],
        elevation: 5.0,
        child: Text(
          sign,
          style: TextStyle(color: KmyColors[5]),
        ),
        onPressed: () => validateAndSubmit(),
      ),
      FlatButton(
        color: KmyColors[5],
        onPressed: () {
          if (_formType == FormType.signIn)
            moveToSignup();
          else
            moveToLogin();
        },
        child: Text(
          subText,
          style: TextStyle(color: KmyColors[1]),
        ),
      )
    ];
  }
}

CustomTextField(Function onSave, String labelText, String hintText) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    padding: EdgeInsets.only(bottom: 12, left: 5, right: 3),
    decoration: BoxDecoration(
      border: Border.all(
        width: 3,
        color: KmyColors[3],
      ),
      borderRadius: BorderRadius.all(Radius.elliptical(20, 40)),
    ),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 5, right: 3),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: onSave,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    ),
  );
}
