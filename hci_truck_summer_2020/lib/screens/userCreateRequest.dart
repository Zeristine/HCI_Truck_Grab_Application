import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/services/appUi.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              pickUpWidget(context),
              SizedBox(height: 24),
              targetWidget(context),
            ],
          ),
        ),
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
          "Thông tin chủ hàng",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
          ),
        ),
      ),
      SizedBox(
        height: 12,
      ),
      textField(context, "Họ và tên chủ hàng", null),
      SizedBox(
        height: 8,
      ),
      textField(context, "Số điện thoại", null),
      SizedBox(
        height: 8,
      ),
      textField(context, "Địa chỉ lấy hàng", () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: addressDialog(context),
            );
          },
        );
      }),
    ],
  );
}

Widget targetWidget(BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        width: double.infinity,
        child: Text(
          "Thông tin người nhận hàng",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: AppConstants.medFontSize,
          ),
        ),
      ),
      SizedBox(
        height: 12,
      ),
      textField(context, "Họ và tên người nhận hàng", null),
      SizedBox(
        height: 8,
      ),
      textField(context, "Số điện thoại", null),
      SizedBox(
        height: 8,
      ),
      textField(context, "Địa chỉ lấy hàng", null),
    ],
  );
}

Widget addressDialog(BuildContext context) {
  return Container(
    height: 408,
    padding: EdgeInsets.all(24),
    child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Text(
            "Nhập địa chỉ",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: AppConstants.medFontSize,
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        textField(context, "Tỉnh/Thành Phố", null),
        SizedBox(
          height: 8,
        ),
        textField(context, "Quận/Huyện", null),
        SizedBox(
          height: 8,
        ),
        textField(context, "Phường/Xã", null),
        SizedBox(
          height: 8,
        ),
        textField(context, "Đường, Số nhà...", null),
        SizedBox(height: 8,),
        PrimaryButton(onPressed: (){
          Navigator.pop(context);
        }, text: "Xác nhận",)
      ],
    ),
  );
}

Widget textField(BuildContext context, String hint, Function() ontap) {
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
    onTap: ontap,
    validator: (text) {
      if (text.length == 0) {
        return "Xin hãy nhập email ở đây";
      } else {
        return null;
      }
    },
  );
}
