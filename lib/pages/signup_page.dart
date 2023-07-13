import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/services/auth_service.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/squaretile.dart';

class SignUpPage extends StatefulWidget {
  final Function()? toggleView;
  const SignUpPage({super.key, required this.toggleView});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  void signUp() async {
    try {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        FirebaseFirestore.instance
            .collection("users")
            .doc(usercredential.user!.email)
            .set({
          "email": usercredential.user!.email,
          "uid": usercredential.user!.uid,
          "username": usercredential.user!.email!.split("@")[0],
          "bio": "empty bio",
        });

        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(child: const Text("Something went wrong!")),
            content: const Text("Passwords do not match!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(child: const Text("Something went wrong!")),
          content: Text(e.message!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                //logo
                SizedBox(
                  height: 50,
                ),

                Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.grey[700],
                ),
                SizedBox(
                  height: 50,
                ),

                //welcome text
                Text(
                  "Welcome back to The Wall!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

                //email textfield
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),

                //password textfield
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPasswordController,
                ),

                //login button

                SizedBox(
                  height: 10,
                ),

                MyButton(
                  text: "Sign Up",
                  onTap: signUp,
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[700],
                        thickness: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("Or Continue with"),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[700],
                        thickness: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      file: "lib/icons/google.png",
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SquareTile(
                      onTap: () {
                        AuthService().signInWithGithub();
                      },
                      file: "lib/icons/github.png",
                    ),
                  ],
                ),

                //terms and conditions
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[800],
                    enableFeedback: false,
                    backgroundColor: Colors.transparent,
                    // splashFactory: NoSplash.splashFactory
                    disabledBackgroundColor: Colors.transparent,
                    disabledForegroundColor: Colors.transparent,
                  ),
                  onPressed: widget.toggleView,
                  child: Text(
                    "Already have an account? Login",
                  ),
                ),

                //privacy policy

                //version number
              ],
            ),
          ),
        ),
      ),
    );
  }
}
