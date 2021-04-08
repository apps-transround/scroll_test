/// Flutter code sample for RotationTransition
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/paintEvent.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Paint recorder',
      home: RainbowShamer(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class RainbowShamer extends StatefulWidget {
  const RainbowShamer({Key? key}) : super(key: key);

  @override
  _RainbowShamerState createState() => _RainbowShamerState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _RainbowShamerState extends State<RainbowShamer> with TickerProviderStateMixin {
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
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Rotating animation'),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('A'),
          // ),
          Center(
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
