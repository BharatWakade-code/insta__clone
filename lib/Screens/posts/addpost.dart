import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/providers/user_provider.dart';
import 'package:insta_clone/resources/firestore_methods.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController discriptioncontroller = TextEditingController();
  Uint8List? _file;
  bool isLoading = false;

  _selectimage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Add a Post"),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Choose From gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    userProvider.refreshUser();

    void postImage(String uid, String username, String profImage) async {
      try {
        setState(() {
          isLoading = true;
        });
        String res = await FirebaseMethods().uploadPost(
            discriptioncontroller.text, _file!, uid, username, profImage);
        if (res == "success") {
          setState(() {
            isLoading = false;
          });
          showSnackBar('Posted', context);
        } else {
          setState(() {
            isLoading = false;
          });
          showSnackBar('Error in Posting', context);
        }
      } catch (e) {
        e.toString();
      }
    }

    void clearImage() {
      setState(() {
        _file = null;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        actions: [
          TextButton(
            onPressed: () {
              postImage(
                userProvider.getUser.uid,
                userProvider.getUser.username,
                userProvider.getUser.photoUrl,
              );
            },
            child: const Text(
              "Post",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontSize: 16),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: isLoading ? const LinearProgressIndicator() : Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.jpeg'),
                  radius: 30,
                ),
                Container(
                  height: 80,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  color: mobileBackgroundColor,
                  child: TextField(
                    controller: discriptioncontroller,
                    decoration: const InputDecoration(
                      hintText: "Write a caption.....",
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => _selectimage(context),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    style: BorderStyle.solid,
                    width: BorderSide.strokeAlignCenter,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: _file == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/profile.jpeg', // Default image path
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: MemoryImage(_file!),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 80,
              width: MediaQuery.sizeOf(context).width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                color: mobileBackgroundColor,
                boxShadow: List.filled(10, BoxShadow(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
