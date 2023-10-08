import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signIn(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        // Display a dialog to enter the user's name
        await _showNameDialog(context, userCredential.user!);
      } else {
        // Handle sign-in failure
        _showSignInFailedDialog(context);
      }

      return userCredential.user!;
    } catch (e) {
      print(e);
      _showSignInFailedDialog(context);
    }
    return null;
  }

  signOut() async {
    await firebaseAuth.signOut();
  }
}

Future<void> _showNameDialog(BuildContext context, User user) async {
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enter Your Name"),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Submit"),
            onPressed: () {
              String userName = nameController.text;
              // Close the dialog
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showSignInFailedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Sign-In Failed"),
        content: const Text("Invalid email or password. Please try again."),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
