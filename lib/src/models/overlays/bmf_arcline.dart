import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/src/map/bmf_map_linedraw_types.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, ColorUtil;
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';

import 'bmf_overlay.dart';

/// 弧线
class BMFArcLine extends BMFOverlay {
  /// 经纬度数组三个点确定一条弧线
  List<BMFCoordinate?>? coordinates;

  /// 设置arclineView的线宽度
  int? width;

  /// 设置arclineView的画笔颜色
  Color? color;

  /// 虚线类型,iOS独有
  BMFLineDashType? lineDashType;

  /// BMFArcline构造方法
  BMFArcLine({
    required this.coordinates,
    this.width: 5,
    this.color: Colors.blue,
    this.lineDashType: BMFLineDashType.LineDashTypeNone,
    int zIndex: 0,
    bool visible: true,
  })  : assert(coordinates != null),
        assert(coordinates!.length > 2),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFArcline
  BMFArcLine.fromMap(Map map)
      : assert(map['coordinates'] != null),
        super.fromMap(map) {
    if (map['coordinates'] != null) {
      coordinates = <BMFCoordinate>[];
      map['coordinates'].forEach((v) {
        coordinates?.add(BMFCoordinate.fromMap(v as Map));
      });
    }
    width = map['width'];
    color = ColorUtil.hexToColor(map['color']);
    lineDashType = BMFLineDashType.values[map['lineDashType'] as int];
  }

  @override
  fromMap(Map map) {
    return BMFArcLine.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'coordinates': this.coordinates?.map((coord) => coord?.toMap())?.toList(),
      'width': this.width,
      'color': this.color?.value?.toRadixString(16),
      'lineDashType': this.lineDashType?.index,
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }

  /// 更新经纬度数组
  ///
  /// List<[BMFCoordinate]> coordinates arcline经纬度数组
  Future<bool> updateCoordinates(List<BMFCoordinate>? coordinates) async {
    if (null == coordinates) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateArclineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'coordinates',
      'value': coordinates.map((coordinate) => coordinate.toMap()).toList()
    });

    if (ret) {
      this.coordinates = coordinates;
    }

    return ret;
  }

  /// 更新线宽
  Future<bool> updateWidth(int width) async {
    if (width < 0) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateArclineMember(this.methodChannel,
            {'id': this.Id, 'member': 'width', 'value': width});

    if (ret) {
      this.width = width;
    }

    return ret;
  }

  /// 更新color
  Future<bool> updateColor(Color? color) async {
    if (null == color) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateArclineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'color',
      'value': color.value.toRadixString(16)
    });

    if (ret) {
      this.color = color;
    }

    return ret;
  }

  /// 虚线类型，iOS独有
  ///
  /// [BMFLineDashType] lineDashType  虚线类型
  Future<bool> updateLineDashType(BMFLineDashType lineDashType) async {
    if (this.lineDashType == lineDashType) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateArclineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'lineDashType',
      'value': lineDashType.index
    });

    if (ret) {
      this.lineDashType = lineDashType;
    }

    return ret;
  }
}
