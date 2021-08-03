import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/src/map/bmf_map_linedraw_types.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, ColorUtil;
import 'package:flutter_baidu_mapapi_map/src/models/bmf_hollowshape.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';

import 'bmf_overlay.dart';

/// 多边形
class BMFPolygon extends BMFOverlay {
  /// 经纬度数组
  List<BMFCoordinate?>? coordinates;

  /// 设置polygonView的线宽度
  int? width;

  /// 设置polygonView的边框颜色
  Color? strokeColor;

  /// 设置polygonView的填充色
  Color? fillColor;

  /// 设置polygonView为虚线样式
  BMFLineDashType? lineDashType;

  /// 设置中空区域，用来创建中间带空洞的复杂图形。
  List<BMFHollowShape>? hollowShapes;

  /// BMFPolygon构造方法
  BMFPolygon({
    required this.coordinates,
    this.width: 5,
    this.strokeColor: Colors.blue,
    this.fillColor: Colors.red,
    this.lineDashType: BMFLineDashType.LineDashTypeNone,
    this.hollowShapes,
    int zIndex: 0,
    bool visible: true,
  })  : assert(coordinates != null),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFPolygon
  BMFPolygon.fromMap(Map map)
      : assert(map['coordinates'] != null),
        super.fromMap(map) {
    if (map['coordinates'] != null) {
      coordinates = <BMFCoordinate>[];
      map['coordinates'].forEach((v) {
        coordinates?.add(BMFCoordinate.fromMap(v as Map));
      });
    }

    width = map['width'];
    strokeColor = ColorUtil.hexToColor(map['strokeColor']);
    fillColor = ColorUtil.hexToColor(map['fillColor']);
    lineDashType = BMFLineDashType.values[map['lineDashType'] as int];

    if (map['hollowShapes'] != null) {
      hollowShapes = <BMFHollowShape>[];
      for (var item in hollowShapes!) {
        BMFHollowShape hollowShape = BMFHollowShape.fromMap(item as Map);
        hollowShapes?.add(hollowShape);
      }
    }
  }

  @override
  fromMap(Map map) {
    return BMFPolygon.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'coordinates': this.coordinates?.map((coord) => coord?.toMap())?.toList(),
      'width': this.width,
      'strokeColor': this.strokeColor?.value?.toRadixString(16),
      'fillColor': this.fillColor?.value?.toRadixString(16),
      'lineDashType': this.lineDashType?.index,
      'hollowShapes': this.hollowShapes?.map((e) => e.toMap()).toList(),
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }

  /// 更新经纬度数组
  ///
  /// List<[BMFCoordinate]> coordinates polygon经纬度数组
  Future<bool> updateCoordinates(List<BMFCoordinate> coordinates) async {
    if (null == coordinates) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolygonMember(this.methodChannel, {
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
        .updatePolygonMember(this.methodChannel,
            {'id': this.Id, 'member': 'width', 'value': width});

    if (ret) {
      this.width = width;
    }

    return ret;
  }

  /// 更新strokeColor
  Future<bool> updateStrokeColor(Color? strokeColor) async {
    if (null == strokeColor) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolygonMember(this.methodChannel, {
      'id': this.Id,
      'member': 'strokeColor',
      'value': strokeColor.value.toRadixString(16)
    });

    if (ret) {
      this.strokeColor = strokeColor;
    }

    return ret;
  }

  /// 更新fillColor
  Future<bool> updateFillColor(Color? fillColor) async {
    if (null == fillColor) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolygonMember(this.methodChannel, {
      'id': this.Id,
      'member': 'fillColor',
      'value': fillColor.value.toRadixString(16)
    });

    if (ret) {
      this.fillColor = fillColor;
    }

    return ret;
  }

  /// 虚线类型
  ///
  /// [BMFLineDashType] lineDashType  虚线类型
  Future<bool> updateLineDashType(BMFLineDashType lineDashType) async {
    if (this.lineDashType == lineDashType) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolygonMember(this.methodChannel, {
      'id': this.Id,
      'member': 'lineDashType',
      'value': lineDashType.index
    });

    if (ret) {
      this.lineDashType = lineDashType;
    }

    return ret;
  }

  /// 更新镂空
  ///
  /// List<[BMFHollowShape]> hollowShapes 镂空列表
  Future<bool> updateHollowShapes(List<BMFHollowShape>? hollowShapes) async {
    if (hollowShapes == null) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolygonMember(this.methodChannel, {
      'id': this.Id,
      'member': 'hollowShapes',
      'value': hollowShapes.map((e) => e.toMap()).toList()
    });

    if (ret) {
      this.hollowShapes = hollowShapes;
    }

    return ret;
  }
}
