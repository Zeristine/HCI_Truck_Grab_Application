import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
              color:
                  textColor == null ? AppConstants.buttonColorRed : textColor,
            ),
          ),
          color: color == null ? Colors.white : color,
          disabledColor: color == null ? Colors.white : color),
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

class DriverCard extends StatelessWidget {
  final String driverName;
  final String avatarPath;
  final Color backgroudColor;
  final Color titleColor;

  const DriverCard(
      {this.driverName, this.avatarPath, this.backgroudColor, this.titleColor});
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: backgroudColor,
      color: backgroudColor,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar1.jpg'),
              radius: 40,
            ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Nguyễn Trọng Tài',
                  style: TextStyle(
                      fontSize: AppConstants.medFontSize,
                      fontWeight: FontWeight.bold,
                      color: titleColor),
                ),
                SizedBox(
                  height: 12.0,
                ),
                RatingBar(
                  unratedColor: Colors.grey[400],
                  itemPadding: EdgeInsets.only(right: 4.0),
                  initialRating: 2.5,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  direction: Axis.horizontal,
                  onRatingUpdate: (null),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.blue,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Icon(
                            Icons.message,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.blue,
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                          )),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
