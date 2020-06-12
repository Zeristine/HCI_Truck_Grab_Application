import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Quotation.dart';

class UserListQuotaionScreenT extends StatefulWidget {
  @override
  UserListQuotaionScreenState createState() => UserListQuotaionScreenState();
}

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

class UserListQuotaionScreenState extends State<UserListQuotaionScreenT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title: Text(
      //     '#34568 Details',
      //     style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
      //   ),
      //   centerTitle: true,
      //   elevation: 0.0,
      // ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.0,
            automaticallyImplyLeading: true,
            expandedHeight: 250,
            floating: false,
            pinned: true,
            title: Text('Details'),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  EdgeInsetsDirectional.only(start: 24.0, bottom: 12.0),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 4.0),
              child: Text('Quotations',
              style: TextStyle(fontFamily: 'Poppins',fontSize: AppConstants.h5),),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(24.0,8.0, 24.0, 0),
                  child: Card(
                    margin: EdgeInsets.all(0),
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
                                    color: Colors.black,
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
                  ),
                );
              },
              childCount: quotations.length,
            ),
          ),
        ],
      ),
    );
  }
}

Widget listQuotaion() {
  return ListView.builder(
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
                        color: Colors.black,
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
