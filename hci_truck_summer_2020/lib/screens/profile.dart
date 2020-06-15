import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/constants/appConstans.dart';
import 'package:truck/services/appUi.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              profileDetail(),
              SizedBox(
                height: 24,
              ),
              profileButtonGroup(context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget profileDetail() {
  return Column(
    children: <Widget>[
      Center(
        child: Container(
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            color: Colors.blueAccent,
          ),
          child: Image.asset('assets/images/delivery-truck.png'),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'user 1',
        style: TextStyle(fontSize: 25.0),
      ),
      Text(
        'user_1@gmail.com',
        style: TextStyle(fontSize: 25.0),
      ),
    ],
  );
}

Widget profileButtonGroup(BuildContext context) {
  return Column(
    children: <Widget>[
      Divider(
        color: Colors.black,
      ),
      ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.edit),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: editProfileDialog(context),
                ),
              ),
            ),
          );
        },
      ),
      Divider(
        color: Colors.black,
      ),
      ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.edit),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Change Password',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
        onTap: () {
          showDialog(
            context: context,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: changePasswordDialog(context),
              )),
            ),
          );
        },
      ),
      Divider(
        color: Colors.black,
      ),
      ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.library_books),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Open Delivery History',
              style: TextStyle(fontSize: 20.0,),
            ),
          ],
        ),
        onTap: () {},
      ),
      Divider(
        color: Colors.black,
      ),
      ListTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.exit_to_app),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Log out',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
      ),
      Divider(
        color: Colors.black,
      ),
    ],
  );
}

Widget editProfileDialog(BuildContext context) {
  return Container(
    child: Form(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: AppConstants.minFontSize,
              fontFamily: 'Roboto',
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide:
                    BorderSide(color: AppConstants.linkColor, width: 2.0),
              ),
              hintText: "Username",
            ),
            // controller: usernameController,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            maxLines: 1,
            validator: (text) {
              if (text.length == 0) {
                return "Please enter your Username";
              } else if (text.length < 4) {
                return "The Username has at least 5 characters";
              } else {
                return null;
              }
            },
            onFieldSubmitted: (v) {},
          ),
          SizedBox(
            height: 24,
          ),
          PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Save Changes',
          ),
          SizedBox(
            height: 10,
          ),
          PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Close',
          ),
        ],
      ),
    )),
  );
}

Widget changePasswordDialog(BuildContext context) {
  final FocusNode passwordFocus = FocusNode();
  final FocusNode repasswordFocus = FocusNode();
  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  return Container(
    child: Form(
        child: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Change Password',
              style: TextStyle(fontSize: 25.0),
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: AppConstants.minFontSize,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: AppConstants.linkColor, width: 2.0),
                ),
                hintText: "Your old Password",
              ),
              controller: oldpasswordController,
              autocorrect: false,
              maxLines: 1,
              obscureText: true,
              validator: (text) {
                if (text.length == 0) {
                  return "Please enter your currently used Password";
                } else {
                  return null;
                }
              },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: AppConstants.minFontSize,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: AppConstants.linkColor, width: 2.0),
                ),
                hintText: "Your new Password",
              ),
              controller: passwordController,
              autocorrect: false,
              maxLines: 1,
              obscureText: true,
              focusNode: passwordFocus,
              validator: (text) {
                if (text.length == 0) {
                  return "Please enter your new Password";
                } else if (text.length < 8) {
                  return "The password has at least 8 characters";
                } else {
                  return null;
                }
              },
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(repasswordFocus);
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              style: TextStyle(
                fontSize: AppConstants.minFontSize,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: AppConstants.linkColor, width: 2.0),
                ),
                hintText: "Enter your new Password again",
              ),
              controller: repasswordController,
              autocorrect: false,
              maxLines: 1,
              obscureText: true,
              focusNode: repasswordFocus,
            ),
            SizedBox(
              height: 24,
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Change Password',
            ),
            SizedBox(
              height: 10,
            ),
            PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Close',
            ),
          ],
        ),
      ),
    )),
  );
}
