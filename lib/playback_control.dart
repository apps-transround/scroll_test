import 'package:flutter/material.dart';
import 'package:scroll_test/paintEvent.dart';

class PlaybackControl extends StatefulWidget {
  final void Function()? onRecord;
  final void Function()? onPlay;
  final void Function()? onPause;
  final void Function()? onStop;

  const PlaybackControl({Key? key, this.onRecord, this.onPlay, this.onPause, this.onStop}) : super(key: key);

  @override
  _PlaybackControlState createState() => _PlaybackControlState();
}

class _PlaybackControlState extends State<PlaybackControl> {
  double sliderValue = PaintEventHandler.playbackZeitLuppe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              Icons.fiber_manual_record,
              color: Colors.red,
            ),
            onPressed: () {
              PaintEventHandler.eventMode = EventMode.record;
              widget.onRecord?.call();
            }),
        IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              PaintEventHandler.eventMode = EventMode.playback;
              PaintEventHandler.playBack();
              widget.onPlay?.call();
            }),
        IconButton(
            icon: Icon(Icons.pause),
            onPressed: () {
              PaintEventHandler.playbackMode = PlaybackMode.pause;
              widget.onPause?.call();
            }),
        IconButton(
            icon: Icon(Icons.stop),
            onPressed: () {
              PaintEventHandler.playbackMode = PlaybackMode.stop;
              widget.onStop?.call();
            }),
        StreamBuilder<int>(
            stream: PaintEventHandler.replayPositionSubject,
            builder: (context, snapshot) {
              double value = (snapshot.data ?? 0) + 0.0;
              if (value > PaintEventHandler.timeRange + 1.0) value = 0;
              return Row(
                children: [
                  Slider(
                      value: value,
                      min: 0,
                      max: PaintEventHandler.timeRange + 1.0,
                      // divisions: 5,
                      label: 'a',
                      onChanged: (v) {
                        setState(() {
                          sliderValue = v;
                          PaintEventHandler.setScn(v.truncate());
                          // PaintEventHandler.playbackZeitLuppe = v;
                        });
                      }),
                  Text('${((snapshot.data ?? 0) / 1000).truncate()} ms')
                ],
              );
            }),
        IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              PaintEventHandler.summarize();
            }),
      ],
    );
  }
}
