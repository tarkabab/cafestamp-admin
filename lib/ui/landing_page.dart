import 'package:coffee_admin/ui/scanner_page.dart';
import 'package:coffee_admin/ui/statistics_page.dart';
import 'package:coffee_admin/ui/customer_page.dart';
import 'package:coffee_admin/ui/messaging_page.dart';
import 'package:coffee_admin/service/auth.dart';
import 'package:coffee_admin/service/firestore_service.dart';
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

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  var title = "Coffee Shop";

  final List<TabDescriptor> tabs = [
    TabDescriptor("Scan", ScannerPage()),
    TabDescriptor("Customer", CustomerPage()),
    TabDescriptor("Messaging", MessagingPage()),
    TabDescriptor("Statistics", StatisticsPage()),
  ];

  @override
  void initState() {
    super.initState();
    final _firestore = Provider.of<FirestoreService>(context, listen: false);
    _firestore.getName().then((name) => setState(() {
          title = name;
        }));
  }

  // TODO: add navigation callback to scanpage
  Function successfulScanCallback = () => null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
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
                bottom: TabBar(
                  tabs: tabs.map((tab) => Tab(text: tab.title)).toList(),
                ),
              ),
              body: TabBarView(
                children: tabs.map((tab) => tab.view).toList(),
              ));
        },
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