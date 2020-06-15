import 'dart:async';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/inputRequestDetail.dart';
import 'package:truck/services/appUi.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocationScreen extends StatefulWidget {
  @override
  UserLocationState createState() => UserLocationState();
}

const kGoogleApiKey = "AIzaSyDn-MgBWF7eJNJGTyndXy4M0QdUViPGngk";

class UserLocationState extends State<UserLocationScreen> {
  GoogleMapController mapController;

  LatLng center;

  LatLng _targetLatLng;

  String _targetDetails;

  Position _myPosition;

  bool visibleButton = false;

  StreamSubscription<Position> _positionStream;

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  TextEditingController _textEditingController;

  String myAdress;

  PointLatLng _begin;

  PointLatLng _end;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  List<LatLng> routeCoords = [];

  CameraPosition cameraPosition;

  void getPoints(PointLatLng begin, PointLatLng end) async {
    PolylinePoints points = PolylinePoints();
    PolylineResult result = await points.getRouteBetweenCoordinates(
      kGoogleApiKey,
      begin,
      end,
    );
    setState(() {
      routeCoords = new List();
      for (var item in result.points) {
        routeCoords.add(LatLng(item.latitude, item.longitude));
      }
      Polyline polyline = Polyline(
        polylineId: PolylineId('route1'),
        visible: true,
        points: routeCoords,
        color: Colors.blue,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap,
      );

      _polylines[polyline.polylineId] = polyline;
    });
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void getPosition() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    if (geolocationStatus == GeolocationStatus.granted &&
        (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile)) {
      _myPosition = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

      final coordinates =
          new Coordinates(_myPosition.latitude, _myPosition.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      myAdress = first.addressLine;

      setState(() {
        center = LatLng(_myPosition.latitude - 0.005, _myPosition.longitude);
        _begin = PointLatLng(_myPosition.latitude, _myPosition.longitude);
        cameraPosition = CameraPosition(
          target: center,
          zoom: 15.0,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosition();
    _textEditingController = TextEditingController(text: "");
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _positionStream = Geolocator()
        .getPositionStream(locationOptions)
        .listen((Position position) {
      setState(() {
        _myPosition = position;
        center = LatLng(_myPosition.latitude, _myPosition.longitude);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
    _textEditingController.dispose();

  }

  void _onMapCreated(GoogleMapController mapController) {
    this.mapController = mapController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: center != null
          ? Stack(
              children: <Widget>[
                GoogleMap(
                  padding: EdgeInsets.only(bottom: 200.0),
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: cameraPosition == null
                      ? CameraPosition(target: LatLng(0, 0))
                      : cameraPosition,
                  polylines: Set.of(_polylines.values),
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: Set.of(markers.values),
                  // circles: Set.from([
                  //   Circle(
                  //     circleId: CircleId("myCircle"),
                  //     radius: 50.0,
                  //     center: center,
                  //     fillColor: Colors.blue.withAlpha(70),
                  //     strokeColor: Colors.blue,
                  //     strokeWidth: 0,
                  //   ),
                  // ]),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(24.0),
                        height: 224,
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
                      Visibility(
                        child: Container(
                            margin: EdgeInsets.only(top: 8.0),
                            child: PrimaryButton(
                              onPressed: () {
                                Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (context, a, b) {
                                  return InputRequestDetailScreen();
                                }));
                              },
                              text: 'Submit',
                            )),
                        visible: visibleButton,
                      )
                    ],
                  ),
                ),
              ],
            )
          : null,
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
            Text('Pick up address',
                style: TextStyle(
                  fontSize: AppConstants.minFontSize,
                  fontFamily: 'Poppins',
                )),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 32, top: 8),
          child: TextFormField(
            initialValue: myAdress,
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
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
              "Consignee's adress",
              style: TextStyle(
                fontSize: AppConstants.minFontSize,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 32, top: 8),
          child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: _textEditingController,
              style: TextStyle(
                fontSize: 12.0,
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
              onTap: () async {
                Prediction p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: kGoogleApiKey,
                    mode: Mode.overlay, // Mode.fullscreen
                    language: "vi",
                    components: [new Component(Component.country, "vn")]);
                getPredictContent(p, context);
              }),
        ),
      ],
    );
  }

  void getPredictContent(Prediction p, BuildContext context) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      setState(() {
        _textEditingController =
            TextEditingController(text: detail.result.formattedAddress);

        _targetLatLng = LatLng(detail.result.geometry.location.lat,
            detail.result.geometry.location.lng);
        _targetDetails = detail.result.formattedAddress.toString();

        _end = PointLatLng(detail.result.geometry.location.lat,
            detail.result.geometry.location.lng);

        // distance
        Geolocator()
            .distanceBetween(center.latitude, center.longitude,
                _targetLatLng.latitude, _targetLatLng.longitude)
            .then((value) => print(value));

        // get list coords
        getPoints(_begin, _end);

        setState(() {
          Marker marker = Marker(
            markerId: MarkerId('target1'),
            position: _targetLatLng,
            infoWindow: InfoWindow(title: _targetDetails),
          );
          markers[marker.markerId] = marker;

          var sLat, sLng, nLat, nLng;
          if (_begin.latitude <= _end.latitude) {
            sLat = _begin.latitude;
            nLat = _end.latitude;
          } else {
            sLat = _end.latitude;
            nLat = _begin.latitude;
          }

          if (_begin.longitude <= _end.longitude) {
            sLng = _begin.longitude;
            nLng = _end.longitude;
          } else {
            sLng = _end.longitude;
            nLng = _begin.longitude;
          }

          LatLngBounds bounds = LatLngBounds(
              southwest: LatLng(sLat, sLng), northeast: LatLng(nLat, nLng));
          mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 24));
        });

        FocusScope.of(context).unfocus();
        visibleButton = true;
      });
    }
  }
}
