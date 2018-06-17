import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fireauth_ui/fireauth_ui.dart';

void main() => runApp(new MaterialApp(
      home: new MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool emailEnable = true;
  bool facebookEnable = true;
  bool googleEnable = true;

  @override
  initState() {
    super.initState();
  }

  void _showSignInPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new FireAuthUISignInPage(
                emailOptions: emailEnable ? new FireAuthUIEmailOptions() : null,
                facebookOptions:
                    facebookEnable ? new FireAuthUIFacebookOptions() : null,
                googleOptions:
                    googleEnable ? new FireAuthUIGoogleOptions() : null,
              )),
    );
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
              onPressed: _showSignInPage,
              child: new Text("Sign in"),
            ),
          )
        ],
      ),
    );
  }
}
