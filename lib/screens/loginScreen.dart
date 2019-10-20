import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kik_chat/NoSql_Data/my_user data.dart';
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

//enums for form type and image save status..
enum FormType { signIn, signUp }
enum ImageStatus { added, notAdded }

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  FormType _formType = FormType.signIn;
  final _formKey = GlobalKey<FormState>();
  FriendInfo _friendInfo;

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
              children: <Widget>[
                _formType == FormType.signIn
                    ? loginFields()
                    : Expanded(
                        child: ListView(
                          children: <Widget>[
                            signUpFields(),
                            formButtons(),
                          ],
                        ),
                      ),
                // loginFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginFields() {
    return Column(
      children: <Widget>[
        CustomeTextField(
          onSaved: (value) => email = value,
          labelText: 'Email Address',
          hintText: 'username or email',
        ),
        SizedBox(
          height: 10,
        ),
        CustomeTextField(
          onSaved: (value) => password = value,
          hintText: 'Password',
          labelText: 'Password',
          obscure: true,
        ),
        SizedBox(
          height: 10,
        ),
        formButtons(),
      ],
    );
  }

  Widget signUpFields() {
    return Column(
      children: <Widget>[
        Icon(
          Icons.account_circle,
          size: 100,
          color: KmyColors[3],
        ),
//        Column(
//          children: <Widget>[
//            FlatButton(
//              child: add_photo(),
//              onPressed: () => Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => Photographia())),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text('add your photo'),
//            ),
//          ],
//        ),
        CustomeTextField(
          labelText: 'User Name',
          hintText: 'Must be unique',
        ),
        CustomeTextField(
          onSaved: (value) {
            email = value;
          },
          labelText: 'Email Address',
          hintText: 'Email',
        ),
        CustomeTextField(
          onSaved: (value) => password = value,
          hintText: 'Password',
          labelText: 'Password',
          obscure: true,
        ),
        CustomeTextField(
          onSaved: (value) => password = value,
          hintText: 'Password',
          labelText: 'Confirm Password',
          obscure: true,
        ),

        CustomeTextField(
          keyboardType: TextInputType.phone,
          labelText: 'Phone Number',
          hintText: 'Enter your phone number',
        ),
      ],
    );
  }

  Widget add_photo() {
    if (ImageGetter.getImageStatus() == ImageStatus.notAdded) {
      return Image.asset(
        'assets/images/add_photo.png',
        height: 50.0,
        width: 50.0,
      );
    } else if (ImageGetter.getImageStatus() == ImageStatus.added) {
      return Image.file(
        ImageGetter.getImage(),
        height: 200.0,
        width: 200.0,
      );
    }
  }

  formButtons() {
    String sign;
    String subText;
    if (_formType == FormType.signIn) {
      sign = 'sign in';
      subText = 'Create an account';
    } else {
      sign = 'sign up';
      subText = 'have account ? sign in';
    }
    return Column(
      children: <Widget>[
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
      ],
    );
  }
}

//Todo needs a controller
class CustomeTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscure;
  final TextInputType keyboardType;
  final Function onSaved;

  CustomeTextField({
    this.onSaved,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 5, right: 3),
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        //style: TextStyle(fontSize: 18),
        obscureText: obscure ?? false,
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: KmyColors[3], width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: KmyColors[3], width: 1),
          ),
        ),
      ),
    );
  }
}
