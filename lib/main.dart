import 'package:flutter/material.dart';

void main() {
  runApp(
    ScrollTest(),
  );
}

class ScrollTest extends StatelessWidget {
  final int rowCount = 50;
  final int columnCount = 50;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Two-way scroll'),
            ),
            body: SingleChildScrollView(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    ...List.generate(
                      rowCount,
                      (int i) => Row(children: [
                        ...List.generate(
                          columnCount,
                          (int j) => Container(
                            width: 100,
                            height: 80,
                            child: contentCellBuilder(j, i),
                          ),
                        ),
                      ]),
                    ),
                  ])),
            )));
/*
            body: ListView(children: <Widget>[
              ...List.generate(
                rowCount,
                (int i) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    ...List.generate(
                      columnCount,
                      (int j) => Container(
                        width: 100,
                        height: 80,
                        child: contentCellBuilder(j, i),
                      ),
                    ),
                  ]),
                ),
              ),
            ])));
*/
  }

  Widget contentCellBuilder(int i, int j) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
// by removing this border, FPS goes up to normal
//           border: Border.all(
//             color: Colors.amber,
//             // left: BorderSide(color: Colors.green),
//           ),
//
            ),
        child: Text(
          'Dummy cell content: $i - $j',
        ));
  }
}

class WebScrollTestNoB extends StatelessWidget {
  final int rowCount = 90;
  final int columnCount = 90;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Two-way scroll'),
            ),
            body: SingleChildScrollView(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    ...List.generate(
                      rowCount,
                      (int i) => Row(children: [
                        ...List.generate(
                          columnCount,
                          (int j) => Container(
                            width: 100,
                            height: 80,
                            child: contentCellBuilder(j, i),
                          ),
                        ),
                      ]),
                    ),
                  ])),
            )));
/*
            body: ListView(children: <Widget>[
              ...List.generate(
                rowCount,
                (int i) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    ...List.generate(
                      columnCount,
                      (int j) => Container(
                        width: 100,
                        height: 80,
                        child: contentCellBuilder(j, i),
                      ),
                    ),
                  ]),
                ),
              ),
            ])));
*/
  }

  Widget contentCellBuilder(int i, int j) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
// by removing this border, FPS goes up to normal
//           border: Border(
//             left: BorderSide(color: Colors.green),
//           ),
//
            ),
        child: Text(
          'Dummy cell content: $i - $j',
        ));
  }
}
