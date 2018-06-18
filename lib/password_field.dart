import 'package:flutter/material.dart';

class FireAuthUIPasswordField extends StatefulWidget {
  const FireAuthUIPasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.enabled,
    this.focusNode,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final enabled;
  final FocusNode focusNode;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<FireAuthUIPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        enabled: widget.enabled,
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}