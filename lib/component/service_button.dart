import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mal/providers/anime_list_provider.dart';
import 'package:provider/provider.dart';

class ServiceButton extends StatelessWidget {
  final Object koukiconAirplay;
  final String label;
  final String routeName;

  const ServiceButton({
    @required this.koukiconAirplay,
    @required this.label,
    @required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Colors.blue,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[100],
            ),
            child: koukiconAirplay,
          ),
          SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onPressed: () {
        if (label == "TV Series") {
          Provider.of<ListAnimeFilterProvider>(context).setType('tv');
        } else if (label == "Movie") {
          Provider.of<ListAnimeFilterProvider>(context).setType('movie');
        } else if (label == "OVA") {
          Provider.of<ListAnimeFilterProvider>(context).setType('ova');
        }
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
