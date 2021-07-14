import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  HomeButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w600),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
