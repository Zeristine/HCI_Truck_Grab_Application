import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/home.dart';
import 'package:truck/screens/login.dart';
import 'package:truck/services/auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final FocusNode focus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toLoginScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void signUp(BuildContext context) async{
    await FirebaseAuthService.signUp(emailController.text, passwordController.text).then((value) {
      if(value == null){

      }else{
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            margin: EdgeInsets.all(10),
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
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'Enter your username'),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'Enter your password'),
                    maxLines: 1,
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
                            print("Signing up..");
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
