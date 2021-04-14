import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scroll_test/paintEvent.dart';

import 'render_paint_measure.dart';

enum LogLevel { full, benchmark, indicator }

class RenderObjectHelper {
  RenderObject renderObject;
  static const int keepPaint = 24;
  List<PaintEvent> paintEvents = [];
  double delta = 0;

  Map<PaintEventType, int> eventssMap = {};

  RenderObjectHelper(this.renderObject);

  void logEvent(PaintEvent paintEvent) {
    if (debugRepaintRainbowEnabled) {
      paintEvents.add(paintEvent);
      if (paintEvents.length > keepPaint) {
        paintEvents.removeAt(0);
      }
      eventssMap[paintEvent.eventType] = (eventssMap[paintEvent.eventType] ?? 0) + 1;
    }
    // print('$scn ${paintEvents.length}');
  }

  void debugPaintPaintInfo(PaintingContext context, Offset offset) {
    if (renderObject is RenderPaintMeasure && debugRepaintLogLevel != LogLevel.indicator) {
      paintIndicator(context, offset - Offset(2, 2),
          width: 1, value: (renderObject as RenderPaintMeasure).measurePaint ? -1 : 0);
    }

    if (!(hasParentOf<RenderPaintMeasure>()?.measurePaint ?? true))
      // if (parent is RenderPaintMeasure && !(parent as RenderPaintMeasure).measurePaint)
      //   return;
      // if (this is RenderPaintMeasure && !(this as RenderPaintMeasure).measurePaint)
      return;
    if ([
      'RenderSemanticsAnnotations',
      'RenderSemanticsGestureHandler',
      'RenderExcludeSemantics',
      'RenderBlockSemantics',
      '_RenderInkFeatures',
      'RenderPointerListener',
      'RenderAbsorbPointer',
      'RenderIgnorePointer',
      'RenderMouseRegion',
      '_RenderInputPadding',
      // 'RenderPadding',
      // 'RenderPositionedBox',
      // 'RenderConstrainedBox',
    ].contains(renderObject.runtimeType.toString())) return;

    // print(this.runtimeType.toString());
    int i = -1;
    // paintEvents.forEach((element) {
    //   final p1 = Offset(i * 5 + delta, 0);
    //   final p2 = Offset(i * 5 + delta, 4);
    //   final paint = Paint()
    //     ..color = colorsMap[element.eventType] ?? Color(0xFFFF0000)
    //     ..strokeWidth = 4;
    //   context.canvas.drawLine(offset + p1, offset + p2, paint);
    //   i++;
    // });

    if (renderObject is RenderRepaintBoundary) {
      int asymPC = (renderObject as RenderRepaintBoundary).debugAsymmetricPaintCount + 1;
      int symPC = (renderObject as RenderRepaintBoundary).debugSymmetricPaintCount + 1;
      int fraction = (asymPC / (asymPC + symPC) * 8).round() + 1;
      if (asymPC == 1 && symPC == 1) fraction = 0;
      if (debugRepaintLogLevel == LogLevel.full)
        paintText(context, Offset.zero, ' $asymPC / $symPC',
            textColor: judgementColorMap[fraction] ?? Color(0xFFFF0000));
      else if (debugRepaintLogLevel == LogLevel.benchmark)
        paintText(context, Offset.zero, '${judgementStringMap[fraction]}',
            textColor: judgementColorMap[fraction] ?? Color(0xFFFF0000));

      paintIndicator(context, offset, limit: 0, value: fraction);
    } else {
      int parentMark = 0;
      int meMark = 0;
      if (renderObject.parent is RenderObject)
        parentMark =
            (renderObject.parent as RenderObject).renderObjectHelper.eventssMap[PaintEventType.markPaintUp] ?? 0;
      meMark = eventssMap[PaintEventType.markPaintUp] ?? 0;

      // print('${this.runtimeType.toString()}: $meMark / $parentMark ${parent.runtimeType}');

      if (meMark == parentMark && meMark > 10) {
        // print('Add RPB: ${renderObject.runtimeType}');
        if (hasParentOf<RenderRepaintBoundary>(maxDistance: 4) == null) {
          // print('Add RPB: ${renderObject.runtimeType}');
          paintIndicator(context, offset, value: 1);
          paintText(context, Offset(offset.dx, offset.dy - 0), 'Add RPB',
              textColor: Colors.white, backgroundColor: judgementColorMap[1]!);
        }
      }
    }
    i = 1;

    if (debugRepaintLogLevel == LogLevel.full) paintData(context, offset, i);
    // eventssMap.forEach((key, value) {
    //   // if ((value) != 0) {
    //   paintText(context, Offset(offset.dx, offset.dy + i * 20), ' ${key
    //       .toString()
    //       .split('.')
    //       .last
    //       .substring(0, 4)}: ${value.toString()}', backgroundColor: colorsMap[key] ?? Color(0xFFFF0000));
    //   i++;
    //   // }
    // }); //   final Paint paint = Paint()
    delta = delta == 0 ? 8 : delta - 1;
    // }
  }

