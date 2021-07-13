import 'package:clientApp/homePage.dart';
import 'package:clientApp/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'menu.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Color bgColor = Colors.grey[900];
  bool hidePassword = true;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  bool isPasswordMatch = true;

  static const IconData eye =
      IconData(0xe803, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData eye_off =
      IconData(0xe802, fontFamily: 'MyFlutterApp', fontPackage: null);

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

  Future<void> signUp() async {
    if (emailController.text != "") {
      if (newPasswordController.text != "" &&
          confirmPasswordController.text != "") {
        if (nameController.text != "") {
          if (newPasswordController.text == confirmPasswordController.text) {
            setState(() {
              isPasswordMatch = true;
            });
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: newPasswordController.text);
              await FirebaseAuth.instance.currentUser
                  .updateProfile(displayName: nameController.text);
              User currentUser = FirebaseAuth.instance.currentUser;
              print(currentUser);
              if (currentUser != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(currentUser)));
                nameController.clear();
                emailController.clear();
                newPasswordController.clear();
                confirmPasswordController.clear();
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                errPopup("The password provided is too weak.");
              } else if (e.code == 'email-already-in-use') {
                errPopup("The account already exists for that email.");
              } else if (e.code == 'invalid-email') {
                errPopup("Invaild email.");
              } else if (e.code == 'network-request-failed') {
                errPopup("Connection lost.");
              } else {
                errPopup("Somrthing went wrong, Try again.");
              }
            }
          } else {
            errPopup("Password didn't match.");
            isPasswordMatch = false;
            newPasswordController.clear();
            confirmPasswordController.clear();
          }
        } else {
          errPopup("Name can't be empty.");
        }
      } else {
        errPopup("Password / Confirm password can't be empty.");
      }
    } else {
      errPopup("Email can't be empty.");
    }
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(userCredential.user)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: mq.size.height / 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 13, 0, 5),
                    child: Text(
                      "Already a member ?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                        color: Colors.orangeAccent[400],
                        width: 1,
                      )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
                child: TextField(
                  keyboardType: TextInputType.name,
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
                    labelText: "Username",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
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
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
                child: TextField(
                  obscureText: hidePassword,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.white),
                  controller: newPasswordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: hidePassword ? Icon(eye_off) : Icon(eye),
                      color: Colors.white60,
                      tooltip: "Show / Hide password",
                      splashColor: Colors.orange[400],
                      splashRadius: 20,
                    ),
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
                    labelText: "New password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
                child: TextField(
                  obscureText: hidePassword,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: isPasswordMatch ? Colors.white : Colors.red,
                  style: TextStyle(color: Colors.white),
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: isPasswordMatch ? Colors.white70 : Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            isPasswordMatch ? Colors.orange[600] : Colors.red,
                      ),
                    ),
                    labelText: "Confirm password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.greenAccent[700],
                  child: MaterialButton(
                    minWidth: mq.size.width / 2,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      signUp();
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          thickness: 1,
                          color: Colors.white38,
                        ),
                      ),
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        color: Colors.white38,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          thickness: 1,
                          color: Colors.white38,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mq.size.height / 70,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: SignInButton(
                  Buttons.GoogleDark,
                  elevation: 5,
                  text: "       Sign up with Google",
                  padding: EdgeInsets.fromLTRB(25, 5, 10, 5),
                  onPressed: () {
                    signInWithGoogle();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
