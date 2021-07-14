import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar(
      {Key? key, required this.value, required this.height})
      : super(key: key);
  final double value;
  final double height;

  _floor(double value, [min = 0.0]) {
    return value.sign <= min ? min : value;
  }

  _colorGenerate(double value) {
    final int rbg = (value * 255).toInt();
    return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints box) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        width: box.maxWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
        ),
        child: Stack(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height),
                color: Theme.of(context).backgroundColor,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              height: height,
              width: box.maxWidth * _floor(value),
              decoration: BoxDecoration(
                color: _colorGenerate(value),
                borderRadius: BorderRadius.circular(height),
              ),
            ),
          ],
        ),
      );
    });
  }
}
