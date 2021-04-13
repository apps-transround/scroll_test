import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/render_paint_measure.dart';

class PaintMeasure extends SingleChildRenderObjectWidget {
  /// Creates a widget that insets its child.
  ///
  /// The [measurePaint] argument must not be null.
  const PaintMeasure({
    Key? key,
    this.measurePaint = true,
    Widget? child,
  }) : super(key: key, child: child);

  const PaintMeasure.disable({
    Key? key,
    this.measurePaint = false,
    Widget? child,
  }) : super(key: key, child: child);

  const PaintMeasure.enable({
    Key? key,
    this.measurePaint = true,
    Widget? child,
  }) : super(key: key, child: child);

  /// The amount of space by which to inset the child.
  final bool measurePaint;

  @override
  RenderPaintMeasure createRenderObject(BuildContext context) {
    return RenderPaintMeasure(
      measurePaint: measurePaint,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderPaintMeasure renderObject) {
    renderObject..measurePaint = measurePaint;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('measurePaint', measurePaint));
  }
}
