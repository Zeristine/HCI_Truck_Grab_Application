import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/screens/DriverQuotationDetail.dart';

class RequestListDriverScreen extends StatefulWidget {
  @override
  RequestListDriverSate createState() => RequestListDriverSate();
}

class RequestListDriverSate extends State<RequestListDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Colors.red,
      ),
         
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            inProgressRequestList(),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    ));
  }
}
final tab = new TabBar(tabs: <Tab>[
  new Tab(icon: new Icon(Icons.arrow_forward)),
  new Tab(icon: new Icon(Icons.arrow_downward)),
  new Tab(icon: new Icon(Icons.arrow_back)),
]);
Widget inProgressRequestList() {
  return Container(
      child: Column(
    children: <Widget>[
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[

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
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                elevation: 0.0,
                child: InkWell(
                  onTap: null,
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
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                   children: <Widget>[
                                  CircleAvatar(
                                backgroundImage: AssetImage('assets/images/avatar4.jpg'),
                                backgroundColor: Colors.lightGreen,
                                radius: 28.0,
                              ),
                               SizedBox(
                                width: 8,
                                    ),
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                  '#456' + index.toString() + '  - '+' Sat Thep ',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: AppConstants.minFontSize,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Nguyen Van Loi",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: AppConstants.minFontSize,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                                  ],
                               ),
                                
                               
                               
                                SizedBox(
                                  height: 8,
                                ),
                                     ],
                                       ),  
                              
                                
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.my_location,
                                      color: Colors.purple,
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
                                          color: Colors.black,
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
                                        color: Colors.blue),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "585/5 Nguyễn Thị Thập, Phường 3, Quận 7, TP.HCM",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
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
