import 'package:design_patterns_dart/text_canvas.dart';

import '../products/product.dart';
import '../products/product_leaf.dart';
import '../render_elements/render_element.dart';
import '../render_elements/render_text.dart';


extension ConvertProductToDiagram on Product {
  RenderElement toRenderElement() {
    return RenderText(
      content,
      borderStyle: borderStyleBySize(),
    );
  }

  BorderStyle borderStyleBySize() {
    // if (size > 4) {
    //   return BorderStyle.bold;
    // } else
    // if (size >= 2) {
    //   return BorderStyle.bold;
    // } else

    if (this is ProductLeaf) {
      return BorderStyle.empty;
    } else {
      return BorderStyle.single;
    }
  }
}
