import 'package:flutter/cupertino.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, ColorUtil;
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';

import 'bmf_overlay.dart';

/// 点
///
/// Android独有
class BMFDot extends BMFOverlay {
  /// 圆心点经纬度
  BMFCoordinate? center;

  /// 圆的半径(单位米)
  double? radius;

  ///园的颜色
  Color? color;

  /// BMFDot构造方法
  BMFDot({
    required this.center,
    required this.radius,
    required this.color,
    int zIndex: 0,
    bool visible: true,
  })  : assert(center != null),
        assert(radius != null),
        assert(color != null),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFDot
  BMFDot.fromMap(Map map)
      : assert(map['center'] != null),
        assert(map['radius'] != null),
        assert(map['color'] != null),
        super.fromMap(map) {
    center = BMFCoordinate.fromMap(map['center']);
    radius = map['radius'];
    color = ColorUtil.hexToColor(map['color']);
  }

  @override
  fromMap(Map map) {
    return BMFDot.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'center': this.center?.toMap(),
      'radius': this.radius,
      'color': this.color?.value?.toRadixString(16),
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }

  /// 更新中心点center
  ///
  /// [BMFCoordinate] center Dot经纬度数组
  Future<bool> updateCenter(BMFCoordinate? center) async {
    if (null == center) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateDotMember(this.methodChannel,
            {'id': this.Id, 'member': 'center', 'value': center.toMap()});

    if (ret) {
        this.center = center;
    }

    return ret;
  }

  /// 更新半径
  ///
  /// radius Dot半径
  Future<bool> updateRadius(double radius) async {
    if (radius < 0) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateDotMember(this.methodChannel,
            {'id': this.Id, 'member': 'radius', 'value': radius});

    if (ret) {
        this.radius = radius;
    }

    return ret;
  }

  /// 更新颜色
  ///
  /// [Color]color 颜色
  Future<bool> updateColor(Color? color) async {
    if (null == color) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateDotMember(this.methodChannel, {
      'id': this.Id,
      'member': 'color',
      'value': color.value.toRadixString(16)
    });

    if (ret) {
        this.color = color;
    }

    return ret;
  }
}
