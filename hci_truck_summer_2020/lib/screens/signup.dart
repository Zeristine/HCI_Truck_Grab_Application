import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/login.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
void toLoginScreen(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
