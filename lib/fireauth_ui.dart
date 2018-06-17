import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireauth_ui/facebook_button.dart';
import 'package:fireauth_ui/google_button.dart';
import 'package:fireauth_ui/email_button.dart';
import 'package:fireauth_ui/email_input_page.dart';

class FireauthUi {
  static const MethodChannel _channel = const MethodChannel('fireauth_ui');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}



class FireAuthUIEmailOptions {
  final String signInButtonText = "Sign in with Email";
}

class FireAuthUIGoogleOptions {
  final String signInButtonText = "Sign in with Google";
}

class FireAuthUIFacebookOptions {
  final String signInButtonText = "Sign in with Facebook";
}

class FireAuthUISignInPage extends StatefulWidget {
  final String title;
  final num buttonWidth;
  final FireAuthUIEmailOptions emailOptions;
  final FireAuthUIGoogleOptions googleOptions;
  final FireAuthUIFacebookOptions facebookOptions;

  // ignore: non_constant_default_value
  FireAuthUISignInPage(
      {this.title = "Sign In",
      this.buttonWidth = 210.0,
      this.emailOptions,
      this.googleOptions,
      this.facebookOptions}) {}

  @override
  State<StatefulWidget> createState() {
    return new FireAuthUISignInPageState();
  }
}

class FireAuthUISignInPageState extends State<FireAuthUISignInPage> {
  static const String imagePackage = 'fireauth_ui';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final FacebookLogin _facebookLogin = new FacebookLogin();
  FirebaseUser _firebaseUser;
  final double _itemSpace = 24.0;

  Future<Null> _signInWithFacebook() async {
    var result = await _facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _firebaseUser = await _auth.signInWithFacebook(
            accessToken: result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
  }

  Future<Null> _signInWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      _firebaseUser = await _auth.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    } catch (e) {
      print(e.error);
    }
  }

  void _signInWithEmail() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new FireAuthUIEmailInputPage()),
    );
    /*
    if(!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print("Password:$password, $email");
    _auth.signInWithEmailAndPassword(email: email, password: password);
    */
  }

  void _showError(String errMsg) {}

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (widget.emailOptions != null) {
      widgets.add(new SizedBox(
        height: _itemSpace,
      ));
      widgets.add(new EmailButton(
        onPressed: _signInWithEmail,
        labelText: widget.emailOptions.signInButtonText,
      ));
    }

    if (widget.googleOptions != null) {
      widgets.add(new SizedBox(
        height: _itemSpace,
      ));
      widgets.add(new GoogleButton(
        onPressed: _signInWithGoogle,
        labelText: widget.googleOptions.signInButtonText,
      ));
    }

    if (widget.facebookOptions != null) {
      widgets.add(new SizedBox(
        height: _itemSpace,
      ));
      widgets.add(new FacebookButton(
        onPressed: _signInWithFacebook,
        labelText: widget.facebookOptions.signInButtonText,
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new Container(
            width: widget.buttonWidth,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widgets,
            ),
          ),
        ),
      ),
    );
  }
}
