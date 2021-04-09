/// Flutter code sample for RotationTransition
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/demo_control.dart';
import 'package:scroll_test/paintEvent.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Paint recorder',
      home: RotateTest(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class RotateTest extends StatefulWidget {
  const RotateTest({Key? key}) : super(key: key);

  @override
  _RotateTestState createState() => _RotateTestState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _RotateTestState extends State<RotateTest> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  // ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  // ..repeat(reverse: true);
  late final Animation<double> _animation2 = CurvedAnimation(
    parent: _controller2,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Row(
            //   children: [
            //     PlaybackControl(
            //       onRecord: () {
            //         setState(() {});
            //         iterate();
            //       },
            //       onPlay: () {
            //         setState(() {});
            //       },
            //     ),
            //   ],
            // ),
            DemoControl(),
            RepaintBoundary(child: Text('A')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('SMArt'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('A'),
            ),
            // CustomPaint(
            //   size: Size(100, 20),
            //   painter: PaintMarker(),
            // ),

            Center(
              child: RepaintBoundary(
                child: GestureDetector(
                  onTap: () {
                    _controller.reset();
                    _controller.forward();
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: RotationTransition(
                      turns: _animation,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FlutterLogo(size: 100.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: GestureDetector(
                  onTap: () {
                    _controller2.reset();
                    _controller2.forward();
                  },
                  child: RotationTransition(
                    turns: _animation2,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FlutterLogo(size: 100.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> iterate() async {
    PaintEventHandler.reset();
    _controller.reset();
    await _controller.forward();
    print('REEEEADY');
    PaintEventHandler.eventMode = EventMode.none;
    // PaintEventHandler.playBack();
    // PaintEventHandler.dump();
  }
}

class PaintMarker extends CustomPainter {
  final List<PaintEvent>? paintEvents;

  const PaintMarker({Key? key, this.paintEvents});

  @override
  void paint(Canvas canvas, Size size) {
    int i = 0;
    final textPainter = TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: Colors.tealAccent,
          fontSize: 16.0,
        ),
        text: ' Testus',
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    // canvas.drawRect(
    //     Rect.fromLTWH(0.0, 0.0, size.width, size.height),
    //     Paint()
    //       ..strokeCap = StrokeCap.round
    //       ..color = Colors.black);

    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0.0, 0.0, size.width, size.height), Radius.circular(4.0)),
        Paint()
          ..strokeCap = StrokeCap.round
          ..color = Colors.black);
    textPainter.paint(canvas, Offset(0.0, 0.0));

    paintEvents?.forEach((element) {
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
