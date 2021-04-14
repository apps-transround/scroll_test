import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:scroll_test/paintEvent.dart';

String htmlData = """
<h3>Render paint measurement and benchmarking experiment - Live intro</h3>
  <p>This experiment is related to Flutter <a href='https://github.com'>issue 54821</a>  </p>
  
  <p>- It runs on a fork of the framework with some experimental paint event logging and in-place indicators added.</p> 
  <p>- The demo app is a normal Flutter app with standard widgets.</p>
  <p>- For convenience, a custom widget with render object was created that can disable repaint measurements and indicators for its child tree.</p>
  <p>- The UI is just an experiment.</p>
  
  <h3>Usage:</h3>
  <p>Tap Flutter logos to start rotate animation. Render paint event data is collected and displayed in place</p>
  <p>Change Paint measure level to see different level of evaluation displayed</p>

  <p class='indent'>- Indicator: only items needing attention are marked </p> 
  <p class='indent'>- Benchmark: all relevant items are marked with evaluated data</p>
  <p class='indent'>- All: confusingly much measurement data is shown for all included items...</p>
  

      <h3>Legend:</h3>
      ${makeExplanation()}
      <p></p>
      <div class='indent'>
      <p><span style='background-color: black; color: Aquamarine;'>\u00A0 Repaint boundary benchmark: Super </span></p>
      <p><span style='background-color: black; color: Aquamarine;'>\u00A0 Repaint boundary data: Async / Sync </span></p>
      <p><span style='background-color: black; color: red;'>\u00A0 Widget paint benchmark: Add RPB </span></p>
      <p><span style='background-color: #0D47A1; color: white; margin:40px; '> \u00A0 Widget paint data:  Paint / Mark parent </span></p>
      </div>
 
""";

Map<String, Style> makeStyles() {
  Map<String, Style> tmpStyles = Map();
  judgementColorMap.forEach((key, value) {
    tmpStyles['p.s${key.toString()}'] =
        Style(border: Border.all(width: 2.0, color: value), width: 240, margin: EdgeInsets.only(left: 32));
  });
  tmpStyles['p.indent'] = Style(margin: EdgeInsets.only(left: 32));
  tmpStyles['div.indent'] = Style(margin: EdgeInsets.only(left: 32), padding: EdgeInsets.symmetric(horizontal: 16));
  return tmpStyles;
}

String makeExplanation() {
  String explanation = '';
  judgementDescriptionMap.forEach((key, value) {
    explanation = explanation + '  <p class="s${key.toString()}" > $value </p>\n ';
  });
  return explanation;
}

var style = {
  "p.red": Style(
    width: 150,
    border: Border.all(width: 2.0, color: const Color(0xFFFF0000)),
  ),
};
