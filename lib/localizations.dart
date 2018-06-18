
import 'package:fireauth_ui/l10n/messages_all.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class FireAuthUILocalizations {
  final Locale locale;

  FireAuthUILocalizations(this.locale);

  static Future<FireAuthUILocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return new FireAuthUILocalizations(locale);
    });
  }

  static FireAuthUILocalizations of(BuildContext context) {
    FireAuthUILocalizations localizations = Localizations.of<FireAuthUILocalizations>(
        context, FireAuthUILocalizations);
    if(localizations == null) {
      localizations = new FireAuthUILocalizations(new Locale("en"));
    }
    return localizations;
  }

  String get facebookSignInButton {
    return Intl.message(
      'Sign in with Facebook',
      name: 'facebookSignInButton',
      desc: 'Text for facebook sign in button',
    );
  }

  String get googleSignInButton {
    return Intl.message(
      'Sign in with Google',
      name: 'googleSignInButton',
      desc: 'Text for google sign in button',
    );
  }

  String get emailSignInButton {
    return Intl.message(
      'Sign in with Email',
      name: 'emailSignInButton',
      desc: 'Text for Email sign in button',
    );
  }

  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: 'text of sign in',
    );
  }

  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: 'text of sign up',
    );
  }

  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'email',
    );
  }

  String get emailHint {
    return Intl.message(
      'Enter your email',
      name: 'emailHint',
      desc: 'enter your email',
    );
  }

  String get emptyEmailWarning {
    return Intl.message(
      'Please enter your email',
      name: 'emptyEmailWarning',
      desc: 'email is empty',
    );
  }

  String get invalidEmailWarning {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmailWarning',
      desc: 'invalid eamil',
    );
  }

  String get continueText {
    return Intl.message(
      'Continue',
      name: 'continueText',
      desc: 'continue',
    );
  }

  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: 'error',
    );
  }

  String get okay {
    return Intl.message(
      'OK',
      name: 'okay',
      desc: 'okay',
    );
  }

  String get displayName {
    return Intl.message(
      'Display Name',
      name: 'displayName',
      desc: 'Display Name',
    );
  }

  String get displayNameHint {
    return Intl.message(
      'Enter your display name',
      name: 'displayNameHint',
      desc: 'Display Name',
    );
  }

  String get password {
    return Intl.message(
      'Password *',
      name: 'password',
      desc: 'password',
    );
  }

  String get forgotPassword {
    return Intl.message(
      'Forgot Password ? ',
      name: 'forgotPassword',
      desc: 'forgotPassword',
    );
  }

}

class FireAuthUILocalizationsDelegate
    extends LocalizationsDelegate<FireAuthUILocalizations> {
  const FireAuthUILocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;


  @override
  Future<FireAuthUILocalizations> load(Locale locale) {
    return FireAuthUILocalizations.load(locale);
  }

  @override
  bool shouldReload(FireAuthUILocalizationsDelegate old) {
    return false;
  }

  static const LocalizationsDelegate<FireAuthUILocalizations> delegate = const FireAuthUILocalizationsDelegate();
}
