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
    // widgetRenderMap.clear();
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

  static Future<void> playBack({Duration interval = const Duration(milliseconds: 3)}) async {
    for (int key in paintEvents.keys.toList()..sort()) {
      PaintEvent tmpEvent = paintEvents[key]!;
      tmpEvent.widgetId ??= widgetRenderMap[tmpEvent.id];
      if (tmpEvent.widgetId != null) {
        print('WWWWWWWWWWWWW ${tmpEvent.toString()}');
      }
      replaySubject.add(tmpEvent);
      await Future.delayed(interval);
    }
  }

  static void matchRequest() {
    replaySubject.add(PaintEvent(eventType: PaintEventType.matchWidget));
  }

  static void matchOne({required String widgetId, required String renderId}) {
    widgetRenderMap[renderId] = widgetId;
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

  @override
  String toString() {
    return 'PaintEvent{eventType: $eventType, id: $id, widgetId: $widgetId, timeStamp: $timeStamp}';
  }
}
