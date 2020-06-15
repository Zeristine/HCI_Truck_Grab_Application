import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputRequestDetailScreen extends StatefulWidget {
  @override
  InputRequestDetailScreenState createState() =>
      InputRequestDetailScreenState();
}

class InputRequestDetailScreenState extends State<InputRequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input detail'),
      ),
    );
  }
}
