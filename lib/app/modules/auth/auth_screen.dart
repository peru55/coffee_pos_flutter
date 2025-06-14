import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class AuthScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Coffee POS Login', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call Supabase Auth login here
                  authController.login(emailController.text.trim(), passwordController.text);
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: Text("POS Login")),
//     body: Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
//           TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               authController.login(emailController.text.trim(), passwordController.text);
//             },
//             child: Text("Login"),
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }