import 'package:flutter/material.dart';

class ParameterNameValuePair extends StatelessWidget {
  final String name;
  final String value;
  final Axis axis;

  const ParameterNameValuePair(
      {Key? key, required this.name, required this.value, required this.axis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
          ),
          Text(
            value,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            value,
          ),
          Text(
            name,
          ),
        ],
      );
    }
  }
}
