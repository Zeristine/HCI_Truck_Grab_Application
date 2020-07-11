import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/DriverQuotationDetail.dart';

class RequestListTruckScreen extends StatefulWidget {
  @override
  RequestListTruckSate createState() => RequestListTruckSate();
}

class RequestListTruckSate extends State<RequestListTruckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            inProgressRequestList(),
            SizedBox(
              height: 10.0,
            ),
            availableRequestList(context),
          ],
        ),
      ),
    ));
  }
}

Widget availableRequestList(BuildContext context) {
  return Container(
      child: Column(
    children: <Widget>[
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.arrow_forward_ios),
              Text(
                'Đơn hàng có sẵn:',
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          )),
      SizedBox(
        height: 10.0,
      ),
      ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 0),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Hero(
              tag: 'available' + index.toString(),
              child: Card(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: AppConstants.buttonColor,
                elevation: 0.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        PageRouteBuilder(pageBuilder: (context, a, b) {
                      return QuotationDetailScreen();
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
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
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.my_location,
                                      color: Color.fromRGBO(207, 8, 108, 1),
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
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
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
                                    Icon(Icons.location_on,
                                        color: Color.fromRGBO(207, 183, 8, 1)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "585/5 Nguyễn Thị Thập, Phường 3, Quận 7, TP.HCM",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
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
                                          8.0, 4.0, 8.0, 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '5 quotations',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.add,
                                      color: Colors.yellow,
                                      size: 16.0,
                                    ),
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
          }),
    ],
  ));
}

Widget inProgressRequestList() {
  return Container(
      child: Column(
    children: <Widget>[
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.arrow_forward_ios),
              Text(
                'Các đơn hàng đang thực hiện:',
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          )),
      SizedBox(
        height: 10.0,
      ),
      ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 0),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Hero(
              tag: 'inprogress' + index.toString(),
              child: Card(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: AppConstants.buttonColor,
                elevation: 0.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuotationDetailScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
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
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.my_location,
                                      color: Color.fromRGBO(207, 8, 108, 1),
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
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
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
                                    Icon(Icons.location_on,
                                        color: Color.fromRGBO(207, 183, 8, 1)),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "585/5 Nguyễn Thị Thập, Phường 3, Quận 7, TP.HCM",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
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
                                          8.0, 4.0, 8.0, 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '5 quotations',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.fiber_manual_record,
                                      color: Colors.green[300],
                                      size: 16.0,
                                    ),
                                    Text(
                                      'In Progress',
                                      style: TextStyle(
                                        color: Colors.white,
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
          })
    ],
  ));
}
