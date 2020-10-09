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
// by removing this border, FPS goes up to normal
          color: fancy ? Colors.yellow : Colors.grey,
          border: fancy
              // ? Border.all(
              //     color: Colors.amber.shade300,
              //   )
              ? Border(
                  top: BorderSide(),
                )
              : null,
//
        ),
        child: Text(
          'Dummy cell content: $row - $column',
          // style: Theme.of(context).textTheme.bodyText2,
        ));
  }
}
