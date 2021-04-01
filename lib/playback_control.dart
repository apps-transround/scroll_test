import 'package:flutter/material.dart';
import 'package:scroll_test/paintEvent.dart';

class PlaybackControl extends StatefulWidget {
  @override
  _PlaybackControlState createState() => _PlaybackControlState();
}

class _PlaybackControlState extends State<PlaybackControl> {
  double sliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              // PaintEventHandler.playbackMode = PlaybackMode.run;
              PaintEventHandler.playBack();
            }),
        IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {
              PaintEventHandler.playbackMode = PlaybackMode.pause;
            }),
        IconButton(
            icon: Icon(Icons.stop),
            onPressed: () {
              PaintEventHandler.playbackMode = PlaybackMode.stop;
            }),
        Slider(
            value: sliderValue,
            min: 1,
            max: 1000,
            onChanged: (v) {
              setState(() {
                sliderValue = v;
                PaintEventHandler.playbackTickle = Duration(milliseconds: v.truncate());
              });
            }),
        Container(),
      ],
    );
  }
}
