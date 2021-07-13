import 'package:flutter/material.dart';
import 'petList.dart';
import 'addNewPet.dart';

// ignore: must_be_immutable
class PetPage extends StatefulWidget {
  String uid;
  PetPage(this.uid);
  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  Color bgColor = Colors.grey[900];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 20, bottom: 20),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          tooltip: "Add new pet",
          splashColor: Colors.blue,
          elevation: 15,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddNewPet()));
          },
          child: Icon(
            Icons.add_circle,
            size: 65,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 10,
        title: Text(
          "My Pets",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          Icons.pets,
          size: 30,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: PetList(widget.uid),
      ),
    );
  }
}
