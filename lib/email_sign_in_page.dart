import 'package:flutter/material.dart';
import 'package:fireauth_ui/password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FireAuthEmailSignInPage extends StatefulWidget {
  final String _email;

  FireAuthEmailSignInPage(String email) : _email = email;

  @override
  State<StatefulWidget> createState() {
    return new FireAuthEmailSignInPageState(_email);
  }
}

class FireAuthEmailSignInPageState extends State<FireAuthEmailSignInPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  FireAuthEmailSignInPageState(String email) : _email = email;

  String _validateEmail(String value) {
    if (value.isEmpty) return 'Please enter email';
    final RegExp nameExp =
        new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    if (!nameExp.hasMatch(value)) return 'Invalid email';
    return null;
  }

  void _onSignIn() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((_) {
        int popCount = 4;
        Navigator.popUntil(context, (Route<dynamic> route) {
          popCount--;
          return popCount == 0;
        });
      }, onError: (error) {
        print(error);
        if (error is PlatformException) {
          PlatformException platformException = error;
          showDialog(
            context: context,
            builder: (BuildContext context) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text(platformException.details),
                  actions: <Widget>[
                    new FlatButton(onPressed: () {

                    }, child: new Text("OK"))
                  ],
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
        title: new Text("Sign In"),
      ),
      body: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
              child: new Padding(
            padding: const EdgeInsets.all(24.0),
            child: new Column(
              children: <Widget>[
                new TextFormField(
                  initialValue: _email,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String val) {
                    _email = val;
                  },
                  onFieldSubmitted: (String val) {
                    print("val$val");
                  },
                  validator: _validateEmail,
                ),
                new SizedBox(
                  height: 24.0,
                ),
                new FireAuthUIPasswordField(
                  //fieldKey: _passwordFieldKey,
                  helperText: 'No more than 8 characters.',
                  labelText: 'Password *',
                  onFieldSubmitted: (String value) {
//                    setState(() {
//                      person.password = value;
//                    });
                  },
                  onSaved: (String value) {
                    _password = value;
                  },
                ),
                new RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _onSignIn,
                  child: new Text(
                    "Next",
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
