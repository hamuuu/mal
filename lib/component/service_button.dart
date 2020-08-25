import 'package:flutter/material.dart';

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
              color: Colors.blue[200],
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
        Navigator.pushNamed(context, 'tvSeries');
      },
    );
  }
}
