import 'dart:math';

import 'package:flutter/material.dart';

class ExpensiveWidget extends StatelessWidget {
  final double width, height;

  const ExpensiveWidget({Key? key, this.width = 100, this.height = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('builddy');
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: Colors.orange.shade100),
      child: CustomPaint(
        isComplex: true,
        painter: ShapesPainter(width, height),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final double count = 20;
  final double width, height;
  final painter = Paint();

  ShapesPainter(this.width, this.height);

  @override
  void paint(Canvas canvas, Size size) {
    Random random = new Random();
    for (int j = 0; j < count; j++) {
      painter.color = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      canvas.drawLine(Offset(random.nextDouble() * width, random.nextDouble() * height),
          Offset(random.nextDouble() * width, random.nextDouble() * height), painter);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
