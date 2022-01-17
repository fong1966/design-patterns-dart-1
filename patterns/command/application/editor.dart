import 'text_cursor.dart';

class Editor {
  var _text = '';

  String get text {
    return cursor.isTextSelected
        ? _text.replaceRange(
            cursor.startSelection,
            cursor.endSelection,
            '[$selectedText]',
          )
        : _text.replaceRange(
            cursor.position,
            cursor.position,
            '|',
          );
  }

  void inputText(String addText) {
    if (cursor.isTextSelected) {
      _replaceSelection(addText);
    } else {
      _insertText(addText);
    }
  }

  void selectText(int start, int end) {
    assert(end <= _text.length, ' end: $end, textLength: ${_text.length}');
    assert(start < end, 'start: $start, end: $end');
    _cursor = TextCursor.fromSelection(start, end);
  }

  void removeSelected() {
    if (cursor.isTextSelected) {
      _replaceSelection('');
    }
  }

  String get selectedText {
    return _text.substring(
      cursor.startSelection,
      cursor.endSelection,
    );
  }

  var _cursor = TextCursor.fromPosition(0);

  TextCursor get cursor => _cursor;

  int? get startSelection => cursor.startSelection;

  set textCursorPosition(int newPosition) {
    _cursor = TextCursor.fromPosition(newPosition);
  }

  int get textCursorPosition => _cursor.position;

  void _replaceSelection(String replaceText) {
    _text = _text.replaceRange(
      cursor.startSelection,
      cursor.endSelection,
      replaceText,
    );
    _cursor = TextCursor.fromPosition(
      cursor.startSelection + replaceText.length,
    );
  }

  void _insertText(String insertText) {
    _text = _text.replaceRange(
      cursor.position,
      cursor.position,
      insertText,
    );
    textCursorPosition += insertText.length;
  }
}
