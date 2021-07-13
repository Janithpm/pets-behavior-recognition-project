import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Color bgColor = Colors.grey[900];

  String qRCodeData = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String qRCodeDataResponse;

    try {
      qRCodeDataResponse = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.QR);
    } on PlatformException {
      qRCodeDataResponse = 'failed';
    }

    if (!mounted) return;
    setState(() {
      qRCodeData = qRCodeDataResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pair"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  "$qRCodeData",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            ElevatedButton(
              child: Text(
                "scan now",
                style: TextStyle(fontSize: 25),
              ),
              onPressed: scanQR,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.fromLTRB(10, 20, 10, 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
