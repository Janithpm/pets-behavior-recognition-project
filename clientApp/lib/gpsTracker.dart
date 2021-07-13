import 'package:flutter/material.dart';

class GpsTracker extends StatefulWidget {
  @override
  _GpsTrackerState createState() => _GpsTrackerState();
}

class _GpsTrackerState extends State<GpsTracker> {
  Color bgColor = Colors.grey[900];
  Color primaryTextColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Name"),
      ),
      backgroundColor: bgColor,
      body: Center(
        child: Text(
          "data",
          style: TextStyle(color: primaryTextColor),
        ),
      ),
    );
  }
}
