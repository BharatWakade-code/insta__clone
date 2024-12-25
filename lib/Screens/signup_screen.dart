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

  SignupScreen({super.key, required this.ontap});

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
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ShowErrorMsg(res);
      }

      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      ShowErrorMsg(e.message ?? "An error occurred. Please try again.");
    } catch (e) {
      ShowErrorMsg("An error occurred. Please try again.");
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

  // OnPickedImage
  void selectimage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                // Logo
                Image.asset(
                  'assets/images/app_logo.png',
                  color: Colors.white,
                  height: 64,
                ),
                SizedBox(height: 20),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(_image!),
                            radius: 64,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profile.jpeg'),
                            radius: 64,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectimage,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Username
                MyTextField(
                  controller: usernameController,
                  hintText: "Enter your username",
                  obscureText: false,
                  textInputStyle: TextInputType.text,
                  isPass: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  obscureText: false,
                  textInputStyle: TextInputType.emailAddress,
                  isPass: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  obscureText: true,
                  textInputStyle: TextInputType.visiblePassword,
                  isPass: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm your password",
                  obscureText: true,
                  textInputStyle: TextInputType.visiblePassword,
                  isPass: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: bioController,
                  hintText: "Enter your bio",
                  obscureText: false,
                  textInputStyle: TextInputType.text,
                  isPass: false,
                ),
                const SizedBox(height: 40),
                // Sign Up Button
                GestureDetector(
                  onTap: signUpUser,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Center(
                      child: !_isLoading
                          ? const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a Member?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: Text(
                        "Log in Now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
