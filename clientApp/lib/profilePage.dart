import 'package:clientApp/gpsDeviceSettingsWidget.dart';
import 'package:clientApp/profileSettingWidget.dart';
import 'package:clientApp/showImageAndName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage(this.user);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color bgColor = Colors.grey[900];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 10,
        title: Text(
          "My Account",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          Icons.person,
          size: 30,
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ShowImageAndName(
                    widget.user.displayName,
                    widget.user.photoURL,
                    widget.user.displayName,
                    widget.user.email,
                    widget.user.providerData[0].providerId),
                SizedBox(
                  height: 15,
                ),
                ProfileSettingWidget(widget.user.uid),
                SizedBox(
                  height: 15,
                ),
                GpsDeviceSettingsWidget(),
                SizedBox(
                  height: 20,
                ),
                Material(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
