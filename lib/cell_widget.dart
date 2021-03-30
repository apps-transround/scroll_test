import 'package:flutter/material.dart';

class CellWidget extends StatefulWidget {
  final int? row;
  final int? column;
  final bool fancy;

  const CellWidget({Key? key, this.row, this.column, this.fancy = true}) : super(key: key);

  @override
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: widget.fancy ? Colors.yellow : Colors.grey,
          border: Border(
            top: BorderSide(),
          ),
        ),
        child: Text(
          'Dummy cell content: ${widget.row} - ${widget.column}',
          // style: Theme.of(context).textTheme.bodyText2,
        ));
  }
}
