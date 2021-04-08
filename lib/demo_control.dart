import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/paintEvent.dart';

class DemoControl extends StatefulWidget {
  final void Function()? onRecord;
  final void Function()? onPlay;
  final void Function()? onPause;
  final void Function()? onStop;

  const DemoControl({Key? key, this.onRecord, this.onPlay, this.onPause, this.onStop}) : super(key: key);

  @override
  _DemoControlState createState() => _DemoControlState();
}

class _DemoControlState extends State<DemoControl> {
  double sliderValue = PaintEventHandler.playbackZeitLuppe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            child: Text('Show paint info'),
            onPressed: () {
              debugRepaintRainbowEnabled = !debugRepaintRainbowEnabled;
            }),
      ],
    );
  }
}
