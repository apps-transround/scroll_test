import 'package:flutter/rendering.dart';

class RenderPaintMeasure extends RenderProxyBox {
  RenderPaintMeasure({
    this.measurePaint = true,
    RenderBox? child,
  }) : super(child);

  bool measurePaint;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('MeasurePaint', measurePaint));
  }
}
