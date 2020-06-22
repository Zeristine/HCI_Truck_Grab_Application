import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';

class UserCreateRequestScreen extends StatefulWidget {
  @override
  _UserCreateRequestScreenState createState() =>
      _UserCreateRequestScreenState();
}

class _UserCreateRequestScreenState extends State<UserCreateRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: pickUpWidget(context),
      ),
    );
  }
}

Widget pickUpWidget(BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        width: double.infinity,
        child: Text(
          "Nhập thông tin chủ hàng",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
          ),
        ),
      ),
      SizedBox(
        height: 12,
      ),
      textField(context, "Địa chỉ"),
      textField(context, "Số điện thoại")
    ],
  );
}

Widget textField(BuildContext context, String hint) {
  return TextFormField(
    textInputAction: TextInputAction.next,
    style: TextStyle(
      fontSize: AppConstants.minFontSize,
      fontFamily: 'Roboto',
    ),
    decoration: InputDecoration(
      //labelText: 'EMAIL',
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
      ),
      hintText: hint,
    ),
    maxLines: 1,
    //controller: emailController,
    // onFieldSubmitted: (v) {
    //   FocusScope.of(context).requestFocus(focus);
    // },
    validator: (text) {
      if (text.length == 0) {
        return "Xin hãy nhập email ở đây";
      } else {
        return null;
      }
    },
  );
}
