import 'package:flutter/material.dart';

class CellWidget extends StatelessWidget {
  final int row;
  final int column;
  final bool fancy;

  const CellWidget({Key key, this.row, this.column, this.fancy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: fancy ? Colors.yellow : Colors.grey,
          border: Border(
            top: BorderSide(),
          ),
        ),
        child: Text(
          'Dummy cell content: $row - $column',
          // style: Theme.of(context).textTheme.bodyText2,
        ));
  }
}
