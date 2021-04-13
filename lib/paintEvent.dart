import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scroll_test/render_object_helper.dart';
// import 'package:rxdart/rxdart.dart';

enum PlaybackMode { none, run, pause, stop }
enum EventMode { record, playback, interactive, none }

const Map<PaintEventType, Color> colorsMap = {
  PaintEventType.paintChild: Color(0xFF0D47A1), // Colors.blue.shade700,
  PaintEventType.paintBoundary: Colors.deepPurple,
  PaintEventType.markPaintBoundary: Colors.indigoAccent,
  PaintEventType.markPaintUp: Colors.amber,
  PaintEventType.markPaintRoot: Colors.grey,
};

const Map<int, Color> judgementColorMap = {
  1: Colors.deepOrange,
  3: Colors.deepPurple,
  4: Colors.blue,
  5: Colors.amber,
  9: Colors.tealAccent,
};

class PaintEventHandler {
  static List<PaintEvent> paintEvents = [];
  static Map<String, String> widgetRenderMap = Map();
  static int scn = 0;

  // static BehaviorSubject<PaintEvent> replaySubject = BehaviorSubject();
  // static Map<String, BehaviorSubject<PaintEvent>> replaySubjects = Map();
  //
  // static BehaviorSubject<int> replayPositionSubject = BehaviorSubject();

  static double playbackZeitLuppe = 50;
  static PlaybackMode playbackMode = PlaybackMode.none;
  static EventMode eventMode = EventMode.none;

  static get minTime {
    if (paintEvents.length > 0)
      return paintEvents[0].timeStamp;
    else
      return 0;
  }

  static get maxTime {
    if (paintEvents.length > 0)
      return paintEvents.last.timeStamp;
    else
      return 1;
  }

  static get timeRange {
    if (paintEvents.length > 0)
      return paintEvents.last.timeStamp - paintEvents[0].timeStamp;
    else
      return 1;
  }

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
    // paintEvents.forEach((value) {
    //   tmpMap[value.id] = (tmpMap[value.id] ?? 0) + 1;
    //   // print('${value.timeStamp}: ${value.eventType} ${value.id}');
    // });
    // tmpMap.forEach((key, value) {
    //   print('$key: $value');
    // });

    Map<String, int> tmpEventMap = Map();
    Map<String, List<String>> tmpEventMap2 = Map();
    paintEvents.forEach((value) {
      tmpEventMap[value.eventType.toString()] = (tmpEventMap[value.eventType.toString()] ?? 0) + 1;
      tmpEventMap2[value.eventType.toString()] ??= [];
      tmpEventMap2[value.eventType.toString()]!.add(value.id);
      // print('${value.timeStamp}: ${value.eventType} ${value.id}');
    });
    tmpEventMap.forEach((key, value) {
      // if (key == PaintEventType.markPaintUp.toString())
      print('$key: $value');
    });
    tmpEventMap2.forEach((key, value) {
      if (key == PaintEventType.markPaintBoundary.toString()) print('$key: $value');
    });
    // print(tmpMap);
    return tmpMap;
  }

  static Future<void> playBack({double? zeitLuppe}) async {
    if (scn == timeRange) {
      scn = 0;
    }
    playbackZeitLuppe = zeitLuppe == null ? playbackZeitLuppe : zeitLuppe;
    playbackMode = PlaybackMode.run;
    int pos = 0;
    for (PaintEvent tmpEvent in paintEvents) {
      if (playbackMode != PlaybackMode.run) break;
      tmpEvent.widgetId ??= widgetRenderMap[tmpEvent.id];

      // replaySubjects[tmpEvent.widgetId]?.add(tmpEvent);
      // // replaySubject.add(tmpEvent);
      // int delta = (scn < timeRange) ? (paintEvents[pos + 1].timeStamp - tmpEvent.timeStamp) : 0;
      // if (delta != 0) {
      //   replayPositionSubject.add(scn);
      //   await Future.delayed(Duration(microseconds: (delta * playbackZeitLuppe).round()));
      //   scn = scn + delta;
      // }
      pos++;
    }
    print('REEEEADY playback');
  }

  static void setScn(int newScn) {
    scn = min(newScn, paintEvents.length - 1);
    // replayPositionSubject.add(scn);
    // replaySubject.add(paintEvents[scn]);
  }

  static void matchRequest() {
    // replaySubject.add(PaintEvent(eventType: PaintEventType.matchWidget));
  }

  static void matchOne({required String widgetId, required String renderId}) {
    widgetRenderMap[renderId] = widgetId;
    // replaySubjects[widgetId] = BehaviorSubject<PaintEvent>();
  }

  void dispose() {
    // replaySubject.close();
    // replayPositionSubject.close();
  }
}
