import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kik_chat/auth.dart';
import 'package:kik_chat/constants.dart';
import 'package:kik_chat/screens/Photographia.dart';
import 'package:kik_chat/screens/friendsList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//done
//TODO add user`s data to fire base and create a class to get a list of users
//TODO so the user can search to find friends in friends List class..
//un done
//TODO 1- prevent the user to go back from friends widget to sign up .. if the user
//TODO pressed back , make him go to the home page of android (menu)
//TODO 2- handle password confirmation
//TODO 3- add user image to the form..
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
  String email, password,confirmPassword,username,phone;
  FormType _formType = FormType.signIn;
  final _formKey = GlobalKey<FormState>();
  final _fireStore = Firestore.instance;

  //DB functions..
  uploadToDB() {
      _fireStore.collection('user').add({
        'username': username,
        'phone': phone,
        'image location': ImageGetter.imageStorageLocation
      });
  }

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
              await Auth().signInWithEmailAndPassword(email, password);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FriendsList()));
        } else {
              await Auth().createUserWithEmailAndPassword(email, password);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FriendsList()));
          uploadToDB();
        }
        widget.signedIn();
      } catch (e){
        print(e);
      }
    }
  }

  void moveToSignUp() {
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
  Widget build(BuildContext context){
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
        CustomTextField(
          onSaved: (value) => email = value,
          labelText: 'Email Address',
          hintText: 'username or email',
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
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
        IconButton(
          color: KmyColors[3],
          icon: (ImageGetter.getImageStatus() == ImageStatus.notAdded)?Icon(Icons.account_circle,)
              :Image.file(
            ImageGetter.getImage(),
            height: 200.0,
            width: 200.0,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Photographia()));
          },
        ),

        CustomTextField(
          onSaved: (value) => username = value,
          labelText: 'User Name',
          hintText: 'Must be unique',
        ),
        CustomTextField(
          onSaved: (value) => email = value,
          labelText: 'Email Address',
          hintText: 'Email',
        ),
        CustomTextField(
          onSaved: (value) => password = value,
          hintText: 'Password',
          labelText: 'Password',
          obscure: true,
        ),
        CustomTextField(
          onSaved: (value) {
            confirmPassword = value;
            },
          hintText: 'Password',
          labelText: 'Confirm Password',
          obscure: true,
        ),

        CustomTextField(
          onSaved:(value)=> phone = value ,
          keyboardType: TextInputType.phone,
          labelText: 'Phone Number',
          hintText: 'Enter your phone number',
        ),
      ],
    );
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
          onPressed: () {
            validateAndSubmit();
            },
        ),
        FlatButton(
          color: KmyColors[5],
          onPressed: () {
            if (_formType == FormType.signIn)
              moveToSignUp();
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
class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscure;
  final TextInputType keyboardType;
  final Function onSaved;

  CustomTextField({
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
