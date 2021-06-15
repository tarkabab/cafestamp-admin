import 'package:coffee_admin/model/shop.dart';
import 'package:coffee_admin/service/auth.dart';
import 'package:coffee_admin/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLogin = true;

  void setupShop(BuildContext context) {
    final authService = context.read<AuthService>();
    final firestoreService = context.read<FirestoreService>();

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    authService
        .register(email: email, password: password)
        .then((userCredentials) {
      final String shopId = userCredentials!.user!.uid;
      final String shopName = userNameController.value.text.trim();
      final shop = Shop(shopId, shopName, []);
      firestoreService.saveShop(shop);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _register = [
      Text("Register", style: TextStyle(fontSize: 25)),
      SizedBox(height: 20),
      TextFormField(
        controller: userNameController,
        decoration: InputDecoration(labelText: "Username"),
      ),
      TextFormField(
        controller: emailController,
        decoration: InputDecoration(labelText: "Email"),
        validator: (value) => null,
      ),
      TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(labelText: "Password"),
        validator: (value) => null,
      ),
      SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent),
        onPressed: () => setupShop(context),
        child: Text("Register"),
      ),
    ];

    final List<Widget> _login = [
      Text("Login", style: TextStyle(fontSize: 25)),
      SizedBox(height: 20),
      TextFormField(
        controller: emailController,
        decoration: InputDecoration(labelText: "Email"),
        validator: (value) => null,
      ),
      TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(labelText: "Password"),
        validator: (value) => null,
      ),
      SizedBox(height: 40),
      ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent),
        onPressed: () {
          final authService = context.read<AuthService>();
          authService.login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
        },
        child: Text("Login"),
      ),
    ];

    List<Widget> _loginOrRegisterSelector = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ToggleButtons(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Login'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Register"),
              ),
            ],
            isSelected: [_isLogin, !_isLogin],
            onPressed: (int index) {
              setState(() {
                if (index == 0)
                  _isLogin = true;
                else
                  _isLogin = false;
              });
            },
          )
        ],
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Icon(Icons.account_circle, size: 70),
              SizedBox(height: 40),
              ..._loginOrRegisterSelector,
              SizedBox(height: 40),
              if (_isLogin) ..._login else ..._register,
            ],
          ),
        ),
      ),
    );
  }
}

// A new home for your coffee stamps
//
