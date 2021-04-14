import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:scroll_test/paintEvent.dart';
import 'package:scroll_test/render_object_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'instruction.dart';

class DemoControl extends StatefulWidget {
  const DemoControl({Key? key}) : super(key: key);

  @override
  _DemoControlState createState() => _DemoControlState();
}

class _DemoControlState extends State<DemoControl> {
  double sliderValue = PaintEventHandler.playbackZeitLuppe;
  final String url = 'https://flutter.dev';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      constraints: BoxConstraints(maxWidth: 800),
      child: Column(
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
                          debugRepaintLogLevel = value ?? LogLevel.indicator;
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
            title: Text('Instructions >'),
            initiallyExpanded: true,
            children: [
              Html(
                data: htmlData,
                style: makeStyles(),
                onLinkTap: (url, _, __, ___) {
                  if (url != null) {
                    _launchURL(url);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async => await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
