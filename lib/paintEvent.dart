class PaintEventHandler {
  static Map<int, PaintEvent> paintEvents = Map();
  static int scn = 0;

  static void logEvent(PaintEvent paintEvent) {
    paintEvents[scn++] = paintEvent;
    // print('$scn ${paintEvents.length}');
  }

  // static void reset() {
  //   paintEvents.clear();
  // }

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
}

enum PaintEventType { markPaintUp, markPaintRoot, markPaintBoundary, paintChild }

class PaintEvent {
  PaintEventType eventType;
  String id;
  String? widgetId;
  int? timeStamp;

  PaintEvent({this.eventType = PaintEventType.markPaintUp, this.id = 'Unknown', this.widgetId}) {
    timeStamp ??= DateTime.now().microsecondsSinceEpoch;
  }
}
