import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_admin/model/shop.dart';
import 'package:coffee_admin/ui/landing_page.dart';
import 'package:coffee_admin/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    final shopBloc = Provider.of<ShopBloc>(context, listen: false);

    if (user != null) {
      FirebaseFirestore.instance
          .collection('coffeeshop')
          .where('id', isEqualTo: user.uid)
          .get()
          .then((snapshots) {
        final doc = snapshots.docs.first;
        shopBloc.shop = Shop.fromMap(doc.id, doc.data());
      });
      return LandingPage();
    } else
      return LoginPage();
  }
}
