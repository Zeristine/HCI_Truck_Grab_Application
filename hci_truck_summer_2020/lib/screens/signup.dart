import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/user.dart';
import 'package:truck/screens/userHome.dart';
import 'package:truck/services/appUi.dart';
import 'package:truck/services/auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode repasswordFocus = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  void toLoginScreen(BuildContext context) {
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => LoginScreen()));
    Navigator.pop(context);
  }

  void signUp(BuildContext context) async {
    if (emailController.text.trim() == repasswordController.text.trim()) {
      await FirebaseAuthService.signUp(
              emailController.text, passwordController.text)
          .then((value) {
        if (value == null) {
        } else {
          final databaseReference = FirebaseDatabase.instance.reference();
          User user = User(value.uid, usernameController.text,
              emailController.text, passwordController.text);
          databaseReference
              .child("Users")
              .child(value.uid)
              .set(user)
              .then((value) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserHomeScreen()));
          });
        }
      });
    }
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
          'Create Account',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Form(
            key: formKey,
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
                  height: 24,
                ),
                signUpButtonGroup(
                    formKey, context, passwordController, repasswordController),
              ],
            ))),
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
          hintText: "Username",
        ),
        controller: usernameController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        maxLines: 1,
        validator: (text) {
          if (text.length == 0) {
            return "Please enter your Username";
          } else if (text.length < 4) {
            return "The Username has at least 5 characters";
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
          hintText: "Your Email",
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        maxLines: 1,
        focusNode: emailFocus,
        validator: (text) {
          if (!EmailValidator.validate(text)) {
            return "Incorrect email";
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
          hintText: "Your Password",
        ),
        controller: passwordController,
        maxLines: 1,
        obscureText: true,
        focusNode: passwordFocus,
        validator: (text) {
          if (text.length == 0) {
            return "Please enter your password..";
          } else if (text.length < 8) {
            return "The password has at least 8 characters";
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
          hintText: "Enter your password again",
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
    GlobalKey<FormState> formKey,
    BuildContext context,
    TextEditingController passwordController,
    TextEditingController repasswordController) {
  return PrimaryButton(
    onPressed: () {
      if (formKey.currentState.validate()) {
        if (passwordController.text.trim() == repasswordController.text.trim())
          Navigator.pushNamedAndRemoveUntil(
              context, '/userLocation', (route) => false);
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
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  "Your Passwords aren't matched with each other!"),
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
      }
    },
    text: 'Create',
  );
}
