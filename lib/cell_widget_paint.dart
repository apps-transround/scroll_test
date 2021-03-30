import 'package:flutter/material.dart';

class CellWidgetPaint extends StatelessWidget {
  final int? row;
  final int? column;
  final bool fancy;
  final ShapesPainter? shapesPainter;
  final double width = 100;
  final double height = 80;

  const CellWidgetPaint({Key? key, this.row, this.column, this.fancy = true, this.shapesPainter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: fancy ? Colors.green.shade100 : Colors.red.shade100,
            border: Border(
              top: BorderSide(),
            )),
        child: Text(
          'Dummy cell content: $row - $column',
          // style: Theme.of(context).textTheme.bodyText2,
        ));
    // return Container(
    //   width: width,
    //   height: height,
    //   child: CustomPaint(
    //     isComplex: true,
    //     child: Text(
    //       'Dummy cell content: $row - $column',
    //       // style: Theme.of(context).textTheme.bodyText2,
    //     ),
    //     // painter: ShapesPainter(),
    //     painter: shapesPainter,
    //   ),
    // );
  }
}

class ShapesPainter extends CustomPainter {
  final painter = Paint();
  int i = 0;
  @override
  void paint(Canvas canvas, Size size) {
    if (i++ % 1000 == 0) print('ShapesPainter $i');

    painter.color = Colors.deepOrange;
    canvas.drawLine(const Offset(0.0, 0.0), Offset(size.width, 0.0), painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
