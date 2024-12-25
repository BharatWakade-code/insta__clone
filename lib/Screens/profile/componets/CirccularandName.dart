import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Screens/Auth/cubit/auth_cubit.dart';

class CirccularandName extends StatefulWidget {
  const CirccularandName({super.key});

  @override
  State<CirccularandName> createState() => _CirccularandNameState();
}

class _CirccularandNameState extends State<CirccularandName> {
  @override
  void initState() {
    super.initState();   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/profile.jpeg',
                ),
                radius: 60,
              ),
              Positioned(
                bottom: 0,
                left: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_square,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "@Flash_Sisko",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'UrbanistBold',
              color: Colors.black,
            ),
          ),
          Text(
            "Flutter Developer",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'UrbanistRegular',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
