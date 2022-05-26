import 'dart:ui';

import '../../pattern/manipulator.dart';
import '../../shapes/shape.dart';

abstract class CreationState extends ManipulationState {
  Shape createShape(double x, double y);

  @override
  void mouseDown(double x, double y) {
    _startCreatingShape(x, y);
  }

  @override
  void mouseMove(double x, double y) {
    if (_isCreatingNotStart) {
      return;
    }

    _resizeNewShape(x, y);
  }

  @override
  void mouseUp() {
    if (_isCreatingNotStart) {
      return;
    }

    _repositionNewShape();
    context.shapes.add(_newShape!);
    _finishCreatingShape();
  }

  @override
  void paint(Canvas canvas) {
    _newShape?.paint(canvas);
  }

  var _startX = 0.0;
  var _startY = 0.0;
  Shape? _newShape;
  var _isDragged = false;

  void _startCreatingShape(double x, double y) {
    _startX = x;
    _startY = y;
    _newShape = createShape(x, y);
  }

  bool get _isCreatingNotStart => _newShape == null;

  void _resizeNewShape(double x, double y) {
    _isDragged = true;
    _newShape!.resize(x - _startX, y - _startY);
    context.update();
  }

  void _finishCreatingShape() {
    context.changeState(
      _newShape!.createSelectionState(),
    );

    _isDragged = false;
    _newShape = null;
  }

  void _repositionNewShape() {
    if (!_isDragged) {
      _newShape!.move(_startX - 50, _startY - 50);
      _newShape!.resize(100, 100);
    }
  }
}
