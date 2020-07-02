import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/services/appUi.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Thay đổi mật khẩu',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: changePasswordComponents(context),
    );
  }
}

Widget changePasswordComponents(BuildContext context) {
  final FocusNode passwordFocus = FocusNode();
  final FocusNode repasswordFocus = FocusNode();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  return Container(
    child: Form(
        child: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Change Password',
              style: TextStyle(fontSize: 25.0),
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: AppConstants.minFontSize,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: AppConstants.linkColor, width: 2.0),
                ),
                hintText: "Mật khẩu hiện tại",
              ),
              controller: oldpasswordController,
              autocorrect: false,
              maxLines: 1,
              obscureText: true,
              validator: (text) {
                if (text.length == 0) {
                  return "Xin hãy nhập mật khẩu hiện tại ở đây!";
                } else {
                  return null;
                }
              },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: AppConstants.minFontSize,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: AppConstants.linkColor, width: 2.0),
                ),
                hintText: "Mật khẩu mới",
              ),
              controller: passwordController,
              autocorrect: false,
              maxLines: 1,
              obscureText: true,
              focusNode: passwordFocus,
              validator: (text) {
                if (text.length == 0) {
                  return "Xin hãy nhập mật khẩu mới ở đây";
                } else if (text.length < 8) {
                  return "Mật khâu có ít nhất 8 ký tự";
                }else if(text == oldpasswordController.text){
                    return "Đây là mật khẩu cũ!";
                } else {
                  return null;
                }
              },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(repasswordFocus);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: AppConstants.minFontSize,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: AppConstants.linkColor, width: 2.0),
                ),
                hintText: "Nhập lại mật khẩu mới",
              ),
              controller: repasswordController,
              autocorrect: false,
              maxLines: 1,
              obscureText: true,
              focusNode: repasswordFocus,
            ),
            SizedBox(
              height: 24,
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              text: 'Thay đổi mật khẩu',
            ),
            SizedBox(
              height: 10,
            ),            
          ],
        ),
      ),
    )),
  );
}
