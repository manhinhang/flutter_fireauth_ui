import 'package:fireauth_ui/localizations.dart';
import 'package:fireauth_ui/password_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FireAuthEmailSignUpPage extends StatefulWidget {
  final String _email;

  FireAuthEmailSignUpPage(String email) : _email = email;

  @override
  State<StatefulWidget> createState() {
    return new FireAuthEmailSignUpPageState(_email);
  }
}

class FireAuthEmailSignUpPageState extends State<FireAuthEmailSignUpPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email;
  String _displayName;
  String _password;

  FireAuthEmailSignUpPageState(String email) : _email = email;

  String _validateEmail(String value) {
    if (value.isEmpty)
      return FireAuthUILocalizations.of(context).emptyEmailWarning;
    final RegExp nameExp =
        new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    if (!nameExp.hasMatch(value))
      return FireAuthUILocalizations.of(context).invalidEmailWarning;
    return null;
  }

  void _onSignUp() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((user) {
        UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _displayName;
        FirebaseAuth.instance.updateProfile(userUpdateInfo);
        int popCount = 4;
        Navigator.popUntil(context, (Route<dynamic> route) {
          popCount--;
          return popCount == 0;
        });
      }, onError: (error) {
        if (error is PlatformException) {
          PlatformException platformException = error;
          showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
                  title: new Text(FireAuthUILocalizations.of(context).error),
                ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(FireAuthUILocalizations.of(context).signIn),
      ),
      body: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
              child: new Padding(
            padding: const EdgeInsets.all(24.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new TextFormField(
                  initialValue: _email,
                  decoration: new InputDecoration(
                    hintText: FireAuthUILocalizations.of(context).emailHint,
                    labelText: FireAuthUILocalizations.of(context).email,
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String val) {
                    _email = val;
                  },
                  validator: _validateEmail,
                ),
                new SizedBox(
                  height: 24.0,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    hintText: FireAuthUILocalizations.of(context).displayNameHint,
                    labelText: FireAuthUILocalizations.of(context).displayName,
                    filled: true,
                  ),
                  keyboardType: TextInputType.text,
                  onSaved: (String val) {
                    _displayName = val;
                  },
                ),
                new SizedBox(
                  height: 24.0,
                ),
                new FireAuthUIPasswordField(
                  //fieldKey: _passwordFieldKey,
                  helperText: 'No more than 8 characters.',
                  labelText: FireAuthUILocalizations.of(context).password,
                  onSaved: (String val) {
                    _password = val;
                  },
                ),
                new RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _onSignUp,
                  child: new Text(
                    FireAuthUILocalizations.of(context).signUp,
                    style: Theme
                        .of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
