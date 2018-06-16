import 'package:flutter/material.dart';

class EmailButton extends StatelessWidget {
  static const String imagePackage = 'fireauth_ui';
  final VoidCallback onPressed;
  final String labelText;
  final Color backgroundColor;

  EmailButton({this.onPressed, this.labelText, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return new RaisedButton.icon(
        onPressed: onPressed,
        color: backgroundColor == null ? Colors.red : backgroundColor,
        icon: new Icon(Icons.email, color: Colors.white,),
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
