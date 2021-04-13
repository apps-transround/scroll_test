import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:scroll_test/paintEvent.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class DemoControl extends StatefulWidget {
  final void Function()? onRecord;
  final void Function()? onPlay;
  final void Function()? onPause;
  final void Function()? onStop;

  const DemoControl({Key? key, this.onRecord, this.onPlay, this.onPause, this.onStop}) : super(key: key);

  @override
  _DemoControlState createState() => _DemoControlState();
}

class _DemoControlState extends State<DemoControl> {
  double sliderValue = PaintEventHandler.playbackZeitLuppe;
  final String url = 'https://flutter.dev';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(
                  'Paint measure level:',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: DropdownButton<LogLevel>(
                    onChanged: (value) {
                      setState(() {
                        debugRepaintLogLevel = value ?? LogLevel.none;
                      });
                    },
                    items: LogLevel.values.map<DropdownMenuItem<LogLevel>>((LogLevel value) {
                      return DropdownMenuItem<LogLevel>(
                        value: value,
                        child: Text((value.toString())),
                      );
                    }).toList(),
                    value: debugRepaintLogLevel,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 240,
              child: CheckboxListTile(
                title: Text('Show paint info'),
                onChanged: (bool? value) {
                  setState(() {
                    debugRepaintRainbowEnabled = !debugRepaintRainbowEnabled;
                  });
                },
                value: debugRepaintRainbowEnabled,
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('instructions...'),
          children: [
            Link(
              builder: (BuildContext context, Future<void> Function()? followLink) {
                return ElevatedButton(
                  onPressed: _launchURL,
                  child: Text('Issue on Github'),
                );
              },
              uri: null,
            ),
            SizedBox(height: 240, child: Markdown(data: insMD)),
          ],
        ),
      ],
    );
  }

  void _launchURL() async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

String insMD = 'Markdown is the **best**!\n'
    '    * It has lists.\n'
    '* It has [links](http://dart.dev).\n'
    '* It has _so much more_...\n';
