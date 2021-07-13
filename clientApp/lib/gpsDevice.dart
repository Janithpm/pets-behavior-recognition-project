// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:firebase_database/firebase_database.dart';

// class GPSDevice {
//   String _id;
//   LatLng _latLng;
//   String pet;

//   GPSDevice(this._id);

//   LatLng fetchLocation(DatabaseReference dbrf) {
//     dbrf.child("gpsdata").child(this._id).onValue.listen((event) {
//       var snapshot = event.snapshot;
//       this._latLng = LatLng(double.parse(snapshot.value['lat']),
//           double.parse(snapshot.value['lng']));
//       // return _lsatLng;
//     });
//   }

//   String getDeviceId() {
//     return this._id;
//   }

//   LatLng getLocation() {
//     // print(this._latLng);
//     if (this._latLng != null) {
//       return this._latLng;
//     } else {
//       return LatLng(0.000, 0.000);
//     }
//   }

//   void printAllData() {
//     // print("id = ${this._id}");
//     print("lat, lang = ${this._latLng}");
//   }
// }
