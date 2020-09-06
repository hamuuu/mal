import 'package:flutter/material.dart';
import 'package:mal/component/carousel.dart';
import 'package:mal/component/home_menu.dart';
import 'package:mal/component/welcome.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          Stack(
            children: [
              Positioned.fill(
                top: 10,
                child: Image.asset(
                  'assets/rainbow.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Carousel(),
            ],
          ),
          Divider(
            color: Colors.grey[400],
          ),
          HomeMenu(),
          Divider(
            color: Colors.grey[400],
          ),
          Welcome(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
