import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationScreen extends StatefulWidget {
  @override
  UserLocationState createState() => UserLocationState();
}

class UserLocationState extends State<UserLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppConstants.backgroundColor,
        title: Center(
          child: Text(
            'Tạo đơn hàng',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
          margin: const EdgeInsets.only(left: 24, right: 24, top: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 400,
                  
                  //child: Image.asset('images/mapdemo.png'),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  
                  child: infomation(),
                  height: 220,
                )
              ],
            ),
          )
          // child: <Widget>{
          //  _Googlemap(context),

          ),
    );
  }

  // Widget _Googlemap (BuildContext context){
  //   return Container (
  //     height: MediaQuery.of(context).size.height,
  //     width: MediaQuery.of(context).size.width,
  //     child: googlemap(
  //       mapType:
  //     ),

  //   )
  // }
  Widget infomation() {
    return Column(
       
      children: [
        Row(
          children: [
            Icon(
              Icons.my_location,
              size: AppConstants.h4,
            ),
            SizedBox(width: 10),
            Text('Nơi nhận hàng',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppConstants.h5)),
          ],
        ),
      Container(
          width: 320.0,
          margin: const EdgeInsets.only(left: 32, top: 8),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide:
                    BorderSide(color: AppConstants.linkColor, width: 2.0),
              ),
            ),
            maxLines: 1,
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: AppConstants.h4,
            ),
           SizedBox(width: 10),
            Text(
              'Nơi giao hàng',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: AppConstants.h5),
            ),
          ],
        ),
          Container(
          width: 320.0,
          margin: const EdgeInsets.only(left: 32, top: 8),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide:
                    BorderSide(color: AppConstants.linkColor, width: 2.0),
              ),
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
