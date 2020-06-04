import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/screens/error.dart';
import 'package:truck/screens/home.dart';
import 'package:truck/services/auth.dart';
import 'package:truck/screens/login.dart';

class AuthenticateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: FutureBuilder(
        future: FirebaseAuthService.checkLoggedUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }else{
            return ErrorScreen();
          }
        },
      ),
    );
  }
}
