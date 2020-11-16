import 'package:flutter/material.dart';
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
  int rowCount = 15;

  int columnCount = 1;

  ScrollController leftScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // showPerformanceOverlay: true,
        home: Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onDoubleTap: () async {},
            onTap: () async {
              iterate();
              // print(PaintingContext.repaints);
            },
            child: Text('Two-way scroll: right with RepaintBoundary')),
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
          // TwoWayScroll(
          //   rowCount: rowCount,
          //   columnCount: columnCount,
          //   fancy: true,
          //   key: Key('right'),
          // ),
        ],
      ),
    ));
  }

  Future<void> iterate() async {
    setState(() {
      rowCount = 1;
    });
    for (num i = 5; i < 50; i = i + 5) {
      await leftScrollController.animateTo(0, duration: Duration(milliseconds: 10), curve: Curves.linear);
      setState(() {
        rowCount = i;
      });
      await Future.delayed(Duration(seconds: 1));
      PaintingContext.repaints.clear();
      await leftScrollController.animateTo(5 + 0.0, duration: Duration(milliseconds: 2000), curve: Curves.linear);
      num sum = 0;
      PaintingContext.repaints.forEach((key, value) {
        sum += value;
      });
      // print('$i: ${PaintingContext.repaints['RenderConstrainedBox']} : $sum');
      print('$i: ${PaintingContext.repaints.length} : ${(sum / 5 / rowCount).round()}  ');
    }
  }
}

/*
  static Map<String, num> repaints = Map();

  void paintChild(RenderObject child, Offset offset) {
    assert(() {
      if (debugProfilePaintsEnabled)
        Timeline.startSync('${child.runtimeType}', arguments: timelineArgumentsIndicatingLandmarkEvent);
      if (debugOnProfilePaint != null)
        debugOnProfilePaint!(child);
      return true;
    }());

    if (child.isRepaintBoundary //|| !(child?._needsPaint ?? true)
    ) {
      stopRecordingIfNeeded();
      _compositeChild(child, offset);
    } else {
      String key = '${objectRuntimeType(child, '<optimized out>')} ${shortHash(child)} ${child._needsPaint}'; //#${shortHash(child)}';
      repaints[key] =  (repaints[key] ?? 0) + 1;
      child._paintWithContext(this, offset);
    }

    assert(() {
      if (debugProfilePaintsEnabled)
        Timeline.finishSync();
      return true;
    }());
  }

 */
