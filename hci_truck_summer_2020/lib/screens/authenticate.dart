import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/screens/error.dart';
import 'package:truck/screens/homeTruck.dart';
import 'package:truck/screens/userHome.dart';
import 'package:truck/screens/login.dart';

class AuthenticateScreen extends StatefulWidget {
  AuthenticateScreen({Key key}) : super(key: key);

  @override
  AuthenticateScreenState createState() => AuthenticateScreenState();
}

class AuthenticateScreenState extends State<AuthenticateScreen> {
  SharedPreferences prefs;
  bool isLoggedIn;
  void getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.containsKey('isLoggedIn') && prefs.containsKey('userId')) {
        isLoggedIn = prefs.getBool('isLoggedIn');
      } else {
        isLoggedIn = false;
      }
    });
  }

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == true) {
      if (prefs.getInt('roleId') == 1) {
        return UserHomeScreen();
      } else if (prefs.getInt('roleId') == 2) {
        return HomeTruckScreen();
      }
    } else if (isLoggedIn == false) {
      return LoginScreen();
    }
    return ErrorScreen();
  }
}
//   return MaterialApp(
//     theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity),
//     home: FutureBuilder(
//       future: FirebaseAuthService.checkLoggedUser(),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.data) {
//             return HomeScreen();
//           } else {
//             return LoginScreen();
//           }
//         }else{
//           return ErrorScreen();
//         }
//       },
//     ),
//   );
// }
