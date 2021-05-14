import 'package:coffee_admin/auth.dart';
import 'package:coffee_admin/customers.dart';
import 'package:coffee_admin/scanner.dart';
import 'package:coffee_admin/statistics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_wrapper.dart';
import 'messages.dart';

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
          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
            initialData: null,
          )
        ],
        child: MaterialApp(
            theme: ThemeData.dark(), home: AuthenticationWrapper()));
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                  children: [
                    Text(widget.title!),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                      child: IconButton(
                        iconSize: 24.0,
                        icon: Icon(Icons.face),
                        onPressed: () {
                          AuthService().logout();
                        },
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
                bottom: TabBar(
                  tabs: tabs.map((tab) => Tab(text: tab.title)).toList(),
                ),
              ),
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
  TabDescriptor("Customer", customersPage),
  TabDescriptor("Message", messagesPage),
  TabDescriptor("Statistics", statisticsPage),
];
