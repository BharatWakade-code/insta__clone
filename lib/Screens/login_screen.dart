
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/Components/login_signup_btn.dart';
import 'package:insta_clone/Components/login_text_field.dart';
import 'package:insta_clone/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  void Function()? ontap;
  LoginScreen({super.key, required this.ontap});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Sign In Method
  void signInUser() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ShowErrorMsg(e.code);
    }
  }
  //ShowErrorMsg

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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // Logo
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              SizedBox(height: 30),
              // Username
              MyTextField(
                controller: emailController,
                hintText: "Enter Your email",
                obscureText: false,
                textInputStyle: TextInputType.emailAddress,
                isPass: false,
              ),
              SizedBox(height: 10),
              // Password
              MyTextField(
                controller: passwordController,
                hintText: "Enter your passWord",
                obscureText: true,
                textInputStyle: TextInputType.emailAddress,
                isPass: false,
              ),
              SizedBox(height: 40),
              // Sign In Button
              LoginOrSignBtn(
                ontap: signInUser,
                text: "Sign In",
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't Have a acccount?"),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: widget.ontap,
                    child: Container(
                      child: Text(
                        " Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
