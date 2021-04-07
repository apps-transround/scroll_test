import 'package:flutter/material.dart';
import 'package:scroll_test/paintEvent.dart';

class SmartWidget extends StatelessWidget {
  final Widget child;
  final Key key;

  SmartWidget({required this.key, required this.child}) : super(key: key);

  PaintEvent lastEvent = PaintEvent();
  List<PaintEvent> paintEvents = [];
  int highestPlayed = 0;
  late String id = key.toString();

  @override
  Widget build(BuildContext context) {
    switch (PaintEventHandler.eventMode) {
      case EventMode.interactive:
      case EventMode.none:
      // return GestureDetector(
      //   onTap: () {
      //     print(paintEvents);
      //     print(context.findRenderObject()!.toStringShort());
      //   },
      //   child: child,
      // );
      //
      case EventMode.record:
        paintEvents.clear();
        highestPlayed = 0;
        Future.delayed(Duration(seconds: 1), () {
          var a = context.findRenderObject();
          // String id = '${a.hashCode.toUnsigned(20).toRadixString(16).padLeft(5, '0')}';
          String id = '${a.runtimeType} ${a.hashCode.toUnsigned(20).toRadixString(16).padLeft(5, '0')}';
          PaintEventHandler.matchOne(widgetId: key.toString(), renderId: id);
          // print('$id: ${key.toString()}');
        });
        return child;
      case EventMode.playback:
        return StreamBuilder<PaintEvent>(
            stream: PaintEventHandler.replaySubjects[id],
            builder: (context, snapshot) {
              PaintEvent tmpEvent = snapshot.data ?? PaintEvent();
              if (tmpEvent.widgetId == key.toString()) {
                lastEvent = tmpEvent;
                if (highestPlayed < tmpEvent.timeStamp) {
                  paintEvents.add(tmpEvent);
                  highestPlayed = tmpEvent.timeStamp;
                }
              }
              // print('${tmpEvent.toString()}');

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  child,
                  // Container(
                  //   constraints: BoxConstraints(
                  //     minHeight: 20,
                  //     minWidth: 20,
                  //   ),
                  //   child: child,
                  // ),
                  CustomPaint(
                    size: Size(100, 40),
                    painter: PaintMarker(paintEvents: paintEvents),
                  ),
                  // Container(
                  //   // width: 20,
                  //   // height: 20,
                  //   color: colorsMap[lastEvent.eventType],
                  //   // child: Text(lastEvent.eventType.toString()),
                  // )
                ],
              );
            });
    }
  }
}

class PaintMarker extends CustomPainter {
  final List<PaintEvent> paintEvents;

  const PaintMarker({Key? key, required this.paintEvents});

  @override
  void paint(Canvas canvas, Size size) {
    int i = 0;
    paintEvents.forEach((element) {
      final p1 = Offset(i * 5, 0);
      final p2 = Offset(i * 5, 20);
      final paint = Paint()
        ..color = colorsMap[element.eventType] ?? Colors.red
        ..strokeWidth = 4;
      canvas.drawLine(p1, p2, paint);
      i++;
    });
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
