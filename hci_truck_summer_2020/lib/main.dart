import 'package:flutter/material.dart';
import 'package:truck/screens/authenticate.dart';
import 'package:truck/screens/homeTruck.dart';
import 'package:truck/screens/inputRequestDetail.dart';
import 'package:truck/screens/login.dart';
import 'package:truck/screens/UserListRequest.dart';
import 'package:truck/screens/profile.dart';
import 'package:truck/screens/userCreateRequest.dart';
import 'package:truck/screens/userHome.dart';
import 'package:truck/screens/signup.dart';
import 'package:truck/screens/userListQuotation.dart';
import 'package:truck/screens/userLocationOnMap.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/': (context) => UserHomeScreen(),
      '/login': (context) => LoginScreen(),
      '/signup': (context) => SignUpScreen(),
      '/userHome': (context) => UserHomeScreen(),
      '/userLocation': (context) => UserLocationScreen(),
      '/userListQuotation': (context) => UserListQuotaionScreen(1),
      '/userListRequest': (context) => UserListRequestScreen(),
      '/inputRequestDetailScreen': (context) => InputRequestDetailScreen(),
      '/profile': (context) => ProfileScreen(),
      '/auth': (context) => AuthenticateScreen(),
      '/homeTruck': (context) => HomeTruckScreen(),
      '/createRequest' : (context) => UserCreateRequestScreen(),
    },
  ));
}
