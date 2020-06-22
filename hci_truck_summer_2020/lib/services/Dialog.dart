import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/services/appUi.dart';

class DialogMessage extends StatelessWidget {
  final String message;

  DialogMessage({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: message),
            ),
            Spacer(),
            PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Đóng',
            )
          ],
        ),
      ),
    );
  }
}
