import 'dart:async';

import 'package:fireauth_ui/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<T> showErrorDialog<T>({@required BuildContext context, error}) {
  String errorMsg = "";
  if (error is PlatformException) {
    PlatformException platformException = error;
    errorMsg = FireAuthUILocalizations.of(context).errorMessage(platformException.code);
  }
  return showDialog(
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
          ));
}
