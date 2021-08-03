import 'package:flutter/services.dart';

/// 获取原生地图Map组件版本号
class BMFMapAPI_Map {
  /// 获取原生地图map组件版本号
  ///
  /// return 平台：xx 组件：xx 版本号：xx
  /// eg: {'platform':'ios', 'component': 'map', version':'6.0.0'}
  static Future<Map?> get nativeMapVersion async {
    Map? result;
    try {
      result = await MethodChannel('flutter_bmfmap')
          .invokeMethod('flutter_bmfmap/map/getNativeMapVersion') as Map;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
