import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel;

/// 地图覆盖物基类
class BMFOverlay implements BMFModel {
  /// overlay 唯一标识id
  String? _id;

  /// overlay是否可见
  ///
  /// Android独有
  bool? visible;

  /// 元素的堆叠顺序
  ///
  /// Android独有
  int? zIndex;

  MethodChannel? _methodChannel;

  BMFOverlay({this.visible, this.zIndex}) {
    var timeStamp = new DateTime.now().millisecondsSinceEpoch;
    _id = '$timeStamp''_''$hashCode';
  }

  /// map => BMFOverlay
  BMFOverlay.fromMap(Map map)
      : assert(map != null,
            'Construct a Overlay，The parameter map cannot be null'),
        assert(map.containsKey('id')) {
    _id = map['id'];
    visible = map['visible'];
    zIndex = map['zIndex'];
  }

  /// 获取id
  String? get Id => _id;

  /// 设置channel
  void set methodChannel(MethodChannel? methodChannel) =>
      _methodChannel = methodChannel;

  /// 获取channdel
  MethodChannel? get methodChannel => _methodChannel;

  @override
  Map<String, Object?> toMap() {
    return {'id': this.Id, 'visible': visible, 'zIndex': zIndex};
  }

  @override
  fromMap(Map map) {
    return BMFOverlay.fromMap(map);
  }
}
