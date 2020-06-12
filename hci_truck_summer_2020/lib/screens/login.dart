import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/signup.dart';
import 'package:truck/screens/userListQuotation.dart';
import 'package:truck/services/appUi.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> formKey = GlobalKey();

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
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                    loginButtonGroup(context, formKey),
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
            return "Please enter your Email";
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
          //labelText: 'PASSWORD',
          hintText: 'Password',
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
            return "Please enter your Password";
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
                          PrimaryButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Close',
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
      PrimaryButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/userLocation', (route) => false);
          }
        },
        text: 'Login',
      ),
      SizedBox(
        height: 12,
      ),
      PrimaryButton(
        onPressed: () {
          toSignUpScreen(context);
        },
        text: 'Create an Account',
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
