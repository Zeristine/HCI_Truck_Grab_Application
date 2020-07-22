import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/models/Address.dart';
import 'package:truck/screens/inputAdress.dart';
import 'package:truck/services/appUi.dart';

class CreateDriverJourneyScreen extends StatefulWidget {
  CreateDriverJourneyScreen({Key key}) : super(key: key);

  @override
  _CreateDriverJourneyScreenState createState() =>
      _CreateDriverJourneyScreenState();
}

class _CreateDriverJourneyScreenState extends State<CreateDriverJourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        // backgroundColor: Color.fromRGBO(240, 58, 58, 1),
        title: Text(
          "Tạo lộ trình",
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Địa điểm khởi hành',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            textField(context, 'Nhấn để chọn', Icons.navigate_next, () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddressScreen(),
                ),
              ) as Address;
            }, (value) => null, null, true, null, 1),
            SizedBox(
              height: 24,
            ),
            Text(
              'Địa điểm kết thúc',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            textField(context, 'Nhấn để chọn', Icons.navigate_next, () async {
              var result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddressScreen(),
                ),
              ) as Address;
            }, (value) => null, null, true, null, 1),
            SizedBox(
              height: 24,
            ),
            Text(
              'Ngày khởi hành',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            textField(context, 'dd/MM/YYYY', Icons.calendar_today, () => null,
                (value) => null, null, true, null, 1),
            SizedBox(
              height: 24.0,
            ),
            PrimaryButton(onPressed: () {}, text: 'Tạo lộ trình'),
          ],
        ),
      ),
    );
  }

  Widget textField(
      BuildContext context,
      String hint,
      IconData icon,
      Function() ontap,
      Function(String) onChanged,
      TextEditingController controller,
      bool readonly,
      TextInputType inputType,
      int maxLines) {
    return TextFormField(
      keyboardType: inputType == null ? TextInputType.text : inputType,
      readOnly: readonly,
      controller: controller,
      textInputAction: TextInputAction.next,
      style: TextStyle(
        fontSize: AppConstants.minFontSize,
        fontFamily: 'Roboto',
      ),
      decoration: InputDecoration(
        //labelText: 'EMAIL',
        suffixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: AppConstants.linkColor, width: 2.0),
        ),
        hintText: hint,
      ),
      maxLines: maxLines,
      //controller: emailController,
      // onFieldSubmitted: (v) {
      //   FocusScope.of(context).requestFocus(focus);
      // },
      onTap: ontap,
      onChanged: onChanged,
      validator: (text) {
        if (text.length == 0) {
          return "Xin hãy nhập email ở đây";
        } else {
          return null;
        }
      },
    );
  }
}
