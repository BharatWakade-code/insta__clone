import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/utils/colors.dart';

class Navbar_Home extends StatefulWidget {
  const Navbar_Home({super.key});

  @override
  State<Navbar_Home> createState() => _Navbar_HomeState();
}

class _Navbar_HomeState extends State<Navbar_Home> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: MediaQuery.sizeOf(context).width * 0.93,
        child: TextField(
          decoration: InputDecoration(
            labelText: "Search",
            hintStyle: TextStyle(
              color: Colors.blueAccent,
            ),
            prefixIcon: Icon(Icons.search),
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 10.0),
                borderRadius: BorderRadius.circular(25.0)),
          ),
        ),
      )
    ]);
  }
}
