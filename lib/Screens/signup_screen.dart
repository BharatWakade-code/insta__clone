import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_clone/Components/login_signup_btn.dart';
import 'package:insta_clone/Components/login_text_field.dart';
import 'package:insta_clone/utils/colors.dart';

class SignupScreen extends StatefulWidget {
  void Function()? ontap;

  SignupScreen({super.key, required this.ontap});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign Up User
  void signUpUser() async {
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ShowErrorMsg("Passwords does not match , Enter Again !");
      return;
    }

    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ShowErrorMsg(e.code);
    }
  }

  // ShowErrorMsg
  void ShowErrorMsg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // Logo
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),

              Text("Welcome, You Can Register Here!"),
              const SizedBox(height: 30),
              // Email
              // MyTextField(
              //   controller: emailController,
              //   hintText: "Email",
              //   obscureText: false,
              // ),
              // SizedBox(height: 10),
              // // Password
              // MyTextField(
              //   controller: passwordController,
              //   hintText: "Password",
              //   obscureText: true,
              // ),
              SizedBox(height: 10),
              // Confirm Password
              // MyTextField(
              //   controller: confirmPasswordController,
              //   hintText: "Confirm Password",
              //   obscureText: true,
              // ),
              const SizedBox(height: 10),

              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Forgot Password")],
                ),
              ),
              const SizedBox(height: 10),
              // Sign Up Button
              LoginOrSignBtn(
                ontap: signUpUser,
                text: "Sign Up",
                
              ),
              SizedBox(height: 10),
              // Divider
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[500],
                      ),
                    ),
                    Text('Or Continue With',
                        style: TextStyle(color: Colors.grey[700])),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a Member?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.ontap,
                    child: Text(
                      "Log in Now",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
