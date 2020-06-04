import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/services/auth.dart';
import 'package:truck/screens/login.dart';

class AuthenticateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: LoginScreen(),
    );
  }
}
