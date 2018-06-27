import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireauth_ui/email_sign_up_page.dart';
import 'package:fireauth_ui/email_sign_in_page.dart';
import 'package:fireauth_ui/localizations.dart';
import 'package:flutter/services.dart';


class FireAuthUIEmailInputPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FireAuthUIEmailInputPageState();
  }
}

class FireAuthUIEmailInputPageState extends State<FireAuthUIEmailInputPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email;
  bool _loading = false;

  String _validateEmail(String value) {
    if (value.isEmpty)
      return FireAuthUILocalizations.of(context).emptyEmailWarning;
    final RegExp nameExp =
        new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    if (!nameExp.hasMatch(value))
      return FireAuthUILocalizations.of(context).invalidEmailWarning;
    return null;
  }

  Future _onNextStep() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });

      try {
        List<String> providers =
            await FirebaseAuth.instance.fetchProvidersForEmail(email: _email);
        if (providers == null || providers.length == 0) {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new FireAuthEmailSignUpPage(_email)),
          );
        } else {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new FireAuthEmailSignInPage(_email)),
          );
        }
      } catch (e) {
        _showError(e);
      }
      setState(() {
        _loading = false;
      });
    }
  }

  void _showError(error) {
    String errorMsg = "";
    if (error is PlatformException) {
      PlatformException platformException = error;
      errorMsg = platformException.details;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
            title: new Text(FireAuthUILocalizations.of(context).error),
            content: new Text(errorMsg),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text(FireAuthUILocalizations.of(context).okay))
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(FireAuthUILocalizations.of(context).emailHint),
      ),
      body: new Stack(
        children: <Widget>[
          _loading ? new LinearProgressIndicator() : new Container(),
          new Form(
              key: _formKey,
              child: new SingleChildScrollView(
                  child: new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new TextFormField(
                      decoration: new InputDecoration(
                        hintText: FireAuthUILocalizations.of(context).emailHint,
                        labelText: FireAuthUILocalizations.of(context).email,
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String val) {
                        _email = val;
                      },
                      onFieldSubmitted: (_) {
                        _onNextStep();
                      },
                      validator: _validateEmail,
                      enabled: _loading == false,
                      autofocus: true,
                    ),
                    new SizedBox(
                      height: 24.0,
                    ),
                    new RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: _loading ? null : _onNextStep,
                      child: new Text(
                        FireAuthUILocalizations.of(context).continueText,
                        style: Theme
                            .of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )))
        ],
      ),
    );
  }
}
