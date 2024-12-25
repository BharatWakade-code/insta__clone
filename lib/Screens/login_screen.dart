import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Components/login_text_field.dart';
import 'package:insta_clone/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? ontap;
  LoginScreen({Key? key, required this.ontap}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  void signInUser() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      ShowErrorMsg(e.message ?? "An error occurred");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void ShowErrorMsg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: 80,
                  ),
                  const SizedBox(height: 60),
                  // Welcome Text
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Log in to your account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Email Input
                  MyTextField(
                    controller: emailController,
                    hintText: "Enter your email",
                    obscureText: false,
                    textInputStyle: TextInputType.emailAddress,
                    isPass: false,
                  ),
                  const SizedBox(height: 20),
                  // Password Input
                  MyTextField(
                    controller: passwordController,
                    hintText: "Enter your password",
                    obscureText: true,
                    textInputStyle: TextInputType.visiblePassword,
                    isPass: true,
                  ),
                  const SizedBox(height: 40),
                  // Sign In Button
                  GestureDetector(
                    onTap: signInUser,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: !_isLoading
                          ? const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: const Text(
                          " Sign Up",
                          style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
