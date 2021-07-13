import 'package:flutter/material.dart';

class GpsDeviceSettingsWidget extends StatefulWidget {
  @override
  _GpsDeviceSettingsWidgetState createState() =>
      _GpsDeviceSettingsWidgetState();
}

class _GpsDeviceSettingsWidgetState extends State<GpsDeviceSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Color.fromARGB(255, 20, 20, 20),
      child: Padding(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "GPS Collars",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  IconButton(
                      tooltip: "Add new GPS Collar",
                      icon: Icon(Icons.add),
                      color: Colors.white,
                      iconSize: 30,
                      splashColor: Colors.orange[600],
                      splashRadius: 20,
                      onPressed: () {}),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
