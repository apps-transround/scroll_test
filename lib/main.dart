import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/paintEvent.dart';
import 'package:scroll_test/rotate.dart';
import 'package:scroll_test/scroll.dart';
import 'package:scroll_test/two_way_scroll_widget.dart';

void main() {
  // debugPaintLayerBordersEnabled = true;
  debugRepaintRainbowEnabled = true;
  debugRepaintLogLevel = LogLevel.benchmark;
  runApp(
    MaterialApp(
      home: RotateTest(),
      // home: ScrollPaintTest(),
      //   home: RainbowShamer(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class ScrollTest extends StatefulWidget {
  @override
  _ScrollTestState createState() => _ScrollTestState();
}

class _ScrollTestState extends State<ScrollTest> {
  final int rowCount = 20;

  final int columnCount = 17;

  ScrollController leftScrollController = ScrollController();

  ScrollController rightScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                // print(repaintSkipMap);
                // print(repaintMap.toString().replaceAll(',', '\n'));
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
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RotateTest()));
                      },
                      child: Text(
                        'rotate',
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
      ),
    );
  }

  Future<void> iterate(ScrollController scrollController) async {
    for (num i = 1; i < 2; i = i + 1) {
      await scrollController.animateTo(0, duration: Duration(milliseconds: 10), curve: Curves.linear);
      await Future.delayed(Duration(seconds: 1));
      // repaintMap.clear();
      // await scrollController.animateTo(5 + 0.0, duration: Duration(milliseconds: 200), curve: Curves.linear);
      // print(repaintMap.length);
      // print(repaintMap.toString().replaceAll(',', '\n'));
    }
  }
}
