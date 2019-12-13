import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kik_chat/auth.dart';
import 'package:kik_chat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'Photographia.dart';

class LoginScreen extends StatefulWidget {
  final Auth auth;
  final VoidCallback signedIn;

  LoginScreen({this.auth, this.signedIn});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

//enums for form type and image save status..
enum FormType { signIn, signUp }
enum ImageStatus { added, notAdded }

class _LoginScreenState extends State<LoginScreen> {
  bool spin = false;
  static Icon defaultIcon = Icon(
    Icons.add_a_photo,
    color: KmyColors[3],
    size: 100,
  );
  Icon pfpIcon = defaultIcon;
  File imageFile;
  String email, password;
  FormType _formType = FormType.signIn;
  final _formKey = GlobalKey<FormState>();

  //what is this ???ظظظ
  bool validation() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }

  void validateAndSubmit() async {
    setState(() {
      spin = true;
    });
    if (validation()) {
      try {
        bool result;
        if (_formType == FormType.signIn) {
          result = await Auth.signMeIn(email, password);
          if (result != null) {
            Navigator.pushNamed(context, '/friends');
          } else
            print('Can\'t log In');
        } else {
          result = await Auth.signMeUp(
            email: email,
            password: password,
          );
          if (result) {
            Navigator.pushNamed(context, '/friends');
          } else
            print('Can\'t log In');
        }
        setState(() {
          spin = false;
        });

        widget.signedIn();
      } catch (e) {
        print('logins says : $e');
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
      home: ModalProgressHUD(
        inAsyncCall: spin,
        child: Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  updatePFP() {
    if (imageFile == null) {
      pfpIcon = defaultIcon;
      return null;
    } else {
      pfpIcon = null;
      return FileImage(imageFile);
    }
  }

  Widget signUpFields() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: dialogeTrigger,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: updatePFP(),
              backgroundColor: Colors.white,
              radius: 50,
              child: pfpIcon,
            ),
          ),
        ),
        CustomeTextField(
          labelText: 'User Name',
          hintText: 'Must be unique',
          keyboardType: TextInputType.text,
        ),
        CustomeTextField(
          onSaved: (value) {
            email = value;
            print('emails is $email');
          },
          labelText: 'Email Address',
          hintText: 'Email',
        ),
        CustomeTextField(
          onSaved: (value) {
            password = value;
            print('passwords is $password');
          },
          hintText: 'Password',
          labelText: 'Password',
          obscure: true,
        ),
        CustomeTextField(
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

  dialogeTrigger() {
    var myDialog = SimpleDialog(
      title: Text(
        'Profile Picture',
        style: TextStyle(color: KmyColors[0]),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.camera,
                color: KmyColors[2],
              ),
              iconSize: 35,
              onPressed: () async {
                deactivate();
                File whatweget = await Photographia().getImageFromCam();
                setState(() {
                  imageFile = whatweget;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.photo_library,
                color: KmyColors[2],
              ),
              iconSize: 35,
              onPressed: () async {
                File myimageFile = await Photographia().getImageFromGallery();
                setState(() {
                  imageFile = myimageFile;
                });
              },
            ),
          ],
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return myDialog;
        });
  }
}
