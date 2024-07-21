import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({super.key});

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello ,",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(143, 174, 241, 1),
                    ),
                  ),
                  Text(
                    "Bharat ",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color.fromRGBO(53, 112, 236, 1),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 40,
                      color: Color.fromRGBO(248, 230, 230, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white,
                    strokeAlign: 1,
                  ),
                ),
                child: Icon(
                  Icons.search,
                  color: Color.fromRGBO(209, 223, 253, 1),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Text(
              "Your Featured Stories",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(53, 112, 236, 1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
