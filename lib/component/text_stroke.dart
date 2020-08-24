import 'package:flutter/material.dart';

class TextStroke extends StatelessWidget {
  final String description;
  final double size;
  final Color strokeColor;
  final Color fillColor;
  final double strokeWidth;

  const TextStroke({
    @required this.description,
    @required this.size,
    @required this.strokeColor,
    @required this.fillColor,
    @required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          description,
          maxLines: 4,
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          description,
          style: TextStyle(
            color: fillColor,
          ),
        ),
      ],
    );
  }
}
