import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:truck/constants/appConstans.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationScreen extends StatefulWidget {
  @override
  UserLocationState createState() => UserLocationState();
}

class UserLocationState extends State<UserLocationScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(10.739274, 106.704211);

  void _onMapCreated(GoogleMapController mapController) {
    this.mapController = mapController;
  }

  BitmapDescriptor myLocationMarker;

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
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            zoomControlsEnabled: false,
            markers: Set.of([
              Marker(
                markerId: MarkerId('my_location'),
                position: _center,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
              ),
            ]),
            circles: Set.from([
              Circle(
                circleId: CircleId("myCircle"),
                radius: 50.0,
                center: _center,
                fillColor: Colors.blue.withAlpha(70),
                strokeColor: Colors.blue,
                strokeWidth: 0,
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(24.0),
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: infomation(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infomation() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.my_location,
              size: AppConstants.h5,
              color: Colors.blue,
            ),
            SizedBox(width: 8.0),
            Text('Nơi nhận hàng',
                style: TextStyle(fontSize: AppConstants.minFontSize)),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 32, top: 8),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Color.fromRGBO(132, 212, 255, 1),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                    color: Color.fromRGBO(132, 212, 255, 1), width: 2.0),
              ),
            ),
            maxLines: 1,
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: AppConstants.h5,
              color: Colors.red,
            ),
            SizedBox(width: 8.0),
            Text(
              'Nơi giao hàng',
              style: TextStyle(fontSize: AppConstants.minFontSize),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 32, top: 8),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Color.fromRGBO(132, 212, 255, 1),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                    color: Color.fromRGBO(132, 212, 255, 1), width: 2.0),
              ),
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
