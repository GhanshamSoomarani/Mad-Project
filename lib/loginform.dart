import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad/homeStudent.dart';
import 'package:mad/homeTeacher.dart';
import 'authService.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  CollectionReference unimail =
      FirebaseFirestore.instance.collection("unimail");

  signIn() async {
    final AuthService authService = AuthService();
    User? user = await authService.signIn(
      context,
      _emailController.text,
      _passwordController.text,
    );

    if (user != null) {
      await unimail.add({
        "email": _emailController.text,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("login successfull")));

      if (user.email!.contains('@teachers')) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeTeacher()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeStudent()));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("login failed")));
    }
  }

  signUp() async {
    final AuthService authService = AuthService();
    final info = await authService.signUp(
      _emailController.text,
      _passwordController.text,
    );
    await unimail.add({
      "email": _emailController.text,
    });
    if (info != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "info",
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mehran University"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/muet.png',
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 40.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'University Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                signIn();
              },
              child: const Text('SignIn'),
            ),
          ],
        ),
      ),
    );
  }
}
