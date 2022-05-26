import 'package:flutter/material.dart';

import '../../pattern/manipulator.dart';
import '../../shapes/shape.dart';

mixin HoverStateMixin implements ManipulationState {
  Shape? findShapeByCoordinates(double x, double y) {
    return context.shapes.findShapeByCoordinates(x, y);
  }

  bool get isHover => _isHover;

  @override
  void mouseMove(double x, double y) {
    final newHover = findShapeByCoordinates(x, y);

    if (newHover == _hoverShape) {
      return;
    }

    _hoverShape = newHover;

    if (newHover == null) {
      _isHover = false;
      onMouseLeave();
    } else {
      _isHover = true;
      onHover();
    }

    context.update();
  }

  void onHover() {}

  void onMouseLeave() {}

  @override
  void paint(Canvas canvas) {
    if (_hoverShape == null) {
      return;
    }

    canvas.drawRect(
      Rect.fromLTWH(
        _hoverShape!.x + 1,
        _hoverShape!.y + 1,
        _hoverShape!.width - 2,
        _hoverShape!.height - 2,
      ),
      Paint()
        ..color = Colors.cyanAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
  }

  Shape? _hoverShape;
  bool _isHover = false;
}
