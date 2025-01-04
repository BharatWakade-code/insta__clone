import 'package:flutter/material.dart';

class SelfMessages extends StatefulWidget {
  const SelfMessages({super.key});

  @override
  State<SelfMessages> createState() => _SelfMessagesState();
}

class _SelfMessagesState extends State<SelfMessages> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(16.0), // Adjust the radius values as needed
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(114, 16, 255, 1),
                  Color.fromRGBO(157, 89, 255, 1),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child:  Row(
                children: [
                  Text(
                    'Hii ..Sisko',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'UrbanistRegular',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
