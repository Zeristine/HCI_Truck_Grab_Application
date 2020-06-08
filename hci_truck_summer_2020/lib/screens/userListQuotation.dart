import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Quotation.dart';

class UserListQuotaionScreen extends StatefulWidget {
  @override
  UserListQuotaionScreenState createState() => UserListQuotaionScreenState();
}

ScrollController _scrollController;
double headerHeight = 20.0;
Widget headerWidget = header();
double headerWidgetHeight = 125.0;

List<Quotation> quotations = <Quotation>[
  new Quotation(
      name: 'Nguyen Van Loi',
      img: 'assets/images/avatar1.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Nguyen Van Tan',
      img: 'assets/images/avatar2.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Dang Van Hung',
      img: 'assets/images/avatar3.jpg',
      price: '5.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020'),
  new Quotation(
      name: 'Le Thanh Hai',
      img: 'assets/images/avatar4.jpg',
      price: '4.500.000 VND',
      date: '21/3/2020')
];

class UserListQuotaionScreenState extends State<UserListQuotaionScreen> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'background',
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            '#34568 Details',
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(0.0),
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(.0),
              ),
              //Color.fromRGBO(236, 126, 114, 1)
              color: Colors.blue,
              child: InkWell(
                onTap: () {},
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  height: headerWidgetHeight,
                  padding: EdgeInsets.all(12),
                  child: SingleChildScrollView(child: headerWidget),
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Quotations',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: AppConstants.h5,
                ),
              ),
            ),
            Expanded(child: listQuotaion()),
            SizedBox(
              height: 48.0,
            )
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
            _scrollController.position.minScrollExtent + 150.0 &&
        !_scrollController.position.outOfRange) {
      setState(() {
        headerWidgetHeight = 125.0;
        //headerWidget = header();
      });
    }
    // if (_scrollController.position.userScrollDirection.index <=
    //     ScrollDirection.forward.index - 10) {
    //   headerWidget = header();
    // }
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        //headerWidget = null;
        headerWidgetHeight = 0.0;
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  Widget listQuotaion() {
    return ListView.builder(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
      itemCount: quotations.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          //Color.fromRGBO(236, 126, 114, 1)
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          quotations[index].img,
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
                        quotations[index].name,
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
                        quotations[index].price,
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
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            quotations[index].date,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 24.0,
                          ),
                          Icon(
                            Icons.timer,
                            color: Colors.grey,
                            size: 12.0,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            '5 hours',
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
    );
  }
}

Widget header() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Flexible(
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.my_location,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      "415/25 Trường Chinh, Phường 14, Quận Tân Bình, TP.HCM",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      "415/25 Trường Chinh, Phường 14, Quận Tân Bình, TP.HCM",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
