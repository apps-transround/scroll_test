import 'package:flutter/material.dart';
import 'package:scroll_test/two_way_scroll_widget.dart';

void main() {
  runApp(
    ScrollTest(),
  );
}

class ScrollTest extends StatelessWidget {
  final int rowCount = 40;
  final int columnCount = 40;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // showPerformanceOverlay: true,
        home: Scaffold(
      appBar: AppBar(
        title: Text('Two-way scroll: right with RepaintBoundary'),
      ),
      body: Row(
        children: [
          TwoWayScroll(
            rowCount: rowCount,
            columnCount: columnCount,
            fancy: false,
            key: Key('left'),
          ),
          TwoWayScroll(
            rowCount: rowCount,
            columnCount: columnCount,
            fancy: true,
            key: Key('right'),
          ),
        ],
      ),
    ));
  }
}
