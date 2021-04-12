import 'package:flutter/rendering.dart';

class RenderPaintMeasure extends RenderBox {
  RenderPaintMeasure({
    this.measurePaint = true,
    RenderBox? child,
  });

  bool measurePaint;

  @override
  void performLayout() {
    return;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('MeasurePaint', measurePaint));
  }
}
