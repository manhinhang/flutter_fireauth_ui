import 'package:flutter/material.dart';

class FacebookButton extends StatelessWidget {
  static const String imagePackage = 'fireauth_ui';
  final VoidCallback onPressed;
  final String labelText;

  FacebookButton({this.onPressed, this.labelText});

  @override
  Widget build(BuildContext context) {
    return new RaisedButton.icon(
        onPressed: onPressed,
        color: Color(0xff3B5998),
        icon: new Image.asset(
          "images/btn_facebook_icon.png",
          package: imagePackage,
        ),
        label: new Expanded(
          child: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: new Text(
              labelText,
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}