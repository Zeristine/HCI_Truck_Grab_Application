import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/models/user.dart';
import 'package:truck/screens/home.dart';
import 'package:truck/screens/login.dart';
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
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: formKey,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/background.jpg'),
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: usernameController,
                    decoration:
                        InputDecoration(labelText: 'Enter your username'),
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
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Enter your email'),
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
                    controller: passwordController,
                    decoration:
                        InputDecoration(labelText: 'Enter your password'),
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
                    controller: repasswordController,
                    decoration:
                        InputDecoration(labelText: 'Enter your password again'),
                    maxLines: 1,
                    obscureText: true,
                    focusNode: repasswordFocus,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: (MediaQuery.of(context).size.width) * 0.4,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            toLoginScreen(context);
                          },
                          child: Text('Back to Sign in'),
                          color: Colors.brown[200],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width) * 0.4,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              print("Signing up..");
                            } else {
                              print("Invalidate!!!");
                            }
                          },
                          child: Text('Sign up'),
                          color: Colors.blue[200],
                        ),
                      )
                    ],
                  )
                ])),
          )),
    );
  }
}
