import 'dart:math';

import 'package:rxdart/rxdart.dart';

enum PlaybackMode { none, run, pause, stop }
enum EventMode { record, playback, interactive, none }

class PaintEventHandler {
  static List<PaintEvent> paintEvents = [];
  static Map<String, String> widgetRenderMap = Map();
  static int scn = 0;

  static BehaviorSubject<PaintEvent> replaySubject = BehaviorSubject();
  static BehaviorSubject<int> replayPositionSubject = BehaviorSubject();

  static double playbackZeitLuppe = 100;
  static PlaybackMode playbackMode = PlaybackMode.none;
  static EventMode eventMode = EventMode.none;

  static void logEvent(PaintEvent paintEvent) {
    if (eventMode == EventMode.record) {
      paintEvents.add(paintEvent);
    }
    // print('$scn ${paintEvents.length}');
  }

  static void reset() {
    paintEvents.clear();
    // widgetRenderMap.clear();
  }

  static void dump() {
    print('$scn ${paintEvents.length}');
    paintEvents.forEach((value) {
      print('${value.timeStamp}: ${value.eventType} ${value.id}');
    });
  }

  static Map<String, int> summarize() {
    print('$scn ${paintEvents.length}');
    Map<String, int> tmpMap = Map();
    paintEvents.forEach((value) {
      tmpMap[value.id] = (tmpMap[value.id] ?? 0) + 1;
      // print('${value.timeStamp}: ${value.eventType} ${value.id}');
    });
    print(tmpMap);
    return tmpMap;
  }

  static Future<void> playBack({double? zeitLuppe}) async {
    if (scn == paintEvents.length - 1) {
      scn = 0;
    }
    playbackZeitLuppe = zeitLuppe == null ? playbackZeitLuppe : zeitLuppe;
    playbackMode = PlaybackMode.run;
    for (PaintEvent tmpEvent in paintEvents) {
      if (playbackMode != PlaybackMode.run) break;
      tmpEvent.widgetId ??= widgetRenderMap[tmpEvent.id];
      replaySubject.add(tmpEvent);
      int delta = (scn < paintEvents.length - 1) ? (paintEvents[scn + 1].timeStamp - tmpEvent.timeStamp) : 0;
      replayPositionSubject.add(scn);
      if (delta != 0) {
        await Future.delayed(Duration(microseconds: (delta * playbackZeitLuppe).round()));
      }
      scn++;
    }
    print('REEEEADY playback');
  }

  static void setScn(int newScn) {
    scn = min(newScn, paintEvents.length - 1);
    replayPositionSubject.add(scn);
    replaySubject.add(paintEvents[scn]);
  }

  static void matchRequest() {
    replaySubject.add(PaintEvent(eventType: PaintEventType.matchWidget));
  }

  static void matchOne({required String widgetId, required String renderId}) {
    widgetRenderMap[renderId] = widgetId;
  }

  void dispose() {
    replaySubject.close();
    replayPositionSubject.close();
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
