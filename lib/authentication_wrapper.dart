import 'package:coffee_admin/main.dart';
import 'package:coffee_admin/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      //context.read<AuthService>().logout();
      return LandingPage(title: "Coffee Stamps Admin");
    } else
      return LoginPage();
  }
}
