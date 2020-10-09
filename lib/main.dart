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
        title: Text('Two-way scroll 2'),
      ),
      body: Row(
        // mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TwoWayScroll(
            rowCount: rowCount,
            columnCount: columnCount,
            fancy: false,
          ),
          TwoWayScroll(
            rowCount: rowCount,
            columnCount: columnCount,
            fancy: true,
          ),
        ],
      ),
    ));
  }
}
