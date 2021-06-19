import 'package:coffee_admin/model/shop.dart';
import 'package:coffee_admin/ui/scanner_page.dart';
import 'package:coffee_admin/ui/customer_page.dart';
import 'package:coffee_admin/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabDescriptor {
  final String title;
  final Widget view;

  TabDescriptor(this.title, this.view);
}

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var title = "Coffee Shop";
  int _selectedIndex = 0;

  // TODO: add navigation callback to scanpage
  Function successfulScanCallback = () => null;

  @override
  Widget build(BuildContext context) {
    final shopBloc = Provider.of<ShopBloc>(context, listen: true);

    final List<Widget> pages = [scan, customer];

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background.jpeg'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  shopBloc.shop != null ? shopBloc.shop!.name : "Unknown Shop",
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.yellow.shade100),
                ),
              ),
              IconButton(
                iconSize: 24.0,
                icon: Icon(Icons.face),
                color: Colors.yellow.shade100,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                onPressed: () => AuthService().logout(),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.orange.shade300,
          unselectedItemColor: Colors.orange.shade50,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(label: "scan", icon: Icon(Icons.qr_code)),
            BottomNavigationBarItem(
                label: "customer", icon: Icon(Icons.local_cafe_outlined)),
            // BottomNavigationBarItem(label: "messages", icon: Icon(Icons.message)),
          ],
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
        ),
      ),
    );
  }
}

// drawer: Drawer(
//   child: ListView(
//     // Important: Remove any padding from the ListView.
//     padding: EdgeInsets.zero,
//     children: <Widget>[
//       DrawerHeader(
//         child: Text('Menu drawer'),
//         decoration: BoxDecoration(
//           color: Colors.red,
//         ),
//       ),
//       ListTile(
//         leading: Icon(
//           Icons.home,
//           size: 40,
//         ),
//         title: Text('First item'),
//         subtitle: Text("This is the 1st item"),
//         trailing: Icon(Icons.more_vert),
//         onTap: () {},
//       ),
//       ListTile(
//         title: Text('Second item'),
//         onTap: () {},
//       ),
//               ListTile(
//   title: Text('Close the menu'),
//   onTap: () {
//     Navigator.pop(context);
//   },
// )
//     ],
//   ),
// ),