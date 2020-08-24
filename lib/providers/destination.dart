import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final Color color;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.home, Colors.white),
  Destination('News', Icons.announcement, Colors.white),
  Destination('Forum', Icons.forum, Colors.white),
  Destination('Account', Icons.account_circle, Colors.white),
];
