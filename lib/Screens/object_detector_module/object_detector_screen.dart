import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Screens/object_detector_module/object_detector_cubit.dart';

class ObjectDetectorScreen extends StatefulWidget {
  const ObjectDetectorScreen({super.key});

  @override
  State<ObjectDetectorScreen> createState() => _ObjectDetectorScreenState();
}

class _ObjectDetectorScreenState extends State<ObjectDetectorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ObjectDetectorCubit, ObjectDetectorState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column();
        },
      ),
    );
  }
}
