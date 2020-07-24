import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Place.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/screens/userCreateRequest.dart';
import 'package:truck/screens/userRequestDetail.dart';
import 'package:truck/services/HttpService.dart';

class UserListRequestScreen extends StatefulWidget {
  final int status;
  UserListRequestScreen(this.status);
  @override
  UserListRequestScreenState createState() => UserListRequestScreenState();
}

class UserListRequestScreenState extends State<UserListRequestScreen>
    with AutomaticKeepAliveClientMixin {
  List<Request> requests;

  @override
  void initState() {
    getList();
    super.initState();
  }

  void getList() async {
    requests = List<Request>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await HttpService.getRequest(prefs.getString('userId'), widget.status)
        .then((value) {
      setState(() {
        requests = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return requests != null || requests.length > 0
        ? Scaffold(
            backgroundColor: AppConstants.backgroundColor,
            body: listRequest(requests),
          )
        : CircularProgressIndicator();
  }

  @override
  bool get wantKeepAlive => true;
}

Widget listRequest(List<Request> requests) {
  return requests.length != null
      ? ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
          itemCount: requests.length,
          itemBuilder: (BuildContext context, int index) {
            String ownerAddress =
                requests[index].commodityOwner.address.streetName +
                    ", " +
                    requests[index].commodityOwner.address.ward +
                    ", " +
                    requests[index].commodityOwner.address.district +
                    ", " +
                    requests[index].commodityOwner.address.province;
            String reciverAddress = requests[index].reciver.address.streetName +
                ", " +
                requests[index].reciver.address.ward +
                ", " +
                requests[index].reciver.address.district +
                ", " +
                requests[index].reciver.address.province;

            return Hero(
              tag: 'background' + requests[index].requestId.toString(),
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
                      return UserRequestDetail(
                          requests[index].requestId + 1, requests[index]);
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
                                          requests[index].statusId == 1
                                              ? Text(
                                                  requests[index]
                                                          .quotations
                                                          .length
                                                          .toString() +
                                                      ' báo giá',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : SizedBox(),
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
