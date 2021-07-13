import 'package:clientApp/qrCodeScanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

enum SingingCharacter { male, female }

// ignore: must_be_immutable
class AddNewPet extends StatefulWidget {
  @override
  _AddNewPetState createState() => _AddNewPetState();
}

class _AddNewPetState extends State<AddNewPet> {
  User currentUser = FirebaseAuth.instance.currentUser;
  Color bgColor = Colors.grey[900];
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  SingingCharacter gender = SingingCharacter.male;
  bool _gpsCollar = false;
  String qRCodeData = "";

  Future<void> scanQR() async {
    String qRCodeDataResponse;

    try {
      qRCodeDataResponse = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.QR);
    } on PlatformException {
      qRCodeDataResponse = 'failed';
    }

    if (!mounted) return;
    setState(() {
      qRCodeData = qRCodeDataResponse;
    });
  }

  Future<void> addData(String uid) {
    CollectionReference userPets =
        FirebaseFirestore.instance.collection('users/$uid/pets');

    // Call the user's CollectionReference to add a new user
    return userPets
        .add({
          'name': nameController.text,
          'age': ageController.text,
          'gender': gender.toString()
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    print(_gpsCollar);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 10,
        title: Text(
          "Add New Pet",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Center(
          child: Column(
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 20, 20, 20),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 5, 25, 15),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white70,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.orange[600],
                              ),
                            ),
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            // hintText: "something@example.com",
                            // hintStyle: TextStyle(color: Colors.white38),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 5, 25, 15),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          controller: ageController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white70,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.orange[600],
                              ),
                            ),
                            labelText: "Age",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            // hintText: "something@example.com",
                            // hintStyle: TextStyle(color: Colors.white38),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Male',
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Radio<SingingCharacter>(
                              fillColor:
                                  MaterialStateProperty.all(Colors.white),
                              value: SingingCharacter.male,
                              groupValue: gender,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Female',
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Radio<SingingCharacter>(
                              fillColor:
                                  MaterialStateProperty.all(Colors.white),
                              value: SingingCharacter.female,
                              groupValue: gender,
                              onChanged: (SingingCharacter value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: SwitchListTile(
                              title: Text(
                                'Add GPS Collar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              value: _gpsCollar,
                              onChanged: (bool value) {
                                setState(() {
                                  _gpsCollar = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
                            child: Visibility(
                              maintainAnimation: true,
                              maintainSize: false,
                              maintainState: true,
                              visible: _gpsCollar,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Scan QR code to pair new GPS Collar.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green,
                                    child: MaterialButton(
                                      onPressed: () {
                                        scanQR();
                                      },
                                      child: Text(
                                        "Scan now",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 20, 20, 20),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(150, 30, 150, 30),
                  child: ElevatedButton(
                    onPressed: () {
                      addData(currentUser.uid);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
