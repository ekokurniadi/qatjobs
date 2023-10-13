import 'package:flutter/material.dart';

enum Direction { vertical, horizontal }

class SpaceWidget extends StatelessWidget {
  const SpaceWidget({
    super.key,
    this.space = 16,
    this.direction = Direction.vertical,
  });
  final double space;
  final Direction? direction;

  @override
  Widget build(BuildContext context) {
    if (direction == null) {
      return SizedBox(height: space);
    } else {
      if (direction! == Direction.horizontal) {
        return SizedBox(width: space);
      }
      return SizedBox(height: space);
    }
  }
}
