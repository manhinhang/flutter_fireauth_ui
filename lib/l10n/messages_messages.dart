// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "continueText" : MessageLookupByLibrary.simpleMessage("Continue"),
    "displayName" : MessageLookupByLibrary.simpleMessage("Display Name"),
    "displayNameHint" : MessageLookupByLibrary.simpleMessage("Enter your display name"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "emailHint" : MessageLookupByLibrary.simpleMessage("Enter your email"),
    "emailSignInButton" : MessageLookupByLibrary.simpleMessage("Sign in with Email"),
    "emptyEmailWarning" : MessageLookupByLibrary.simpleMessage("Please enter your email"),
    "error" : MessageLookupByLibrary.simpleMessage("Error"),
    "facebookSignInButton" : MessageLookupByLibrary.simpleMessage("Sign in with Facebook"),
    "forgotPassword" : MessageLookupByLibrary.simpleMessage("Forgot Password ? "),
    "googleSignInButton" : MessageLookupByLibrary.simpleMessage("Sign in with Google"),
    "invalidEmailWarning" : MessageLookupByLibrary.simpleMessage("Invalid email"),
    "okay" : MessageLookupByLibrary.simpleMessage("OK"),
    "password" : MessageLookupByLibrary.simpleMessage("Password *"),
    "signIn" : MessageLookupByLibrary.simpleMessage("Sign In"),
    "signUp" : MessageLookupByLibrary.simpleMessage("Sign Up")
  };
}
