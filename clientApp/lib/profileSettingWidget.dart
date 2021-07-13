import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileSettingWidget extends StatefulWidget {
  String uid;
  ProfileSettingWidget(this.uid);
  @override
  _ProfileSettingWidgetState createState() => _ProfileSettingWidgetState();
}

class _ProfileSettingWidgetState extends State<ProfileSettingWidget> {
  User currentUser = FirebaseAuth.instance.currentUser;

  static const IconData eye =
      IconData(0xe803, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData eye_off =
      IconData(0xe802, fontFamily: 'MyFlutterApp', fontPackage: null);

  bool displayNameTextbox = false;
  bool passwordTextBoxes = false;
  bool hidePassword = true;
  bool isPasswordMatch = false;
  bool logedinWithpassword = false;

  String displayName;
  TextEditingController displayNameController = new TextEditingController();
  TextEditingController currentPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    if (currentUser.providerData[0].providerId == "password") {
      setState(() {
        logedinWithpassword = true;
      });
    } else {
      setState(() {
        logedinWithpassword = false;
      });
    }
  }

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

  Future<void> updateDisplayName() async {
    FocusScope.of(context).unfocus();

    if (displayNameController.text != "") {
      try {
        await currentUser.updateProfile(
            displayName: displayNameController.text);
      } on FirebaseException catch (e) {
        if (e.code == 'network-request-failed') {
          errPopup("Connetion lost.");
        } else {
          errPopup("Something went wrong. Try again.");
        }
      }
    } else {
      errPopup("Name can't be empty.");
    }
    displayNameController.clear();
  }

  Future<void> updatePassword() async {
    FocusScope.of(context).unfocus();

    if (currentPasswordController.text != "" &&
        newPasswordController.text != "" &&
        confirmPasswordController.text != "") {
      if (newPasswordController.text == confirmPasswordController.text) {
        try {
          EmailAuthCredential credential = EmailAuthProvider.credential(
              email: currentUser.email,
              password: currentPasswordController.text);
          await currentUser.reauthenticateWithCredential(credential);

          try {
            await currentUser.updatePassword(newPasswordController.text);
            setState(() {
              passwordTextBoxes = false;
            });
          } on FirebaseException {
            errPopup("something went wrong, Try again.");
          }
        } on FirebaseException catch (e) {
          if (e.code == 'wrong-password') {
            errPopup("Current password is incorrect.");
          } else if (e.code == 'network-request-failed') {
            errPopup("connection lost.");
          } else {
            errPopup("Something went wrong, Try again.");
          }
        }
      } else {
        errPopup("Password didn't match");
      }
    } else {
      errPopup("Password fields can't be empty.");
    }
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser.uid == widget.uid) {
      displayName = currentUser.displayName;
    }
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      color: Color.fromARGB(255, 20, 20, 20),
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 35, 30, 15),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    displayName,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        displayNameTextbox = true;
                      });
                    },
                    child: displayNameTextbox
                        ? IconButton(
                            icon: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              displayNameController.clear();
                              setState(() {
                                displayNameTextbox = false;
                              });
                            },
                            splashColor: Colors.orange[600],
                            splashRadius: 20,
                          )
                        : Text(
                            "Change",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                    style: displayNameTextbox
                        ? null
                        : OutlinedButton.styleFrom(
                            side: BorderSide(width: 2, color: Colors.white54)),
                  ),
                  // )
                ],
              ),
              Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: displayNameTextbox,
                child: Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 10),
                  child: TextField(
                    controller: displayNameController,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          updateDisplayName();
                          setState(() {
                            displayName = currentUser.displayName;

                            displayNameTextbox = false;
                          });
                        },
                        icon: Icon(Icons.check),
                        iconSize: 30,
                        color: Colors.white,
                        splashColor: Colors.orange[600],
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[600]),
                      ),
                      // labelText: "New name",
                      // labelStyle:
                      //     TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Password",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: logedinWithpassword
                        ? () {
                            setState(() {
                              passwordTextBoxes = true;
                            });
                          }
                        : null,
                    child: passwordTextBoxes
                        ? IconButton(
                            icon: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              currentPasswordController.clear();
                              newPasswordController.clear();
                              confirmPasswordController.clear();

                              setState(() {
                                passwordTextBoxes = false;
                              });
                            },
                            splashColor: Colors.orange[600],
                            splashRadius: 20,
                          )
                        : Text(
                            "Change",
                            style: TextStyle(
                                decoration: logedinWithpassword
                                    ? null
                                    : TextDecoration.lineThrough,
                                color: logedinWithpassword
                                    ? Colors.white
                                    : Colors.red[200],
                                fontSize: 14),
                          ),
                    style: passwordTextBoxes
                        ? null
                        : OutlinedButton.styleFrom(
                            side: BorderSide(
                                width: 2,
                                color: logedinWithpassword
                                    ? Colors.white54
                                    : Colors.red[200])),
                  ),
                ],
              ),
              Visibility(
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: passwordTextBoxes,
                child: Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          obscureText: hidePassword,
                          controller: currentPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: hidePassword ? Icon(eye_off) : Icon(eye),
                              color: Colors.white,
                              splashRadius: 20,
                              splashColor: Colors.orange[600],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange[600]),
                            ),
                            labelText: "Current Password",
                            labelStyle:
                                TextStyle(color: Colors.white70, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          obscureText: hidePassword,
                          controller: newPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange[600]),
                            ),
                            labelText: "New Password",
                            labelStyle:
                                TextStyle(color: Colors.white70, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextField(
                          obscureText: hidePassword,
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                updatePassword();
                              },
                              icon: Icon(Icons.check),
                              iconSize: 30,
                              color: Colors.white,
                              splashColor: Colors.orange[600],
                              splashRadius: 20,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange[600]),
                            ),
                            labelText: "Confirm new password",
                            labelStyle:
                                TextStyle(color: Colors.white70, fontSize: 18),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
