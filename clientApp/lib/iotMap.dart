import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class IotMap extends StatefulWidget {
  @override
  _IotMapState createState() => _IotMapState();
}

class _IotMapState extends State<IotMap> {
  Color bgColor = Colors.grey[900];

  GoogleMapController _controller;

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker _marker = Marker(markerId: MarkerId("pointer"));
  Circle _circle = Circle(circleId: CircleId("pointerCircle"));
  Uint8List imageData;
  LatLng latLang = LatLng(7.8731, 80.7718);
  LatLng userLatLang = LatLng(7.8731, 80.7718);
  String deviceId = "gps001";
  double mapZoom = 18.0;

  final databaseReference = FirebaseDatabase.instance.reference();

  BitmapDescriptor pinLocationIcon, pinLocationIconForUser;

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/dog.png');
  }

  void setCustomMapPinForUser() async {
    pinLocationIconForUser = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/rec.png');
  }

  void updateMarkerAndCircle(LocationData newLocalData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      this._marker = Marker(
          markerId: MarkerId("pointer"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 3,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: pinLocationIconForUser);
      this._circle = Circle(
          circleId: CircleId("pointerCircle"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeWidth: 3,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          userLatLang = LatLng(newLocalData.latitude, newLocalData.longitude);
          updateMarkerAndCircle(newLocalData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  void getCurrentLocationWithAnimation(LatLng ltlg) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
      bearing: 0,
      target: ltlg,
      tilt: 0,
      zoom: mapZoom,
    )));
  }

  void getgpsLocationWithAnimation(LatLng ltlg) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
      bearing: 0,
      target: ltlg,
      tilt: 0,
      zoom: mapZoom,
    )));
  }

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    setCustomMapPinForUser();

    databaseReference.child("gpsdata").child(deviceId).onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        this.latLang = LatLng(double.parse(snapshot.value['lat']),
            double.parse(snapshot.value['lng']));

        _controller
            .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
          target: this.latLang,
          zoom: mapZoom,
        )));
      });
    });
    getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  MapType _currentMapType = MapType.normal;

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('GPS Tracker'),
          backgroundColor: Colors.orange[900],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: _currentMapType,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: latLang,
                zoom: 7.5,
              ),
              markers: Set.of([
                _marker,
                Marker(
                  markerId: MarkerId("pet"),
                  position: latLang,
                  anchor: Offset(0.5, 0.5),
                  icon: pinLocationIcon,
                  zIndex: 4,
                ),
                // _marker
              ]),
              circles: Set.of([
                _circle,
                Circle(
                  circleId: CircleId("petCircle"),
                  radius: 5,
                  zIndex: 2,
                  strokeWidth: 3,
                  strokeColor: Colors.green,
                  center: latLang,
                  fillColor: Colors.green.withAlpha(75),
                ),
                // _circle
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 0, 15),
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _currentMapType = _currentMapType == MapType.normal
                                ? MapType.hybrid
                                : MapType.normal;
                          });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.orange[900],
                        child: Icon(
                          Icons.map,
                          size: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 0, 15),
                      child: FloatingActionButton(
                        onPressed: () {
                          getCurrentLocationWithAnimation(userLatLang);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.location_history,
                          size: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 0, 15),
                      child: FloatingActionButton(
                        onPressed: () {
                          getgpsLocationWithAnimation(latLang);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.pets,
                          size: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
