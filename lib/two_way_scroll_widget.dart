import 'package:flutter/material.dart';
import 'package:scroll_test/cell_widget_paint.dart';
import 'package:scroll_test/smart_widget.dart';

class TwoWayScroll extends StatelessWidget {
  final Widget? child;
  final int rowCount;
  final int columnCount;
  final bool fancy;
  final ScrollController? scrollController;

  const TwoWayScroll(
      {Key? key, this.child, this.rowCount = 30, this.columnCount = 20, this.fancy = true, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShapesPainter shapesPainter = ShapesPainter();
    return Expanded(
      child: SingleChildScrollView(
          controller: scrollController,
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            ...List.generate(
              rowCount,
              (int i) =>
                  // fancy
                  //     ? RepaintBoundary(
                  //         key: Key('rp-$i'),
                  //         child: generateRow(i),
                  //       )
                  //     :
                  generateRow(i),
            ),
          ])),
    );
  }

  Widget generateRow(int rowNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      // key: Key('row-$rowNumber'),
      children: [
        ...List.generate(
          columnCount,
          (int j) => fancy
              ? RepaintBoundary(
                  // key: Key('rp$rowNumber-$j'),
                  child: CellWidgetPaint(key: Key('$rowNumber-$j'), row: rowNumber, column: j, fancy: fancy),
                )
              : CellWidgetPaint(key: Key('$rowNumber-$j'), row: rowNumber, column: j, fancy: fancy),
        ),
      ],
    );
  }
}
