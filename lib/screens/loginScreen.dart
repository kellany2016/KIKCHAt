import 'package:flutter/material.dart';
import 'package:kik_chat/auth.dart';
import 'package:kik_chat/screens/friendsList.dart';

class LoginScreen extends StatefulWidget {
  final BaseAuth auth = new Auth();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}



enum FormType {
  signIn,
  signUp
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  FormType _formType = FormType.signIn;
  final _formKey = GlobalKey<FormState>();


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
          var user =  await widget.auth.signInWithEmailAndPassword(email, password);
          print('L : {$user.uid}');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FriendsList()));
        } else {
          var user =   await widget.auth.createUserWithEmailAndPassword(email, password);
          print('R: {$user.uid}');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FriendsList()));
        }
        //  widget.signedIn();
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
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: emailAndPasswordField() + logInAndRegister(),
                )
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
          decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Password'
          ),
        )
      ];
    }
    else {
      return [
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
              labelText: 'Password',
              hintText: 'Enter 6 chars at least'
          ),
        )
      ];
    }
  }

  List<Widget> logInAndRegister() {

      if(_formType == FormType.signIn){
        return[
          RaisedButton(
            elevation: 5.0,
            child: Text('sign in'),
            onPressed: ()=> validateAndSubmit(),
          ),
          FlatButton(
            onPressed:()=> moveToSignup() ,
            child: Text('Register'),
          )
        ];
      }
      else {
          return[
            RaisedButton(
              elevation: 5.0,
              child: Text('sign up'),
              onPressed: ()=> validateAndSubmit(),
            ),
            FlatButton(
              onPressed:()=> moveToLogin() ,
              child: Text('have account ? sign in'),
            )
          ];
        }

  }

}
