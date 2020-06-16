import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final double requestDetailButtonGroupHeight = 75.0;

class RequestDetailScreen extends StatefulWidget {
  @override
  RequestDetailState createState() => RequestDetailState();
}

class RequestDetailState extends State<RequestDetailScreen> {
  BoxConstraints constraints = BoxConstraints();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Request Detail'),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                requestDetailButtonGroupHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                driverDetail(context),
                SizedBox(
                  height: 10.0,
                ),
                priceDetail(context),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                  child: Divider(
                    color: Colors.black,
                    thickness: 3.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                driverJourneyDetail(),                
                Spacer(),
                detailButtonGroup(),
              ],
            ),
          ),
        ));
  }
}

Widget driverDetail(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: requestDetailButtonGroupHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                color: Colors.blueAccent,
              ),
              child: Image.asset('assets/images/delivery-truck.png'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              children: <Widget>[
                Text(
                  'Nguyễn Trọng Tài',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                RatingBar(
                  initialRating: 2.5,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 25.0,
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
      )
    ],
  );
}

Widget priceDetail(BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: <Widget>[
              Text(
                'Negotiated Price:',
                style: TextStyle(fontSize: 20.0),
              ),
              Text('5,000,000 VNĐ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  )),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.note),
          SizedBox(
            width: 10.0,
          ),
          Text(
              'Đường khó đi, Công an nhiều nên giá hơi cao, \nmong and/chị thông cảm'),
        ],
      ),
    ],
  );
}

Widget driverJourneyDetail() {
  return Column(
    children: <Widget>[
      Text(
        "Driver's Journey:",
        style: TextStyle(fontSize: 18.0),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.adjust),
          Text(
            'Nguyễn Văn Phủ, Phường Đa Kao, Quận 1',
            style: TextStyle(),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.location_on),
          Text(
            'Nguyễn Văn Phủ, Phường Đa Kao, Quận 1',
            style: TextStyle(),
          ),
        ],
      ),
    ],
  );
}

Widget detailButtonGroup() {
  return Padding(
    padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: IconButton(
            icon: Icon(Icons.message),
            onPressed: null,
            iconSize: 20.0,
          ),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: IconButton(
            icon: Icon(Icons.phone),
            onPressed: null,
            iconSize: 20.0,
          ),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: IconButton(
            icon: Icon(Icons.check),
            onPressed: null,
            iconSize: 20.0,
          ),
        ),
      ],
    ),
  );
}
