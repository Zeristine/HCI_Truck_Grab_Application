import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Quotation.dart';
import 'package:truck/models/Request.dart';
import 'package:truck/screens/DriverQuotationDetail.dart';
import 'package:truck/screens/UserRequestInfo.dart';
import 'package:truck/services/appUi.dart';
import 'package:truck/services/marquee.dart';

class UserRequestDetail extends StatefulWidget {
  final int heroIndex;
  final Request request;
  UserRequestDetail(this.heroIndex, this.request);
  @override
  UserRequestDetailState createState() =>
      UserRequestDetailState(heroIndex, request);
}

ScrollController _scrollController;
double headerHeight = 20.0;
double headerWidgetHeight = 160.0;

class UserRequestDetailState extends State<UserRequestDetail> {
  int heroIndex;
  Request request;
  var numformat = NumberFormat("#,###,###");
  UserRequestDetailState(this.heroIndex, this.request);
  Widget headerWidget;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'background' + request.requestId.toString(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Chi tiết đơn hàng',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
              elevation: 3.0,
              shadowColor: Color(0xff8d08cf),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color(0xff8d08cf),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserRequestInfoScreen(request),
                      ));
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  height: headerWidgetHeight,
                  padding: EdgeInsets.all(12),
                  child: SingleChildScrollView(child: headerWidget),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 12.0),
              padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: Text(
                request.statusId == 1
                    ? 'Báo giá'
                    : request.statusId == 2
                        ? 'Chờ lấy hàng'
                        : request.statusId == 3
                            ? 'Đang vận chuyển'
                            : request.statusId == 4 ? 'Hoàn thành' : 'Đã hủy',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: AppConstants.medFontSize,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: request.statusId == 1
                    ? listQuotaion(request)
                    : request.statusId == 2 ? transporting() : transporting(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _scrollListener() {
    // if (_scrollController.offset >=
    //         _scrollController.position.maxScrollExtent &&
    //     !_scrollController.position.outOfRange) {
    //   setState(() {
    //     print("reach the bottom");
    //   });
    // }
    if (_scrollController.offset <
            _scrollController.position.minScrollExtent + 160.0 &&
        !_scrollController.position.outOfRange) {
      setState(() {
        headerWidgetHeight = 160.0;
        //headerWidget = header();
      });
    }
    // if (_scrollController.position.userScrollDirection.index <=
    //     ScrollDirection.forward.index - 10) {
    //   headerWidget = header();
    // }
    if (request.quotations.length > 7) {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          //headerWidget = null;
          headerWidgetHeight = 0.0;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    headerWidget = header(request);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget listQuotaion(Request request) {
    return request.quotations.length > 0
        ? ListView.builder(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
            itemCount: request.quotations.length,
            itemBuilder: (BuildContext context, int index) {
              Quotation quotaion = request.quotations[index];
              return Card(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                elevation: 4.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QuotationDetailScreen(
                          request: request,
                          quotation: quotaion,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ClipOval(
                              child: quotaion.driver.imagePath != null
                                  ? Image.network(
                                      quotaion.driver.imagePath,
                                      height: 64,
                                      width: 64,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/no-avatar.png",
                                      height: 64,
                                      width: 64,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 12.0,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12.0,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 12.0,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_half,
                                  size: 12.0,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_border,
                                  size: 12.0,
                                  color: Colors.yellow,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              quotaion.driver.fullName,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              numformat.format(quotaion.price) + " VND",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                // Icon(
                                //   Icons.calendar_today,
                                //   color: Colors.grey,
                                //   size: 12.0,
                                // ),
                                // SizedBox(
                                //   width: 4.0,
                                // ),
                                // Text(
                                //   quotaion.date,
                                //   style: TextStyle(
                                //     color: Colors.grey,
                                //     fontSize: 12.0,
                                //     fontFamily: 'Poppins',
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: 24.0,
                                // ),
                                Icon(
                                  Icons.timer,
                                  color: Colors.grey,
                                  size: 12.0,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  quotaion.date
                                          .difference(DateTime.now())
                                          .inDays
                                          .toString() +
                                      ' ngày trước',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.0),
            child: Text(
              "Chưa có báo giá",
              textAlign: TextAlign.center,
            ));
  }
}

Widget transporting() {
  return Container(
    margin: EdgeInsets.fromLTRB(24, 12, 24, 24),
    child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    billRow("Giá vận chuyển", "3.000.000", FontWeight.normal),
                    SizedBox(
                      height: 12,
                    ),
                    billRow("Mã giảm giá", "2%", FontWeight.normal),
                    Divider(),
                    billRow("Tổng cộng", "2.800.000", FontWeight.w600),
                    SizedBox(
                      height: 12,
                    ),
                    billRow("Thanh toán bằng", "Tiền mặt", FontWeight.normal),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        DriverCard(
          titleColor: Colors.grey[800],
        ),
      ],
    ),
  );
}

Widget billRow(String text1, String text2, FontWeight fontWeight) {
  return Row(
    children: <Widget>[
      Text(
        text1,
        style: TextStyle(
            fontSize: AppConstants.minFontSize, fontWeight: fontWeight),
      ),
      Spacer(),
      Text(
        text2,
        style: TextStyle(
            fontSize: AppConstants.minFontSize, fontWeight: fontWeight),
      ),
    ],
  );
}

Widget header(Request request) {
  String address1 = request.commodityOwner.address.streetName.toString() +
      ", " +
      request.commodityOwner.address.places[0].name +
      ", " +
      request.commodityOwner.address.places[1].name +
      ", " +
      request.commodityOwner.address.places[2].name;
  String address2 = request.reciver.address.streetName.toString() +
      ", " +
      request.reciver.address.places[0].name +
      ", " +
      request.reciver.address.places[1].name +
      ", " +
      request.reciver.address.places[2].name;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Flexible(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "#" +
                    request.requestId.toString() +
                    " - " +
                    request.commodityName,
                style: TextStyle(
                  fontSize: AppConstants.medFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.my_location,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Flexible(
                    child: Marquee(
                      direction: Axis.horizontal,
                      //textDirection: TextDirection.ltr,
                      //directionMarguee: DirectionMarguee.TwoDirection,
                      child: Text(
                        address1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Marquee(
                      direction: Axis.horizontal,
                      //textDirection: TextDirection.ltr,
                      //directionMarguee: DirectionMarguee.TwoDirection,
                      child: Text(
                        address2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
