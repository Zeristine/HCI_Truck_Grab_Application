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
  String userId, userPassword;
  final FocusNode passwordFocus1 = FocusNode();
  final FocusNode repasswordFocus1 = FocusNode();

  Future getUserData() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    userPassword = prefs.getString('password');
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    passwordFocus1.dispose();
    repasswordFocus1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(240, 58, 58, 1),
              leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Thay đổi mật khẩu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
                child: changePasswordComponents(context, userPassword, userId,
                    prefs, passwordFocus1, repasswordFocus1)),
          );
        });
  }
}

Widget changePasswordComponents(
    BuildContext context,
    String userPassword,
    String userId,
    SharedPreferences prefs,
    FocusNode passwordFocus,
    FocusNode repasswordFocus) {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  return Container(
    child: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.next,
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
                    }
                    // else if (!(text.trim() == userPassword)) {
                    //   return "Mật khẩu cũ không giống";
                    // }
                    else {
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
                  textInputAction: TextInputAction.next,
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
                    } else if (text == oldpasswordController.text) {
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
                  textInputAction: TextInputAction.done,
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
                    updatePassword(formKey, userId, prefs, context,
                        passwordController, repasswordController);
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
    GlobalKey<FormState> formKey,
    String userId,
    SharedPreferences prefs,
    BuildContext context,
    TextEditingController passwordController,
    TextEditingController repasswordController) async {
  var progressDialog = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false);
  progressDialog.style(
    progressWidget: Container(
        padding: EdgeInsets.all(12), child: CircularProgressIndicator()),
  );
  if (formKey.currentState.validate()) {
    await progressDialog.show();
    if (passwordController.text == repasswordController.text) {
      var response = await http
          .get('https://truck-api.azurewebsites.net/api/users/' + userId);
      if (response.statusCode == HttpStatus.ok) {
        User user = User.fromJson(json.decode(response.body));
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
          var updateResponse = await http.put(
              'https://truck-api.azurewebsites.net/api/users/' + userId,
              headers: {"Content-Type": "application/json"},
              body: jsonEncode(updateValue.toJson()));
          if (updateResponse.statusCode == HttpStatus.noContent) {
            await progressDialog.hide().then((value) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0)), //this right here
                    child:
                        DialogMessage(message: 'Thay đổi mật khẩu thành công!'),
                  );
                }));
            await prefs.setString('password', user.password);
          } else {
            print(updateResponse.statusCode);
            await progressDialog.hide().then((value) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0)), //this right here
                    child: DialogMessage(
                        message: 'Có sự cố trong việc thay đổi mật khẩu...'),
                  );
                }));
          }
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
