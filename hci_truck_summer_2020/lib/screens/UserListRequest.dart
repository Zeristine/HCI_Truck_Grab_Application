import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/userCreateRequest.dart';
import 'package:truck/screens/userRequestDetail.dart';

class UserListRequestScreen extends StatefulWidget {
  @override
  UserListRequestScreenState createState() => UserListRequestScreenState();
}

class UserListRequestScreenState extends State<UserListRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserCreateRequestScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: AppConstants.backgroundColor,
      body: listRequest(),
    );
  }
}

Widget listRequest() {
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
      return Hero(
        tag: 'background' + index.toString(),
        child: Card(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.white,
          elevation: 1,
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  PageRouteBuilder(pageBuilder: (context, a, b) {
                return UserRequestDetail(index);
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
                            '#4567' + index.toString(),
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
                                  "415/25 Trường Chinh, Phường 14, Quận Tân Bình, TP.HCM",
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
                                  "585/5 Nguyễn Thị Thập, Phường 3, Quận 7, TP.HCM",
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
                                padding:
                                    EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.green[700],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '5 báo giá',
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
                                color: Colors.yellow,
                                size: 16.0,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                'Chờ báo giá',
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
  );
}
