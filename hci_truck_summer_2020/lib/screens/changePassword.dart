import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/user.dart';
import 'package:truck/services/Dialog.dart';
import 'package:truck/services/appUi.dart';
import 'package:http/http.dart' as http;

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordScreen> {
  SharedPreferences prefs;
  String userPasswordData;
  String userId;
  final FocusNode passwordFocus = FocusNode();
  final FocusNode repasswordFocus = FocusNode();
  final GlobalKey<FormState> changePasswordFormKey =
      GlobalKey(debugLabel: 'changePasswordformKey');
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  void getUserData() async {
    prefs = await SharedPreferences.getInstance();
    userPasswordData = prefs.getString('password');
    userId = prefs.getString('userId');
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    passwordFocus.dispose();
    repasswordFocus.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: changePasswordComponents(
            context,
            prefs,
            userPasswordData,
            userId,
            oldpasswordController,
            passwordController,
            repasswordController,
            passwordFocus,
            repasswordFocus,
            changePasswordFormKey),
      ),
    );
  }
}

Widget changePasswordComponents(
    BuildContext context,
    SharedPreferences prefs,
    String userPasswordData,
    String userId,
    TextEditingController oldpasswordController,
    TextEditingController passwordController,
    TextEditingController repasswordController,
    FocusNode passwordFocus,
    FocusNode repasswordFocus,
    GlobalKey changePasswordFormKey) {
  return Container(
    child: Form(
        key: changePasswordFormKey,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                    } else if (text.trim() != userPasswordData) {
                      return "Mật Khẩu hiện tại không giống";
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
                    } else if (text.trim() == userPasswordData) {
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
                  onPressed: () async {
                    updatePassword(context, changePasswordFormKey, prefs,
                        passwordController, repasswordController, userId);
                    // Navigator.of(context, rootNavigator: true).pop();
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

Future updatePassword(
    BuildContext context,
    GlobalKey<FormState> formKey,
    SharedPreferences prefs,
    TextEditingController passwordController,
    TextEditingController repasswordController,
    String userId) async {
  var progressDialog = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false);
  progressDialog.style(
    progressWidget: Container(
        padding: EdgeInsets.all(12), child: CircularProgressIndicator()),
  );
  if (formKey.currentState.validate()) {
    await progressDialog.show();
    if (passwordController.text == repasswordController.text) {
      print("I'm here with userId  = " + userId);
      var response = await http
          .get(
            'https://truck-api.azurewebsites.net/api/users/driver@gmail.com'
            // + userId
            );
      if (response.statusCode == HttpStatus.ok) {
        User user = User.fromJson(json.decode(response.body));
        print(user.toJson());
        if (user != null) {
          User updateValue = User(
            userId: user.userId,
            fullName: user.fullName,
            dateOfBirth: user.dateOfBirth,
            gender: user.gender,
            imagePath: user.imagePath,
            phoneNumber: user.phoneNumber,
            quotations: user.quotations,
            requests: user.requests,
            role: user.role,
            roleId: user.roleId,
            password: passwordController.text,
          );
          // var updateResponse = await http.post(
          //     'https://truck-api.azurewebsites.net/api/users/' + userId,
          //     headers: {"Content-Type": "application/json"},
          //     body: jsonEncode(updateValue.toJson()));
          // if (updateResponse.statusCode == HttpStatus.ok) {
          //   await progressDialog.hide().then((value) => showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return Dialog(
          //           shape: RoundedRectangleBorder(
          //               borderRadius:
          //                   BorderRadius.circular(5.0)), //this right here
          //           child:
          //               DialogMessage(message: 'Thay đổi mật khẩu thành công!'),
          //         );
          //       }));
          //   await prefs.setString('password', user.password);
          // } else {
          //   await progressDialog.hide().then((value) => showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return Dialog(
          //           shape: RoundedRectangleBorder(
          //               borderRadius:
          //                   BorderRadius.circular(5.0)), //this right here
          //           child: DialogMessage(
          //               message: 'Có sự cố trong việc thay đổi mật khẩu...'),
          //         );
          //       }));
          // }
        }
      } else {
        await progressDialog.hide().then((value) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)), //this right here
                child: DialogMessage(
                    message: 'Có sự cố trong việc thay đổi mật khẩu...'),
              );
            }));
      }
    } else {
      await progressDialog.hide().then((value) => showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)), //this right here
              child: DialogMessage(
                  message:
                      'Mật khẩu mới không giống với mật khẩu bạn nhập lại!'),
            );
          }));
    }
  }
}
