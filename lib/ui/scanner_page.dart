import 'package:coffee_admin/model/customer.dart';
import 'package:coffee_admin/model/shop.dart';
import 'package:coffee_admin/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

final scan = ScannerPage();

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
                scanBarcode(context);
              }),
        ],
      ),
    );
  }

  Future<void> scanBarcode(BuildContext context) async {
    try {
      final scanResult = await FlutterBarcodeScanner.scanBarcode(
          "#FF6666", "Cancel", false, ScanMode.QR);
      print("barcode: $scanResult");

      if (!mounted) return;

      setState(() {
        print("barcode scanned");
        // barcode = "P80fPGlPk5bh7wrCOUgxHDV1nPC3";
        barcode = scanResult;

        final firestore = Provider.of<FirestoreService>(context, listen: false);
        final customerBloc = Provider.of<CustomerBloc>(context, listen: false);
        final shopBloc = Provider.of<ShopBloc>(context, listen: false);
        print("shop id: ${shopBloc.shop!.id}");
        print("customer id: $barcode");
        firestore.getCustomer(shopBloc.shop!.id, barcode).then((customer) {
          print("get customer: $customer");
          customerBloc.customer = customer;
          // TODO: add navigation callback to scanpage
          Navigator.of(context).pushNamed('/customer');
        });
      });
    } catch (error) {
      print("barcode scan error");
      print(error.runtimeType);
      print(error.toString());
      return null;
    }
  }
}
