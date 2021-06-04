import 'package:coffee_admin/service/auth.dart';
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
        onPressed: () {
          context.read<AuthService>().register(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
        },
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
          context.read<AuthService>().login(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
        },
        child: Text("Login"),
      ),
    ];

    List<Widget> _selector = [
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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.deepPurple.shade300,
              Colors.deepPurple.shade800
            ])),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Icon(Icons.account_circle, size: 70),
                SizedBox(height: 40),
                ..._selector,
                SizedBox(height: 40),
                if (_isLogin) ..._login else ..._register,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//                 SizedBox(height: 40),
//                 Icon(Icons.account_circle, size: 70),
//                 SizedBox(height: 40),
//                 Text("Login", style: TextStyle(fontSize: 25)),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(labelText: "Email"),
//                   validator: (value) => null,
//                 ),
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: "Password"),
//                   validator: (value) => null,
//                 ),
//                 SizedBox(height: 40),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.deepOrangeAccent),
//                   onPressed: () {
//                     context.read<AuthService>().login(
//                           email: emailController.text.trim(),
//                           password: passwordController.text.trim(),
//                         );
//                   },
//                   child: Text("Login"),
//                 ),
//                 SizedBox(height: 30),
//                 _separator,
//                 SizedBox(height: 30),
//                 Text("Register", style: TextStyle(fontSize: 25)),
//                 TextField(
//                   controller: passwordController,
//                   decoration: InputDecoration(labelText: "Username"),
//                 ),
//                 SizedBox(height: 40),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.deepOrangeAccent),
//                   onPressed: () {
//                     context.read<AuthService>().register(
//                           email: emailController.text.trim(),
//                           password: passwordController.text.trim(),
//                         );
//                   },
//                   child: Text("Register"),
//                 ),

// A new home for your coffee stamps
//
