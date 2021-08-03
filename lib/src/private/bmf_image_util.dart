import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class BMFImageUtil {
  static Future<Uint8List> widgetToUnit8List(Widget widgget) async {
    // GlobalKey globalKey = new GlobalKey();
    // RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
    // var image = await boundary.toImage(pixelRatio: window.devicePixelRatio);
    // ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    // Uint8List pngBytes = byteData.buffer.asUint8List();
    return Future.value(null);
  }
}
