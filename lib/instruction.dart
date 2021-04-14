import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:scroll_test/paintEvent.dart';

String htmlData = """
<h3>Render paint measurement and benchmarking experiment - Live intro</h3>
  <p>This experiment is related to Flutter <a href='https://github.com/flutter/flutter/issues/80432'>issue 80432</a>  </p>
  
  <p>- It runs on a fork of the framework with some experimental paint event logging and in-place indicators added.</p> 
  <p>- The demo app is a normal Flutter app with standard widgets.</p>
  <p>- For convenience, a custom widget with render object was created that can disable and re-enable repaint 
  measurements and indicators for its child tree.</p>
  <p>- The whole app is just an experiment.</p>
  
  <h3>Usage:</h3>
  <p>Tap Flutter logos to start the rotate animation. Render paint event data is collected and displayed in place</p>
  <p>Change Paint measure level to see different levels of evaluation displayed</p>

  <p class='indent'>- <b>Indicator:</b> only items needing attention are marked </p> 
  <p class='indent'>- <b>Benchmark:</b> all relevant items are marked with evaluated data</p>
  <p class='indent'>- <b>All:</b> confusingly much measurement data is shown for all included items...</p>
  

      <h3>Legend:</h3>
      ${makeExplanation()}
      <p></p>
      <div class='indent'>
      <p><span style='background-color: black; color: Aquamarine;'>\u00A0 Repaint boundary benchmark: Super\u00A0 </span></p>
      <p><span style='background-color: black; color: Aquamarine;'>\u00A0 Repaint boundary data: Async / Sync\u00A0 </span></p>
      <p><span style='background-color: #FF5722; color: white;'>\u00A0 Widget paint benchmark: Add RPB\u00A0 </span></p>
      <p><span style='background-color: #0D47A1; color: white; margin:40px; '> \u00A0 Widget paint data:  Paint / Mark parent\u00A0 </span></p>
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
