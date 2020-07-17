import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Place.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/screens/DriverRequestDetail.dart';
import 'package:http/http.dart' as http;

class RequestListDriverScreen extends StatefulWidget {
  @override
  RequestListDriverSate createState() => RequestListDriverSate();
}

class RequestListDriverSate extends State<RequestListDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        body: Container(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: TabBar(labelColor: Colors.grey[800], tabs: [
                Tab(
                  text: "Đơn gợi ý",
                ),
                Tab(
                  text: "Đang thực hiện",
                ),
                Tab(
                  text: "Đã hoàn thành",
                ),
              ]),
              body: TabBarView(children: [
                RequestListDriverType(1),
                RequestListDriverType(2),
                RequestListDriverType(3),
              ]),
            ),
          ),
        ));
  }
}

class RequestListDriverType extends StatefulWidget {
  final int status;
  RequestListDriverType(this.status);
  @override
  RequestListDriverTypeState createState() => RequestListDriverTypeState();
}

class RequestListDriverTypeState extends State<RequestListDriverType> {
  List<Request> requests;

  void getList() async {
    requests = List<Request>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId');
    var response = await http.get(
        'https://truck-api.azurewebsites.net/api/users/' +
            userId +
            '/requests?isDriver=true');
    setState(() {
      if (response.statusCode == HttpStatus.ok) {
        var jsonRe = json.decode(response.body);
        if (jsonRe != null) {
          var list = jsonRe as List;
          if (list.length > 0) {
            requests = list.map((e) => Request.fromJson(e)).toList();
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return requests != null || requests.length > 0
        ? Scaffold(
            backgroundColor: AppConstants.backgroundColor,
            body: requestList(requests, widget.status),
          )
        : CircularProgressIndicator();
  }
}

Widget requestList(List<Request> requests, int status) {
  return requests != null
      ? ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
          itemCount: requests.length,
          itemBuilder: (BuildContext context, int index) {
            List<Place> ownerPlaces =
                requests[index].commodityOwner.address.places;
            List<Place> reciverPlaces = requests[index].reciver.address.places;
            String ownerAddress =
                requests[index].commodityOwner.address.streetName +
                    ", " +
                    ownerPlaces[0].name +
                    ", " +
                    ownerPlaces[1].name +
                    ", " +
                    ownerPlaces[2].name;
            String reciverAddress = requests[index].reciver.address.streetName +
                ", " +
                reciverPlaces[0].name +
                ", " +
                reciverPlaces[1].name +
                ", " +
                reciverPlaces[2].name;
            return Hero(
              tag: 'background' + index.toString(),
              child: Card(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: Colors.white,
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        PageRouteBuilder(pageBuilder: (context, a, b) {
                      return DriverRequestDetailScreen(requests[index]);
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '#' +
                                      requests[index].requestId.toString() +
                                      " - " +
                                      requests[index].commodityName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: AppConstants.minFontSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.my_location,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        ownerAddress,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.location_on, color: Colors.blue),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        reciverAddress,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          12.0, 4.0, 12.0, 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: Colors.green[700],
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            requests[index]
                                                    .quotations
                                                    .length
                                                    .toString() +
                                                ' báo giá',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.fiber_manual_record,
                                      color:
                                          Color(requests[index].status.color),
                                      size: 16.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      requests[index].status.value.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
      : Container();
}
