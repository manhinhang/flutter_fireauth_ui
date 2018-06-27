import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fireauth_ui/fireauth_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(new MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FireAuthUILocalizationsDelegate.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('jp', 'JP'), // Hebrew
        const Locale('zh_HK', 'HK'), // Hebrew
        // ... other locales the app supports
      ],
      home: new MyApp(),
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        return locale;
      },
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool emailEnable = true;
  bool facebookEnable = true;
  bool googleEnable = true;
  FirebaseUser user;
  Stream<FirebaseUser> _userSteam;
  StreamSubscription _onAuthStateChangedSubscription;

  @override
  initState() {
    super.initState();
    _userSteam = FirebaseAuth.instance.onAuthStateChanged;
    _onAuthStateChangedSubscription =
        _userSteam.listen(onAuthStateChanged);
  }

  void onAuthStateChanged(FirebaseUser user) {
    setState(() {
      this.user = user;
    });
  }

  void dispose() {
    super.dispose();
    _onAuthStateChangedSubscription.cancel();
  }

  Widget _buildUserInfo() {
    if (user == null) {
      return new Container();
    }
    return new Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            new Center(child: new Text('User Info:'),),
            new Row(children: <Widget>[
              user.photoUrl == null
                  ? new Container()
                  : new Image.network(user.photoUrl),
              new Expanded(
                child: new Column(
                  children: <Widget>[
                    new Text("Display Name"),
                    user.displayName == null
                        ? new Container()
                        : new Text(user.displayName)
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }

  void _showSignInPage() {
    List<FireAuthUIProvider> providers = [];
    if (emailEnable) {
      providers.add(FireAuthUIProvider.Email);
    }

    if (facebookEnable) {
      providers.add(FireAuthUIProvider.Facebook);
    }

    if (googleEnable) {
      providers.add(FireAuthUIProvider.Google);
    }
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new FireAuthUISignInPage(
                providers: providers,
              )),
    ).then((_) {
      setState(() {

      });
    });

  }

  Future _signOut() async {
    setState(() {
      user = null;
    });
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Fire Auth UI Demo'),
      ),
      body: new ListView(
        padding: EdgeInsets.all(24.0),
        children: <Widget>[
          _buildUserInfo(),
          new SizedBox(
            height: 24.0,
          ),
          new Row(
            children: <Widget>[
              new Expanded(child: new Text("Provider")),
              new Text("Enable"),
            ],
          ),
          new Row(
            children: <Widget>[
              new Expanded(child: new Text("Email")),
              new Checkbox(
                  value: emailEnable,
                  onChanged: (bool value) {
                    setState(() {
                      emailEnable = value;
                    });
                  })
            ],
          ),
          new Row(
            children: <Widget>[
              new Expanded(child: new Text("Google")),
              new Checkbox(
                  value: googleEnable,
                  onChanged: (bool value) {
                    setState(() {
                      googleEnable = value;
                    });
                  })
            ],
          ),
          new Row(
            children: <Widget>[
              new Expanded(child: new Text("Facebook")),
              new Checkbox(
                  value: facebookEnable,
                  onChanged: (bool value) {
                    setState(() {
                      facebookEnable = value;
                    });
                  })
            ],
          ),
          new Center(
            child: new RaisedButton(
              onPressed: user == null ? _showSignInPage : _signOut,
              child: new Text(user == null ? "Sign in" : "Sign out"),
            ),
          )
        ],
      ),
    );
  }
}
