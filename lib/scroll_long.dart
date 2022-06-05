/// Flutter code sample for RotationTransition
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/paintEvent.dart';
import 'package:scroll_test/playback_control.dart';
import 'package:scroll_test/smart_widget.dart';
import 'package:scroll_test/two_way_scroll_widget.dart';

import 'demo_control.dart';

/// This is the stateful widget that the main application instantiates.
class ScrollLong extends StatefulWidget {
  const ScrollLong({Key? key}) : super(key: key);

  @override
  _ScrollLongState createState() => _ScrollLongState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _ScrollLongState extends State<ScrollLong> {
  final int rowCount = 200;
  final int columnCount = 12;
  ScrollController leftScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // PlaybackControl(
          //   onRecord: () {
          //     setState(() {});
          //     iterate(leftScrollController);
          //   },
          //   onPlay: () {
          //     setState(() {});
          //   },
          // ),
          DemoControl(),
          Expanded(
            child: SingleChildScrollView(
                controller: leftScrollController,
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
                        SizedBox(
                      width: 400,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            border: Border(
                              top: BorderSide(color: Colors.black, style: BorderStyle.solid, width: 10),
                            )),
                        child: Row(
                          children: [
                            Text('$i'),
                            Image.network(
                              'https://storage.googleapis.com/cms-storage-bucket/images/stacking_dash_blog_image.width-635.png',
                              width: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ])),
          )
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
