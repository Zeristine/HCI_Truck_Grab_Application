import 'package:flutter/material.dart';
import 'package:truck/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  void toSignUpScreen(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
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
                            print("Logging in..");
                          },
                          child: Text('Log in'),
                          color: Colors.brown[200],
                        ),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width) * 0.4,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            toSignUpScreen(context);
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
