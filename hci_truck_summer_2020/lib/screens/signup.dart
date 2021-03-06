import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/homeTruck.dart';
import 'package:truck/screens/userHome.dart';
import 'package:truck/services/appUi.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  String role = "booker";
  final GlobalKey<FormState> signupformKey =
      GlobalKey(debugLabel: 'signupformKey');
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode repasswordFocus = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  void toLoginScreen(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    repasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Tạo tài khoản mới',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Form(
              key: signupformKey,
              child: Center(
                  child: Column(
                children: <Widget>[
                  signUpForm(
                      context,
                      usernameController,
                      emailController,
                      passwordController,
                      repasswordController,
                      emailFocus,
                      passwordFocus,
                      repasswordFocus),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Bạn là :"),
                  ListTile(
                    title: Text('Chủ đơn hàng'),
                    leading: Radio(
                        value: 'booker',
                        groupValue: role,
                        onChanged: (String value) {
                          setState(() {
                            this.role = value;
                          });
                        }),
                  ),
                  ListTile(
                    title: Text('Tài xế xe tải lớn'),
                    leading: Radio(
                        value: 'driver',
                        groupValue: role,
                        onChanged: (String value) {
                          setState(() {
                            this.role = value;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  signUpButtonGroup(role, signupformKey, context,
                      passwordController, repasswordController),
                ],
              ))),
        ),
      ),
    );
  }
}

Widget signUpForm(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController repasswordController,
    FocusNode emailFocus,
    FocusNode passwordFocus,
    FocusNode repasswordFocus) {
  return Column(
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
            borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
          ),
          hintText: "Tên người dùng",
        ),
        controller: usernameController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        maxLines: 1,
        validator: (text) {
          if (text.length == 0) {
            return "Xin hãy nhập tên người dùng của bạn.";
          } else if (text.length < 4) {
            return "Tên người dùng có ít nhất 5 chữ.";
          } else {
            return null;
          }
        },
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(emailFocus);
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
            borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
          ),
          hintText: "Email của bạn",
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        maxLines: 1,
        focusNode: emailFocus,
        validator: (text) {
          if (text.isEmpty) {
            return "Xin hãy nhập email của bạn.";
          } else if (!EmailValidator.validate(text)) {
            return "Email này sai cú pháp.";
          }
          return null;
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
            borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
          ),
          hintText: "Mật khẩu của bạn",
        ),
        controller: passwordController,
        maxLines: 1,
        obscureText: true,
        focusNode: passwordFocus,
        validator: (text) {
          if (text.length == 0) {
            return "Xin hãy nhập mật khẩu của bạn.";
          } else if (text.length < 8) {
            return "Mật khẩu có ít nhất 8 chữ.";
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
            borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
          ),
          hintText: "Nhập lại mật khẩu của bạn",
        ),
        controller: repasswordController,
        maxLines: 1,
        obscureText: true,
        focusNode: repasswordFocus,
      ),
    ],
  );
}

Widget signUpButtonGroup(
    String role,
    GlobalKey<FormState> formKey,
    BuildContext context,
    TextEditingController passwordController,
    TextEditingController repasswordController) {
  return PrimaryButton(
    onPressed: () {
      if (formKey.currentState.validate()) {
        if (passwordController.text.trim() ==
            repasswordController.text.trim()) {
          if (role == 'driver') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeTruckScreen()),
                (route) => false);
          } else if (role == 'booker') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => UserHomeScreen()),
                (route) => false);
          }
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Mật khẩu bạn nhập lại không khớp với mật khẩu của bạn",
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                          PrimaryButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Đóng',
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      }
    },
    text: 'Tạo tài khoản',
  );
}
