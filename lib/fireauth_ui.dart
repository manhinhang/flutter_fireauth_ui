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

enum FireAuthUIProvider { Facebook, Google, Email }

class FireAuthUISignInPage extends StatefulWidget {
  final String title;
  final num buttonWidth;
  final List<FireAuthUIProvider> providers;

  // ignore: non_constant_default_value
  FireAuthUISignInPage(
      {this.title = "Sign In", this.buttonWidth = 210.0, this.providers});

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
  final double _itemSpace = 24.0;

  Future<Null> _signInWithFacebook() async {
    var result = await _facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          await _auth.signInWithFacebook(accessToken: result.accessToken.token);
        } catch (e) {}
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
      await _auth.signInWithGoogle(
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
  }

  void _showError(String errMsg) {}

  Widget _buildEmailButton() {
    return new EmailButton(
      onPressed: _signInWithEmail,
      labelText: "Sign in with Email",
    );
  }

  Widget _buildFacebookButton() {
    return new FacebookButton(
      onPressed: _signInWithFacebook,
      labelText: "Sign in with Facebook",
    );
  }

  Widget _buildGoogleButton() {
    return new GoogleButton(
      onPressed: _signInWithGoogle,
      labelText: "Sign in with Google",
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = widget.providers.map((FireAuthUIProvider provider) {
      Widget button;
      switch (provider) {
        case FireAuthUIProvider.Facebook:
          button = _buildFacebookButton();
          break;
        case FireAuthUIProvider.Google:
          button = _buildGoogleButton();
          break;
        case FireAuthUIProvider.Email:
          button = _buildEmailButton();
          break;
      }

      return new Column(
        children: <Widget>[
          button,
          new SizedBox(
            height: _itemSpace,
          )
        ],
      );
    }).toList();


    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SingleChildScrollView(
        child: new Center(
          child: new Container(
            padding: EdgeInsets.only(top: _itemSpace),
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
