import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/User.dart';
import 'package:truck/screens/signup.dart';
import 'package:truck/screens/userHome.dart';
import 'package:truck/services/Dialog.dart';
import 'package:truck/services/appUi.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

void toSignUpScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
}

void login(BuildContext context) {
  print(emailController.text + ' ' + passwordController.text);
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginformKey =
      GlobalKey(debugLabel: 'loginformKey');
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  Future<http.Response> fetchAlbum() {
    return http.get('https://jsonplaceholder.typicode.com/albums/1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: loginformKey,
            child: Container(
              padding: EdgeInsets.all(AppConstants.edgePadding),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    logo(),
                    SizedBox(
                      height: 40,
                    ),
                    loginform(
                        context, focus, emailController, passwordController),
                    loginButtonGroup(context, loginformKey),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

Widget loginform(
    BuildContext context,
    FocusNode focus,
    TextEditingController emailController,
    TextEditingController passwordController) {
  return Column(
    children: <Widget>[
      TextFormField(
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
          hintText: "Email",
        ),
        maxLines: 1,
        controller: emailController,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focus);
        },
        validator: (text) {
          if (text.length == 0) {
            return "Xin hãy nhập email ở đây";
          } else {
            return null;
          }
        },
      ),
      SizedBox(
        height: 12,
      ),
      TextFormField(
        focusNode: focus,
        style: TextStyle(
          fontSize: AppConstants.minFontSize,
          fontFamily: 'Roboto',
        ),
        decoration: InputDecoration(
          hintText: 'Mật khẩu',
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
        ),
        maxLines: 1,
        controller: passwordController,
        obscureText: true,
        validator: (text) {
          if (text.length == 0) {
            return "Xin hãy điền mật khẩu ở đây";
          } else {
            return null;
          }
        },
      ),
      SizedBox(
        height: 12,
      ),
    ],
  );
}

Widget loginButtonGroup(BuildContext context, GlobalKey<FormState> formKey) {
  return Column(
    children: <Widget>[
      GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0)), //this right here
                  child: DialogMessage(message: 'Quên mật khẩu'),
                );
              });
        },
        child: Container(
          width: double.infinity,
          child: Text(
            'Bạn quên mật khẩu?',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
      SizedBox(
        height: 24,
      ),
      PrimaryButton(
        onPressed: () async {
          if (formKey.currentState.validate()) {
            String email = emailController.text.trim();
            String pass = passwordController.text.trim();
            var response = await http.get('https://truck-api.azurewebsites.net/api/login?userId=' +
                email +
                '&password=' +
                pass);
            if (response.statusCode == HttpStatus.ok) {
              User user = User.fromJson(json.decode(response.body));
              if (user != null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => UserHomeScreen()),
                    (route) => false);
              }
            }else {
              showDialog(context: context, builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5.0)), //this right here
                  child: DialogMessage(message: 'Sai email hoặc mật khẩu!'),
                );
              });
            }
          }
        },
        text: 'Đăng Nhập',
      ),
      SizedBox(
        height: 12,
      ),
      PrimaryButton(
        onPressed: () {
          toSignUpScreen(context);
        },
        text: 'Tạo tài khoản mới',
        color: AppConstants.buttonColorSecRed,
      )
    ],
  );
}

Widget logo() {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppConstants.logoColor,
        ),
        child: Image.asset('assets/images/delivery-truck.png'),
      ),
      SizedBox(
        height: 12.0,
      ),
      Text(
        'DELTRU',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Oswald',
          fontSize: AppConstants.h4,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),
      )
    ],
  );
}
