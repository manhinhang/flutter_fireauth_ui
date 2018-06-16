import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fireauth_ui/fireauth_ui.dart';

void main() => runApp(new MaterialApp(home: new MyApp(),));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }


  void _showSignInPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new FireAuthUISignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Fire Auth UI Demo'),
      ),
      body: new Center(
        child: new RaisedButton(onPressed: _showSignInPage, child: new Text("Sign in"),),
      ),
    );
  }
}
