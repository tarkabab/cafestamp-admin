import 'package:coffee_admin/model/shop.dart';
import 'package:coffee_admin/service/auth.dart';
import 'package:coffee_admin/model/customer.dart';
import 'package:coffee_admin/ui/customer_page.dart';
import 'package:coffee_admin/ui/scanner_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee_admin/ui/authentication_wrapper.dart';
import 'package:coffee_admin/service/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CoffeeStampsAdmin());
}

class CoffeeStampsAdmin extends StatelessWidget {
  final AuthService authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => authService),
        Provider<FirestoreService>(create: (_) => firestoreService),
        ChangeNotifierProvider<CustomerBloc>.value(
          value: CustomerBloc(firestoreService),
        ),
        ChangeNotifierProvider<ShopBloc>.value(
          value: ShopBloc(firestoreService),
        ),
        StreamProvider(
          create: (_) => authService.authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => AuthenticationWrapper(),
          '/customer': (context) => customer,
        },
        theme: ThemeData.dark(),
        //home: AuthenticationWrapper(),
      ),
    );
  }
}
