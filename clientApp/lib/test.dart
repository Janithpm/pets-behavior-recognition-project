// // // // import 'dart:async';

// // import 'package:flutter/material.dart';
// // // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // // class MapSample extends StatefulWidget {
// // // //   @override
// // // //   State<MapSample> createState() => MapSampleState();
// // // // }

// // // // class MapSampleState extends State<MapSample> {
// // // //   Completer<GoogleMapController> _controller = Completer();

// // // //   static final CameraPosition _kGooglePlex = CameraPosition(
// // // //     target: LatLng(37.42796133580664, -122.085749655962),
// // // //     zoom: 14.4746,
// // // //   );

// // // //   static final CameraPosition _kLake = CameraPosition(
// // // //       bearing: 192.8334901395799,
// // // //       target: LatLng(5.944560500, 80.619255000),
// // // //       // tilt: 59.440717697143555,
// // // //       zoom: 19.151926040649414);

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return new Scaffold(
// // // //       body: GoogleMap(
// // // //         mapType: MapType.normal,
// // // //         initialCameraPosition: _kGooglePlex,
// // // //         onMapCreated: (GoogleMapController controller) {
// // // //           _controller.complete(controller);
// // // //         },
// // // //       ),
// // // //       floatingActionButton: FloatingActionButton.extended(
// // // //         onPressed: _goToTheLake,
// // // //         label: Text('To the lake!'),
// // // //         icon: Icon(Icons.directions_boat),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Future<void> _goToTheLake() async {
// // // //     final GoogleMapController controller = await _controller.future;
// // // //     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// // // //   }
// // // // }

// // // class ViewWidget extends StatefulWidget {
// // //   @override
// // //   ViewWidgetState createState() => ViewWidgetState();
// // // }

// // // class ViewWidgetState extends State {

// // //   bool viewVisible = true ;

// // //   void showWidget(){
// // //     setState(() {
// // //      viewVisible = true ;
// // //     });
// // //   }

// // //   void hideWidget(){
// // //     setState(() {
// // //      viewVisible = false ;
// // //     });
// // //   }

// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //         children: <Widget>[

// // //           Visibility(
// // //             maintainSize: true,
// // //             maintainAnimation: true,
// // //             maintainState: true,
// // //             visible: viewVisible,
// // //             child: Container(
// // //                height: 200,
// // //                width: 200,
// // //                color: Colors.green,
// // //                margin: EdgeInsets.only(top: 50, bottom: 30),
// // //                child: Center(child: Text('Show Hide Text View Widget in Flutter',
// // //                         textAlign: TextAlign.center,
// // //                         style: TextStyle(color: Colors.white,
// // //                                           fontSize: 23)))
// // //               )
// // //             ),

// // //           RaisedButton(
// // //             child: Text('Hide Widget on Button Click'),
// // //             onPressed: hideWidget,
// // //             color: Colors.pink,
// // //             textColor: Colors.white,
// // //             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
// // //             ),

// // //           RaisedButton(
// // //             child: Text('Show Widget on Button Click'),
// // //             onPressed: showWidget,
// // //             color: Colors.pink,
// // //             textColor: Colors.white,
// // //             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
// // //             ),

// // //         ],
// // //     );
// // //   }
// // // }
// // // class Testiui extends StatefulWidget {
// // //   @override
// // //   _TestiuiState createState() => _TestiuiState();
// // // }

// // // class _TestiuiState extends State<Testiui> {
// // //   int _selectedIndex = 0;
// // //   static const TextStyle optionStyle =
// // //       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// // //   static const List<Widget> _widgetOptions = <Widget>[
// // //     Text(
// // //       'Index 0: Home',
// // //       style: optionStyle,
// // //     ),
// // //     Text(
// // //       'Index 1: Business',
// // //       style: optionStyle,
// // //     ),
// // //     Text(
// // //       'Index 2: School',
// // //       style: optionStyle,
// // //     ),
// // //   ];

// // //   void _onItemTapped(int index) {
// // //     setState(() {
// // //       _selectedIndex = index;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('BottomNavigationBar Sample'),
// // //       ),
// // //       body: Center(
// // //         child: _widgetOptions.elementAt(_selectedIndex),
// // //       ),
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         items: const <BottomNavigationBarItem>[
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.home),
// // //             label: 'Home',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.business),
// // //             label: 'Business',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.school),
// // //             label: 'School',
// // //           ),
// // //         ],
// // //         currentIndex: _selectedIndex,
// // //         selectedItemColor: Colors.amber[800],
// // //         onTap: _onItemTapped,
// // //       ),
// // //     );
// // //   }
// // // }

// // /// Flutter code sample for BottomNavigationBar

// // // This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// // // widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// // // widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// // // the [currentIndex] is set to index 0. The selected item is
// // // amber. The `_onItemTapped` function changes the selected item's index
// // // and displays a corresponding message in the center of the [Scaffold].

// // import 'package:flutter/material.dart';

// // /// This is the stateful widget that the main application instantiates.
// // class MyStatefulWidget extends StatefulWidget {
// //   const MyStatefulWidget({key}) : super(key: key);

// //   @override
// //   _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
// // }

// // /// This is the private State class that goes with MyStatefulWidget.
// // class _MyStatefulWidgetState extends State<MyStatefulWidget> {
// //   int _selectedIndex = 0;
// //   static const TextStyle optionStyle =
// //       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// //   static const List<Widget> _widgetOptions = <Widget>[
// //     Text(
// //       'Index 0: Home',
// //       style: optionStyle,
// //     ),
// //     Text(
// //       'Index 1: Business',
// //       style: optionStyle,
// //     ),
// //     Text(
// //       'Index 2: School',
// //       style: optionStyle,
// //     ),
// //   ];

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('BottomNavigationBar Sample'),
// //       ),
// //       body: Center(
// //         child: _widgetOptions.elementAt(_selectedIndex),
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         items: const <BottomNavigationBarItem>[
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home),
// //             label: 'Home',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.business),
// //             label: 'Business',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.school),
// //             label: 'School',
// //           ),
// //         ],
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: Colors.amber[800],
// //         onTap: _onItemTapped,
// //       ),
// //     );
// //   }
// // }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,
//       appBar: AppBar(
//         toolbarHeight: MediaQuery.of(context).size.height * 0.1,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         titleSpacing: 10,
//         title: Text(
//           "My Pets",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: Icon(
//           Icons.pets,
//           size: 30,
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Material(
//                   elevation: 5,
//                   borderRadius: BorderRadius.circular(20),
//                   color: Color.fromARGB(255, 20, 20, 20),
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(25, 10, 20, 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Add New Pet",
//                           style: TextStyle(color: Colors.white, fontSize: 20),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.add_circle),
//                           iconSize: 40,
//                           color: Colors.white,
//                           onPressed: () {
//                             print("add new pet");
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 PetList(),
//                 // PetProfilePageWidget("Bob", "assets/dog2.jpg", true),
//                 // SizedBox(
//                 //   height: 10,
//                 // ),
//                 // PetProfilePageWidget("Lucy", "assets/dog1.jpg", false),
//                 // SizedBox(
//                 //   height: 10,
//                 // ),
//                 // PetProfilePageWidget("Timmy", "assets/dog3.jpg", true),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
