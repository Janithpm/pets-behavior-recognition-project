import 'package:clientApp/iotMap.dart';
import 'package:clientApp/loginPage.dart';
import 'package:clientApp/menu.dart';
import 'package:clientApp/petProfileWidget.dart';
import 'package:clientApp/qrCodeScanner.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Data',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
