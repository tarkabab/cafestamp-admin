import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String barcode = 'no data';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('scan result',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 8,
          ),
          Text('BARCODE',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 72,
          ),
          ElevatedButton(
              child: new Text(
                "Scan",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                scanBarcode();
              }),
        ],
      ),
    );
  }

  Future<void> scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
          "#FF6666", "Cancel", false, ScanMode.QR);
      if (!mounted) return;

      setState(() {
        this.barcode = barcode;
      });
    } catch (error) {
      print(error.runtimeType);
      return null;
    }
  }
}
