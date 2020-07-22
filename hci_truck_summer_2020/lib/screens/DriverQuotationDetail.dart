import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Quotation.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/services/HttpService.dart';

final double requestDetailButtonGroupHeight = 75.0;

// ignore: must_be_immutable
class QuotationDetailScreen extends StatefulWidget {
  Request request;
  Quotation quotation;
  QuotationDetailScreen({this.request, this.quotation});

  @override
  QuotationDetailScreenState createState() => QuotationDetailScreenState();
}

class QuotationDetailScreenState extends State<QuotationDetailScreen> {
  BoxConstraints constraints = BoxConstraints();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: AppConstants.backgroundColor,
          title: Text(
            'Chi tiết báo giá',
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              color: Colors.grey[800],
              fontWeight: FontWeight.normal,
            ),
          ),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomSheet: detailButtonGroup(widget.request, widget.quotation),
        body: Container(
          padding: EdgeInsets.only(bottom: 150),
          child: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    requestDetailButtonGroupHeight,
                child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        driverDetail(context),
                        truckInfo(),
                        SizedBox(
                          height: 12.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.description, color: Colors.lime),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Đường khó đi, Công an nhiều nên giá hơi cao, mong and/chị thông cảm',
                                    softWrap: true,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        //priceDetail(context),
                        driverJourneyDetail(),
                        SizedBox(
                          height: 150.0,
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ));
  }
}

Widget driverDetail(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 12.0),
        child: Card(
          shadowColor: Colors.red,
          color: Color.fromRGBO(240, 58, 58, .8),
          margin: EdgeInsets.all(0.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar1.jpg'),
                  radius: 40,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nguyễn Trọng Tài',
                      style: TextStyle(
                          fontSize: AppConstants.medFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    RatingBar(
                      unratedColor: Colors.grey[400],
                      itemPadding: EdgeInsets.only(right: 4.0),
                      initialRating: 2.5,
                      minRating: 1,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 16.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      direction: Axis.horizontal,
                      onRatingUpdate: (null),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}

Widget priceDetail(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(24.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              //color: Color.fromRGBO(240, 58, 58, 1),
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Giá đề nghị',
                style: TextStyle(
                  fontSize: AppConstants.medFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Text('5,000,000 VNĐ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppConstants.medFontSize,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 12.0,
        ),
      ],
    ),
  );
}

Widget driverJourneyDetail() {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 0.0,
    child: Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Hành trình",
            style: TextStyle(
              fontSize: AppConstants.medFontSize,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.adjust,
                color: Colors.red,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'Nguyễn Văn Phủ, Phường Đa Kao',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'Nguyễn Văn Phủ, Phường Đa Kao',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget detailButtonGroup(Request requestw, Quotation quotation) {
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[400],
            offset: Offset(0, -3),
            blurRadius: 5.0,
            spreadRadius: .3,
          )
        ]),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/payment.png'),
              width: 48,
              height: 48,
            ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Giá đề nghị",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                    fontSize: AppConstants.medFontSize,
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text("4.000.000 VNĐ",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ))
              ],
            )
          ],
        ),
        SizedBox(
          height: 24.0,
        ),
        Row(
          children: <Widget>[
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppConstants.buttonColor,
              ),
              child: IconButton(
                icon: Icon(Icons.message),
                disabledColor: Colors.white,
                onPressed: null,
                iconSize: 20.0,
              ),
            ),
            Spacer(),
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: AppConstants.buttonColor,
              ),
              child: IconButton(
                icon: Icon(Icons.phone),
                onPressed: null,
                disabledColor: Colors.white,
                color: Colors.white,
                iconSize: 20.0,
              ),
            ),
            Spacer(),
            Container(
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.green,
              ),
              child: IconButton(
                icon: Icon(Icons.check),
                disabledColor: Colors.white,
                color: Colors.white,
                onPressed: () async {
                  requestw.driverId = quotation.driverId;
                  requestw.statusId = 2;
                  await HttpService.updateRequest(requestw);
                },
                iconSize: 20.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget truckInfo() {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 0.0,
    child: Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Thông tin xe",
            style: TextStyle(
              fontSize: AppConstants.medFontSize,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/driver-license.png'),
                width: 32,
                height: 32,
              ),
              SizedBox(
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Biển số",
                    style: TextStyle(
                      fontSize: AppConstants.minFontSize,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "93H-77706",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/scale.png'),
                width: 32,
                height: 32,
              ),
              SizedBox(
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Trọng tải",
                    style: TextStyle(
                      fontSize: AppConstants.minFontSize,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "5 Tấn",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/car-brand.png'),
                width: 32,
                height: 32,
              ),
              SizedBox(
                width: 12.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Thương hiệu",
                    style: TextStyle(
                      fontSize: AppConstants.minFontSize,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Huyndai",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}
