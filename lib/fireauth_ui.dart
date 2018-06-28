import 'dart:async';

import 'package:fireauth_ui/dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireauth_ui/facebook_button.dart';
import 'package:fireauth_ui/google_button.dart';
import 'package:fireauth_ui/email_button.dart';
import 'package:fireauth_ui/email_input_page.dart';
import 'package:fireauth_ui/localizations.dart';
export 'package:fireauth_ui/localizations.dart' show FireAuthUILocalizations;
export 'package:fireauth_ui/localizations.dart'
    show FireAuthUILocalizationsDelegate;

class FireauthUi {
  static const MethodChannel _channel = const MethodChannel('fireauth_ui');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

enum FireAuthUIProvider { Facebook, Google, Email }

class FireAuthUISignInPage extends StatefulWidget {
  final num buttonWidth;
  final List<FireAuthUIProvider> providers;

  FireAuthUISignInPage(
      {this.buttonWidth = 210.0, this.providers});

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
  bool _loading = false;

  Future<Null> _signInWithFacebook() async {
    setState(() {
      _loading = true;
    });
    var result = await _facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:

        try {
          await _auth.signInWithFacebook(accessToken: result.accessToken.token);
          Navigator.pop(context);
        } catch (e) {
          showErrorDialog(context:context, error: e);
        }

        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
    setState(() {
      _loading = false;
    });
  }

  Future<Null> _signInWithGoogle() async {
    setState(() {
      _loading = true;
    });
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      if(googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        await _auth.signInWithGoogle(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      showErrorDialog(context:context, error: e);
    }
    setState(() {
      _loading = false;
    });
  }

  void _signInWithEmail() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new FireAuthUIEmailInputPage()),
    );
  }

  Widget _buildEmailButton() {
    return new EmailButton(
      onPressed: _loading ? null : _signInWithEmail,
      labelText: FireAuthUILocalizations.of(context).emailSignInButton,
    );
  }

  Widget _buildFacebookButton() {
    return new FacebookButton(
      onPressed: _loading ? null : _signInWithFacebook,
      labelText: FireAuthUILocalizations.of(context).facebookSignInButton,
    );
  }

  Widget _buildGoogleButton() {
    return new GoogleButton(
      onPressed: _loading ? null : _signInWithGoogle,
      labelText: FireAuthUILocalizations.of(context).googleSignInButton,
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
        title: new Text(FireAuthUILocalizations.of(context).signIn),
      ),
      body: new Stack(
        children: <Widget>[
          _loading ? new LinearProgressIndicator() : new Container(),
          new SingleChildScrollView(
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
          )
        ],
      ),
    );
  }
}
