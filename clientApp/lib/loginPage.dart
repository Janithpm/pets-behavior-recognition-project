import 'package:clientApp/homePage.dart';
import 'package:clientApp/menu.dart';
import 'package:clientApp/resetPassword.dart';
import 'package:clientApp/signupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool userFound = false;
  bool correctInputCredentials = false;
  bool hidePassword = true;
  Color bgColor = Colors.grey[900];
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
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

  Future<void> login() async {
    if (emailController.text != "") {
      if (passwordController.text != "") {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          if (userCredential != null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(userCredential.user)));
          }
          print(userCredential.user);
          emailController.clear();
          passwordController.clear();
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            errPopup("Incorrect email.");
            emailController.clear();
            passwordController.clear();
          } else if (e.code == 'wrong-password') {
            errPopup("Incorrect password.");
            passwordController.clear();
          } else if (e.code == 'invalid-email') {
            errPopup("Invaild email.");
          } else if (e.code == 'network-request-failed') {
            errPopup("Connection lost.");
          } else {
            errPopup("Somrthing went wrong, Try again.");
          }
        }
      } else {
        errPopup("Password can't be empty.");
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
      print(userCredential.user);
    }
    // return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    Firebase.initializeApp();

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: mq.size.height / 10),
                child: Image(
                  image: AssetImage("assets/logo.png"),
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 5, 25, 15),
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
                    // hintText: "something@example.com",
                    // hintStyle: TextStyle(color: Colors.white38),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 15),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  obscureText: hidePassword,
                  controller: passwordController,
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
                    )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange[600],
                      ),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResetPassword()));
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: Colors.orange[800],
                          fontSize: 18,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, mq.size.height / 20),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.greenAccent[700],
                  child: MaterialButton(
                    minWidth: mq.size.width / 2,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Text(
                      "Log In",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      login();
                      // errPopup("Incorrect password.");
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(35, 13, 0, 5),
                    child: Text(
                      "Not a member ?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 35, 5),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupPage()));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
                        child: Text(
                          "Sign Up",
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
              SizedBox(
                height: mq.size.height / 75,
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
                  text: "       Log in with Google",
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
