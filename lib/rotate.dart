/// Flutter code sample for RotationTransition
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/paintEvent.dart';
import 'package:scroll_test/smart_widget.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
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
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  // ..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
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
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    iterate();
                  },
                  child: Text(
                    'right',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
              TextButton(
                  onPressed: () {
                    PaintEventHandler.summarize();
                  },
                  child: Text(
                    'right',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
            ],
          ),
          Row(
            children: [
              Text('A'),
            ],
          ),
          Row(
            children: [
              Text('A'),
            ],
          ),
          RepaintBoundary(child: Text('A')),
          SmartWidget(child: Text('SMArt')),
          Text('A'),
          Center(
            child: RotationTransition(
              turns: _animation,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FlutterLogo(size: 100.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> iterate() async {
    // PaintEventHandler.reset();
    _controller.reset();
    await _controller.forward();

    PaintEventHandler.dump();
  }
}