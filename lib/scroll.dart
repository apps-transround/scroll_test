/// Flutter code sample for RotationTransition
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/paintEvent.dart';
import 'package:scroll_test/playback_control.dart';
import 'package:scroll_test/smart_widget.dart';
import 'package:scroll_test/two_way_scroll_widget.dart';

/// This is the stateful widget that the main application instantiates.
class ScrollPaintTest extends StatefulWidget {
  const ScrollPaintTest({Key? key}) : super(key: key);

  @override
  _ScrollPaintTestState createState() => _ScrollPaintTestState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _ScrollPaintTestState extends State<ScrollPaintTest> with TickerProviderStateMixin {
  final int rowCount = 20;
  final int columnCount = 12;
  ScrollController leftScrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          PlaybackControl(
            onRecord: () {
              setState(() {});
              iterate(leftScrollController);
            },
            onPlay: () {
              setState(() {});
            },
          ),
          TwoWayScroll(
            scrollController: leftScrollController,
            rowCount: rowCount,
            columnCount: columnCount,
            fancy: false,
            key: Key('left'),
          ),
        ],
      ),
    );
  }

  Future<void> iterate(ScrollController scrollController) async {
    PaintEventHandler.reset();
    await scrollController.animateTo(1000, duration: Duration(milliseconds: 500), curve: Curves.linear);
    // for (num i = 1; i < 2; i = i + 1) {
    //   await Future.delayed(Duration(seconds: 1));
    //   // repaintMap.clear();
    //   // await scrollController.animateTo(5 + 0.0, duration: Duration(milliseconds: 200), curve: Curves.linear);
    //   // print(repaintMap.length);
    //   // print(repaintMap.toString().replaceAll(',', '\n'));
    // }
    print('REEEEADY');
    PaintEventHandler.eventMode = EventMode.none;
    // PaintEventHandler.playBack();
    // PaintEventHandler.dump();
  }
}
