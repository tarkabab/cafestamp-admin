//     import 'package:flutter/material.dart';

// final List<Widget> _register = [
//       Text("Register", style: TextStyle(fontSize: 25)),
//       SizedBox(height: 20),
//       TextFormField(
//         controller: userNameController,
//         decoration: InputDecoration(labelText: "Username"),
//       ),
//       TextFormField(
//         controller: emailController,
//         decoration: InputDecoration(labelText: "Email"),
//         validator: (value) => null,
//       ),
//       TextFormField(
//         controller: passwordController,
//         obscureText: true,
//         decoration: InputDecoration(labelText: "Password"),
//         validator: (value) => null,
//       ),
//       SizedBox(height: 40),
//       ElevatedButton(
//         style: ElevatedButton.styleFrom(primary: Colors.deepOrangeAccent),
//         onPressed: () {
//           final authService = context.read<AuthService>();
//           final firestoreService = context.read<FirestoreService>();

//           final email = emailController.text.trim();
//           final password = passwordController.text.trim();

//           authService
//               .register(email: email, password: password)
//               .then((userCredentials) {
//             final String shopId = userCredentials!.user!.uid;
//             final String shopName = userNameController.value.text.trim();
//             final shop = Shop(shopId, shopName);
//             firestoreService.saveShop(shop);
//           });
//         },
//         child: Text("Register"),
//       ),
//     ];

// import 'package:coffee_admin/service/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class RegisterPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topRight,
//                 end: Alignment.bottomLeft,
//                 colors: [
//               Colors.deepPurple.shade300,
//               Colors.deepPurple.shade800
//             ])),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 40),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 40),
//                 Icon(Icons.account_circle, size: 70),
//                 SizedBox(height: 40),
//                 Text("Register", style: TextStyle(fontSize: 25)),
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: InputDecoration(labelText: "Username"),
//                 ),
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
//                     context.read<AuthService>().register(
//                           email: emailController.text.trim(),
//                           password: passwordController.text.trim(),
//                         );
//                   },
//                   child: Text("Register"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // A new home for your coffee stamps
// // 