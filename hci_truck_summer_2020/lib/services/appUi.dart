import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color focusColor;
  final String text;

  const PrimaryButton(
      {Key key,
      @required this.onPressed,
      this.textColor,
      this.color,
      this.focusColor,
      this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
              color: color == null ? AppConstants.buttonColor : color),
        ),
        child: Text(
          text == null ? 'BUTTON' : text,
          style: TextStyle(
            fontSize: AppConstants.minFontSize,
            color: textColor == null ? Colors.white : textColor,
          ),
        ),
        color: color == null ? AppConstants.buttonColor : color,
        disabledColor: color == null ? AppConstants.buttonColor : color,
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color focusColor;
  final String text;

  const BorderButton(
      {Key key,
      @required this.onPressed,
      this.color,
      this.textColor,
      this.focusColor,
      this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: RaisedButton(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
              color: color == null ? AppConstants.buttonColorRed : color,
              width: 2.0),
        ),
        onPressed: onPressed,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            fontSize: AppConstants.minFontSize,
            color: textColor == null ? AppConstants.buttonColorRed : textColor,
          ),
        ),
        color: color == null ? Colors.white : color,
        disabledColor: color == null ? Colors.white : color
      ),
    );
  }
}


class DialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color textColor;
  final Color focusColor;
  final String text;

  const DialogButton(
      {Key key,
      @required this.onPressed,
      this.textColor,
      this.focusColor,
      this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: RaisedButton(
        elevation: 0.0,
        onPressed: onPressed,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            fontSize: AppConstants.minFontSize,
            color: textColor == null ? AppConstants.buttonColorRed : textColor,
          ),
        ),
      ),
    );
  }
}
