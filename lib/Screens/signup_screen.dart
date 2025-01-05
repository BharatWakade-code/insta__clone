import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/Components/login_text_field.dart';
import 'package:insta_clone/Screens/home/home_screen.dart';
import 'package:insta_clone/resources/auth_methods_services.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  final void Function()? ontap;

  const SignupScreen({super.key, required this.ontap});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controller
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void signUpUser() async {
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ShowErrorMsg("Passwords do not match. Enter again!");
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      String res = await AuthMethods().signUpUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        username: usernameController.text.trim(),
        bio: bioController.text.trim(),
        file: _image!,
      );

      if (res == "Success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ShowErrorMsg(res);
      }
    } on FirebaseAuthException catch (e) {
      ShowErrorMsg(e.message ?? "An error occurred. Please try again.");
    } catch (e) {
      ShowErrorMsg("An error occurred. Please try again.");
    }
    setState(() {
      _isLoading = false;
    });
  }

  void ShowErrorMsg(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void selectimage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    scale: 3,
                  ),
                  //  const SizedBox(height: 16),
                  // Welcome Text
                  const Text(
                    "Join Us Today!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    "Create your account to get started.",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(_image!),
                              radius: 64,
                            )
                          : const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/profile.jpeg'),
                              radius: 64,
                            ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: GestureDetector(
                          onTap: selectimage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // TextFields
                  MyTextField(
                    controller: usernameController,
                    hintText: "Username",
                    obscureText: false,
                    textInputStyle: TextInputType.text,
                    isPass: false,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: emailController,
                    hintText: "Email Address",
                    obscureText: false,
                    textInputStyle: TextInputType.emailAddress,
                    isPass: false,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    textInputStyle: TextInputType.visiblePassword,
                    isPass: true,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    textInputStyle: TextInputType.visiblePassword,
                    isPass: true,
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: bioController,
                    hintText: "Short Bio (Optional)",
                    obscureText: false,
                    textInputStyle: TextInputType.text,
                    isPass: false,
                  ),
                  const SizedBox(height: 32),
                  // Sign Up Button
                  GestureDetector(
                    onTap: signUpUser,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: !_isLoading
                          ? const Text(
                              "Sign Up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a Member?"),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.blue,
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
}
