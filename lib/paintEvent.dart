import 'package:rxdart/rxdart.dart';

class PaintEventHandler {
  static Map<int, PaintEvent> paintEvents = Map();
  static Map<String, String> widgetRenderMap = Map();
  static int scn = 0;

  static BehaviorSubject<PaintEvent> replaySubject = BehaviorSubject();

  static void logEvent(PaintEvent paintEvent) {
    paintEvents[scn++] = paintEvent;
    // print('$scn ${paintEvents.length}');
  }

  static void reset() {
    paintEvents.clear();
  }

  static void dump() {
    print('$scn ${paintEvents.length}');
    paintEvents.forEach((key, value) {
      print('${value.timeStamp}: ${value.eventType} ${value.id}');
    });
  }

  static Map<String, int> summarize() {
    print('$scn ${paintEvents.length}');
    Map<String, int> tmpMap = Map();
    paintEvents.forEach((key, value) {
      tmpMap[value.id] = (tmpMap[value.id] ?? 0) + 1;
      print('${value.timeStamp}: ${value.eventType} ${value.id}');
    });
    print(tmpMap);
    return tmpMap;
  }

  void playBack({Duration interval = const Duration(milliseconds: 300)}) {
    for (int key in paintEvents.keys.toList()..sort()) {
      replaySubject.add(paintEvents[key]!);
      Future.delayed(interval);
    }
    ;
  }

  void dispose() {
    replaySubject.close();
  }
}

enum PaintEventType { markPaintUp, markPaintRoot, markPaintBoundary, paintChild, matchWidget, none }

class PaintEvent {
  PaintEventType eventType;
  String id;
  String? widgetId;
  int? timeStamp;

  PaintEvent({this.eventType = PaintEventType.none, this.id = 'Unknown', this.widgetId}) {
    timeStamp ??= DateTime.now().microsecondsSinceEpoch;
  }
}
