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
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: DropdownButton<LogLevel>(
            onChanged: (value) {
              setState(() {
                debugRepaintLogLevel = value ?? LogLevel.none;
              });
            },
            items: LogLevel.values.map<DropdownMenuItem<LogLevel>>((LogLevel value) {
              return DropdownMenuItem<LogLevel>(
                value: value,
                child: Text((value.toString())),
              );
            }).toList(),
            value: debugRepaintLogLevel,
          ),
        ),
        Expanded(
          child: ExpansionTile(
            title: SizedBox(
              width: 120,
              child: CheckboxListTile(
                title: Text('Show paint info'),
                onChanged: (bool? value) {
                  setState(() {
                    debugRepaintRainbowEnabled = !debugRepaintRainbowEnabled;
                  });
                },
                value: debugRepaintRainbowEnabled,
              ),
            ),
            children: [Text('instructions...')],
          ),
        ),
      ],
    );
  }
}
