import 'package:flutter/material.dart';

class PetProfilePageWidget extends StatefulWidget {
  bool isMale = true;
  String name, gender;
  PetProfilePageWidget(this.name, this.gender);
  @override
  _PetProfilePageWidgetState createState() => _PetProfilePageWidgetState();
}

class _PetProfilePageWidgetState extends State<PetProfilePageWidget> {
  static const IconData male =
      IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData female =
      IconData(0xe801, fontFamily: 'MyFlutterApp', fontPackage: null);

  Widget showImage(String photoURL) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.dstIn),
          fit: BoxFit.cover,
          image: AssetImage(photoURL),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    if (widget.gender == 'male') {
      widget.isMale = true;
    } else {
      widget.isMale = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("clicked");
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 20, 20, 20),
        child: Center(
          child: Column(
            children: <Widget>[
              showImage("assets/dog1.jpg"),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            widget.isMale ? male : female,
                            color:
                                widget.isMale ? Colors.blue[300] : Colors.pink,
                            size: 18,
                          ),
                        ]),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.location_on),
                          iconSize: 30,
                          color: Colors.red,
                          splashColor: Colors.red,
                          splashRadius: 25,
                          onPressed: () {
                            print("Location");
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          iconSize: 30,
                          color: Colors.green,
                          splashColor: Colors.green,
                          splashRadius: 25,
                          onPressed: () {
                            print("Settings");
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
