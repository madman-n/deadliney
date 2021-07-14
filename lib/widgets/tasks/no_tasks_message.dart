import 'package:flutter/material.dart';

class NoTasksMessage extends StatelessWidget {
  const NoTasksMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'No Tasks Yet',
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
