import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState(callback: () => null);
}

// TODO: successful scan, valid customer id => customer_page
// scan cancelled, error, invalid customer id => display message
class _ScannerPageState extends State<ScannerPage> {
  String barcode = 'no data';
  Function callback;

  _ScannerPageState({required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Scan Result',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 8,
          ),
          Text('$barcode',
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
        // TODO: add navigation callback to scanpage
        DefaultTabController.of(context)?.animateTo(1);
      });
    } catch (error) {
      print(error.runtimeType);
      return null;
    }
  }
}