  void paintIndicator(PaintingContext context, Offset offset, {double width = 2, double limit = 0, int value = 0}) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..color = judgementColorMap[value] ?? Color(0xFFa0a0a0);
    context.canvas.drawRect(
        Rect.fromLTWH(offset.dx, offset.dy, renderObject.paintBounds.width, renderObject.paintBounds.height), paint);
  }

  void paintData(PaintingContext context, Offset offset, int i) {
    if (renderObject is RenderRepaintBoundary) {
      paintText(
          context,
          Offset(offset.dx, offset.dy + i * 20),
          // ' ${key.toString().split('.').last.substring(0, 4)}: '
          ' ${(eventssMap[PaintEventType.paintBoundary] ?? 0).toString()} / ${(eventssMap[PaintEventType.markPaintBoundary] ?? 0).toString()} ',
          backgroundColor: colorsMap[PaintEventType.paintBoundary] ?? Color(0xFFFF0000));
    } else
      paintText(context, Offset(offset.dx, offset.dy + i * 20),
          ' ${(eventssMap[PaintEventType.paintChild] ?? 0).toString()} / ${(eventssMap[PaintEventType.markPaintUp] ?? 0).toString()} ',
          backgroundColor: colorsMap[PaintEventType.paintChild] ?? Color(0xFFFF0000));
  }

  void paintText(PaintingContext context, Offset offset, String text,
      {Color backgroundColor = const Color(0xFF000000), Color textColor = const Color(0xFFFFFFFF)}) {
    final textStyle = TextStyle(
      color: textColor,
      fontSize: 14,
    );
    final textSpan = TextSpan(
      text: '  $text  ',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    context.canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(offset.dx, offset.dy, textPainter.width, 20), Radius.circular(8.0)),
        Paint()
          ..strokeCap = StrokeCap.round
          ..color = backgroundColor);
    textPainter.paint(context.canvas, offset);
  }

  T? hasParentOf<T>({int maxDistance = 99}) {
    RenderObject? tmpRender = renderObject;
    int i = maxDistance;
    while (tmpRender != null && !(tmpRender is T)) {
      tmpRender = i-- < 0 || tmpRender.parent == null ? null : (tmpRender.parent as RenderObject);
      // if (maxDistance != 99)
      // print('tmpRender ${tmpRender.runtimeType} $maxDistance $i');
    }

    return tmpRender == null ? null : (tmpRender as T);
  }
}

enum PaintEventType { markPaintUp, markPaintRoot, markPaintBoundary, paintChild, paintBoundary, matchWidget, none }

class PaintEvent {
  PaintEventType eventType;
  String id;
  String? widgetId;
  late int timeStamp;

  PaintEvent({this.eventType = PaintEventType.none, this.id = 'Unknown', this.widgetId}) {
    timeStamp = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'PaintEvent{eventType: $eventType, id: $id, widgetId: $widgetId, timeStamp: $timeStamp}';
  }
}
