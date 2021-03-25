import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/two_way_scroll_widget.dart';

void main() {
  runApp(
    ScrollTest(),
  );
}

class ScrollTest extends StatefulWidget {
  @override
  _ScrollTestState createState() => _ScrollTestState();
}

class _ScrollTestState extends State<ScrollTest> {
  final int rowCount = 20;

  final int columnCount = 10;

  ScrollController leftScrollController = ScrollController();

  ScrollController rightScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // showPerformanceOverlay: true,
        home: Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              // print(repaintSkipMap);
              print(repaintMap.toString().replaceAll(',', '\n'));
            },
            child: Row(
              children: [
                Text('Two-way scroll: right with RepaintBoundary'),
                TextButton(
                    onPressed: () {
                      iterate(leftScrollController);
                    },
                    child: Text(
                      'left',
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                TextButton(
                    onPressed: () {
                      iterate(rightScrollController);
                    },
                    child: Text(
                      'right',
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
              ],
            )),
      ),
      body: Row(
        children: [
          TwoWayScroll(
            scrollController: leftScrollController,
            rowCount: rowCount,
            columnCount: columnCount,
            fancy: false,
            key: Key('left'),
          ),
          TwoWayScroll(
            scrollController: rightScrollController,
            rowCount: rowCount,
            columnCount: columnCount,
            fancy: true,
            key: Key('right'),
          ),
        ],
      ),
    ));
  }

  Future<void> iterate(ScrollController scrollController) async {
    for (num i = 41; i < 50; i = i + 5) {
      await scrollController.animateTo(0, duration: Duration(milliseconds: 10), curve: Curves.linear);
      await Future.delayed(Duration(seconds: 1));
      repaintMap.clear();
      await scrollController.animateTo(5 + 0.0, duration: Duration(milliseconds: 200), curve: Curves.linear);
      print(repaintMap.length);
      print(repaintMap.toString().replaceAll(',', '\n'));
    }
  }
}
