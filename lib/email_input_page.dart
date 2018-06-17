import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireauth_ui/email_sign_up_page.dart';
import 'package:fireauth_ui/email_sign_in_page.dart';

class FireAuthUIEmailInputPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FireAuthUIEmailInputPageState();
  }
}

class FireAuthUIEmailInputPageState extends State<FireAuthUIEmailInputPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email;

  String _validateEmail(String value) {
    if (value.isEmpty) return 'Please enter email';
    final RegExp nameExp =
        new RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    if (!nameExp.hasMatch(value)) return 'Invalid email';
    return null;
  }

  void _onNextStep() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      FirebaseAuth.instance.fetchProvidersForEmail(email: _email).then(
          (List<String> providers) {
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
      }, onError: (error) {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new FireAuthEmailSignUpPage(_email)),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Enter your email"),
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
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    labelText: 'Email',
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
                new RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _onNextStep,
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
