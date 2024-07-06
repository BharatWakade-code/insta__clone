import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    void postImage(String uid, String username, String profImage) async {
      try {
        String res = await FirebaseMethods().uploadPost(
            discriptioncontroller.text, _file!, uid, username, profImage);
        if (res == "success") {
          showSnackBar('Posted', context);
        } else {
          showSnackBar('Error in Posting', context);
        }
      } catch (e) {
        e.toString();
      }
    }

    return _file == null
        ? Center(
            child: IconButton(
              icon: Icon(Icons.upload),
              onPressed: () => _selectimage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                "Post to",
                style: TextStyle(fontSize: 16),
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
                    ))
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpeg'),
                      radius: 30,
                    ),
                    Container(
                      height: 80,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      color: mobileBackgroundColor,
                      child: TextField(
                        selectionHeightStyle:
                            BoxHeightStyle.includeLineSpacingBottom,
                        controller: discriptioncontroller,
                        decoration: InputDecoration(
                          hintText: "Write a caption.....",
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: Image(image: MemoryImage(_file!)),
                )
              ],
            ),
          );
  }
}
