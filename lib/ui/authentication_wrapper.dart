import 'package:coffee_admin/ui/landing_page.dart';
import 'package:coffee_admin/ui/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      //context.read<AuthService>().logout();
      return LandingPage();
    } else
      return LoginPage();
  }
}
