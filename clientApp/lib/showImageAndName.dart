import 'package:clientApp/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class ShowImageAndName extends StatefulWidget {
  String uid, photoURL, displayName, email, providerId;

  ShowImageAndName(
      this.uid, this.photoURL, this.displayName, this.email, this.providerId);
  @override
  _ShowImageAndNameState createState() => _ShowImageAndNameState();
}

class _ShowImageAndNameState extends State<ShowImageAndName> {
  void signOut(String providerId) async {
    print(providerId);
    if (providerId == 'password') {
      await FirebaseAuth.instance.signOut();
    } else if (providerId == 'google.com') {
      await GoogleSignIn().signOut();
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  // ignore: non_constant_identifier_names
  Widget ShowProfilePhoto(String photoURL) {
    if (photoURL != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FadeInImage.assetNetwork(
          placeholder: "assets/avatar.png",
          image: photoURL,
          width: 95,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image(
          image: AssetImage("assets/avatar.png"),
          width: 95,
        ),
      );
    }
  }

  // ignore: non_constant_identifier_names
  Widget ShowDetails(String displayName, String email) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            displayName,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white38,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(15),
            color: Colors.greenAccent[700],
            child: MaterialButton(
              onPressed: () {
                signOut(widget.providerId);
              },
              height: 10,
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  0,
                  MediaQuery.of(context).size.width * 0.05,
                  0),
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 20, 20, 20),
        child: Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(5, 40, 10, 40),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ShowProfilePhoto(widget.photoURL),
                    ShowDetails(widget.displayName, widget.email),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
