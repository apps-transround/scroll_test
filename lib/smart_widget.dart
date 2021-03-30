import 'package:flutter/material.dart';

class SmartWidget extends StatelessWidget {
  final Widget child;

  const SmartWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(context.findRenderObject()!.toStringShort());
      },
      child: child,
    );
  }
}
