import 'package:flutter/material.dart';
import 'package:scroll_test/cell_widget_paint.dart';

import 'cell_widget.dart';

class TwoWayScroll extends StatelessWidget {
  final Widget child;
  final int rowCount;
  final int columnCount;
  final bool fancy;

  const TwoWayScroll({Key key, this.child, this.rowCount = 30, this.columnCount = 30, this.fancy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShapesPainter shapesPainter = ShapesPainter();
    return Expanded(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        ...List.generate(
          rowCount,
          (int i) => Row(children: [
            ...List.generate(
              columnCount,
              (int j) => CellWidgetPaint(
                // child: CellWidget(
                // key: Key('i-j'),
                row: i,
                column: j,
                fancy: fancy, shapesPainter: shapesPainter,
              ),
            ),
          ]),
        ),
      ])),
    ));
    // child: ListView(children: <Widget>[
    //   ...List.generate(
    //     rowCount,
    //     (int i) => SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Row(children: [
    //         ...List.generate(
    //           columnCount,
    //           (int j) => Container(
    //             width: 100,
    //             height: 80,
    //             child: CellWidget(
    //               row: i,
    //               column: j,
    //               fancy: fancy,
    //             ),
    //           ),
    //         ),
    //       ]),
    //     ),
    //   ),
    // ]),
    // );
  }
}
