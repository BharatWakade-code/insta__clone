import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Screens/Chat/components/nav_bar.dart';
import 'package:insta_clone/Screens/posts/addpost_cubit.dart';
import 'package:insta_clone/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddpostCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const NavBar(
        pageName: 'Add Post',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<AddpostCubit, AddpostState>(
          listener: (context, state) {
            if (state is Addpostloaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Post added successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              descriptionController.clear();
            } else if (state is AddpostError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Post Upload Error'),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is Imageloaded) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image loaded'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                state is Addpostloading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: LinearProgressIndicator(),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text("Add a Post"),
                        children: [
                          SimpleDialogOption(
                            padding: const EdgeInsets.all(20),
                            child: const Text('Take a photo'),
                            onPressed: () async {
                              cubit.captureimage();
                            },
                          ),
                          SimpleDialogOption(
                            padding: const EdgeInsets.all(20),
                            child: const Text('Choose From gallery'),
                            onPressed: () async {
                              cubit.pickimage();
                            },
                          ),
                          SimpleDialogOption(
                            padding: const EdgeInsets.all(20),
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      );
                    },
                  ),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(15),
                      image: cubit.file != null
                          ? DecorationImage(
                              image: MemoryImage(cubit.file!),
                              fit: BoxFit.contain,
                            )
                          : null,
                      border: Border.all(
                        color: Colors.grey[700]!,
                      ),
                    ),
                    child: cubit.file == null
                        ? const Center(
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.grey,
                              size: 50,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpeg'),
                      radius: 30,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Write a caption...",
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    cubit.postImage(descriptionController.text);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
