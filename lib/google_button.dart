import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  static const String imagePackage = 'fireauth_ui';
  final VoidCallback onPressed;
  final String labelText;

  GoogleButton({this.onPressed, this.labelText});

  @override
  Widget build(BuildContext context) {
    return new RaisedButton.icon(
        onPressed: onPressed,
        color: Colors.white,
        icon: new Image.asset(
          "images/btn_google_icon.png",
          package: imagePackage,
        ),
        label: new Expanded(
          child: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: new Text(
              labelText,
            ),
          ),
        ));
  }
}