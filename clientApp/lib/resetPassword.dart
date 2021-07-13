import 'package:clientApp/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  Color bgColor = Colors.grey[900];

  TextEditingController resetPasswordController = new TextEditingController();

  Future<void> errPopup(String err) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
          title: Text(err),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.orange[400]),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> resetPassword(String email) async {
    if (resetPasswordController.text != "") {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        resetPasswordController.clear();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      } on FirebaseException catch (e) {
        if (e.code == 'invalid-email') {
          errPopup("Invalid email.");
        } else {
          errPopup("Something went wrong, Try again.");
        }
      }
    } else {
      errPopup("Email can't be empty.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                "Forgot your password?",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 15, 30, 20),
              child: Text(
                "Enter your registered email address below to receive password reset instruction.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: TextField(
                  controller: resetPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange[600],
                      ),
                    ),
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(25),
                color: Colors.greenAccent[700],
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width / 2,
                  onPressed: () {
                    resetPassword(resetPasswordController.text);
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(35, 10, 35, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Remember password? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: Colors.orange[600], width: 1)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
