import 'package:coffee_admin/auth.dart';
import 'package:coffee_admin/customer.dart';
import 'package:coffee_admin/customer_page.dart';
import 'package:coffee_admin/scanner_page.dart';
import 'package:coffee_admin/statistics_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_wrapper.dart';
import 'firestore_service.dart';
import 'messaging_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CoffeeStampsAdmin());
}

class CoffeeStampsAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        ChangeNotifierProvider<CustomerBloc>.value(value: CustomerBloc()),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var title = "Coffee Shop";

  @override
  void initState() {
    super.initState();
    final _firestore = Provider.of<FirestoreService>(context, listen: false);
    _firestore.getName().then((name) => setState(() {
          title = name;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              print(
                  "index: ${tabController.index} previous index: ${tabController.previousIndex}");
              if (tabController.index == 0) {
                //scanBarcode();
              }
            }
          });
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
              body: TabBarView(
                children: tabs.map((tab) => tab.content).toList(),
              ));
        },
      ),
    );
  }
}

class TabDescriptor {
  final String title;
  final Widget content;

  TabDescriptor(this.title, this.content);
}

final List<TabDescriptor> tabs = [
  TabDescriptor("Scan", ScannerPage()),
  TabDescriptor("Customer", CustomerPage()),
  TabDescriptor("Messaging", MessagingPage()),
  TabDescriptor("Statistics", StatisticsPage()),
];
