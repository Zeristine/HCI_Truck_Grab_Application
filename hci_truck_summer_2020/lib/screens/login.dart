import 'package:flutter/material.dart';
import 'package:truck/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final FocusNode focus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toSignUpScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  void login(BuildContext context) {
    print(emailController.text + ' ' + passwordController.text);
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
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration:
                        InputDecoration(labelText: 'Enter your username'),
                    maxLines: 1,
                    controller: emailController,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: focus,
                    decoration:
                        InputDecoration(labelText: 'Enter your password'),
                    maxLines: 1,
                    controller: passwordController,
                    obscureText: true,
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
                            login(context);
                          },
                          child: Text('Log in'),
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
