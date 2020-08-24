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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          koukiconAirplay,
          SizedBox(height: 8),
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
