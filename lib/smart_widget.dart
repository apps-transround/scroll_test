import 'package:flutter/material.dart';
import 'package:scroll_test/paintEvent.dart';

enum EventMode { record, playback, interactive, none }

class SmartWidget extends StatefulWidget {
  final Widget child;
  final EventMode eventMode;
  final Key key;

  const SmartWidget({required this.key, required this.child, this.eventMode = EventMode.record}) : super(key: key);

  @override
  _SmartWidgetState createState() => _SmartWidgetState();
}

class _SmartWidgetState extends State<SmartWidget> {
  PaintEvent lastEvent = PaintEvent();

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
        Future.delayed(Duration(seconds: 1), () {
          var a = context.findRenderObject();
          // String id = '${a.hashCode.toUnsigned(20).toRadixString(16).padLeft(5, '0')}';
          String id = '${a.runtimeType} ${a.hashCode.toUnsigned(20).toRadixString(16).padLeft(5, '0')}';
          PaintEventHandler.matchOne(widgetId: widget.key.toString(), renderId: id);
          print('$id: ${widget.key.toString()}');
        });
        return Container(child: widget.child);
      case EventMode.playback:
        return StreamBuilder<PaintEvent>(
            stream: PaintEventHandler.replaySubject,
            builder: (context, snapshot) {
              PaintEvent tmpEvent = snapshot.data ?? PaintEvent();
              if (tmpEvent.widgetId == widget.key.toString()) {
                lastEvent = tmpEvent;
              }
              print('${tmpEvent.toString()}');

              return Stack(
                children: [
                  widget.child,
                  Container(
                    // width: 20,
                    // height: 20,
                    color: lastEvent.eventType == PaintEventType.markPaintUp ? Colors.red : Colors.blue,
                    child: Text(lastEvent.eventType.toString()),
                  )
                ],
              );
            });
    }
  }
}
