import 'package:flutter/material.dart';
import 'package:scroll_test/paintEvent.dart';

enum EventMode { record, playback, interactive, none }

class SmartWidget extends StatefulWidget {
  final Widget child;
  final EventMode eventMode;

  const SmartWidget({Key? key, required this.child, this.eventMode = EventMode.record}) : super(key: key);

  @override
  _SmartWidgetState createState() => _SmartWidgetState();
}

class _SmartWidgetState extends State<SmartWidget> {
  PaintEvent? lastEvent;

  @override
  Widget build(BuildContext context) {
    switch (widget.eventMode) {
      case EventMode.interactive:
        return GestureDetector(
          onTap: () {
            print(context.findRenderObject()!.toStringShort());
          },
          child: widget.child,
        );

      case EventMode.record:
      case EventMode.none:
        return widget.child;
      case EventMode.playback:
        return StreamBuilder<PaintEvent>(
            stream: PaintEventHandler.replaySubject,
            builder: (context, snapshot) {
              PaintEvent? tmpEvent = snapshot.data;

              if (snapshot.data == null) return widget.child;
              // if (snapshot.data.id = )

              return Container();
            });
    }
  }
}
