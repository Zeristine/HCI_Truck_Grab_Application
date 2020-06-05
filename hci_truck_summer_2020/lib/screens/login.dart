import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/signup.dart';

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
  final FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromRGBO(243, 244, 246, 1),
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.all(AppConstants.edgePadding),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  logo(),
                  SizedBox(
                    height: 40,
                  ),
                  loginform(
                      context, focus, emailController, passwordController),
                  loginButtonGroup(context),
                ])),
          )),
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
          hintText: "EMAIL",
        ),
        maxLines: 1,
        controller: emailController,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focus);
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
          //labelText: 'PASSWORD',
          hintText: 'PASSWORD',
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
      ),
      SizedBox(
        height: 12,
      ),
    ],
  );
}

Widget loginButtonGroup(BuildContext context) {
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
                  child: Container(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'What do you want to remember?'),
                          ),
                          SizedBox(
                            width: 320.0,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: AppConstants.buttonColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Container(
          width: double.infinity,
          child: Text(
            'Forgot your password?',
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
      SizedBox(
        width: double.infinity,
        height: 52.0,
        child: RaisedButton(
          onPressed: () {
            login(context);
          },
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: AppConstants.buttonColor),
          ),
          child: Text(
            'SIGN IN',
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              color: Colors.white,
            ),
          ),
          color: Color.fromRGBO(8, 93, 207, 1),
        ),
      ),
      SizedBox(
        height: AppConstants.componantSpacing,
      ),
      SizedBox(
        width: double.infinity,
        height: 52.0,
        child: RaisedButton(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: AppConstants.buttonColor, width: 2.0),
          ),
          onPressed: () {
            toSignUpScreen(context);
          },
          child: Text(
            'SIGN UP',
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              color: AppConstants.buttonColor,
            ),
          ),
          color: Colors.white,
        ),
      ),
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
          color: AppConstants.buttonColor,
        ),
        child: Icon(
          Icons.local_shipping,
          size: 80,
          color: Colors.white,
        ),
      ),
      SizedBox(
        height: 12,
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
