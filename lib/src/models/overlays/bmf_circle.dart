import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/src/map/bmf_map_linedraw_types.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, ColorUtil;
import 'package:flutter_baidu_mapapi_map/src/models/bmf_hollowshape.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';

import 'bmf_overlay.dart';

/// 圆
class BMFCircle extends BMFOverlay {
  /// 圆心点经纬度
  BMFCoordinate? center;

  /// 圆的半径(单位米)
  double? radius;

  /// 设置circleView的线宽度
  int? width;

  /// 设置circleView的边框颜色
  Color? strokeColor;

  /// 设置circleView的填充色
  Color? fillColor;

  /// 设置circleView为虚线样式
  ///
  /// Android平台要想渲染成虚线，必须设置dottedLine为true
  BMFLineDashType? lineDashType;

  /// 设置折线是否虚线(Android独有)
  ///
  /// 与BMFLineDashType配合使用;为true，则circle可以渲染成虚线，为fasle则不能，
  bool? dottedLine;

  /// 设置中空区域，用来创建中间带空洞的复杂图形。
  List<BMFHollowShape>? hollowShapes;

  /// BMFCircle构造方法
  BMFCircle({
    required this.center,
    required this.radius,
    this.width: 5,
    this.strokeColor: Colors.blue,
    this.fillColor: Colors.red,
    this.lineDashType: BMFLineDashType.LineDashTypeNone,
    this.dottedLine,
    this.hollowShapes,
    int zIndex: 0,
    bool visible: true,
  })  : assert(center != null),
        assert(radius != null),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFCircle
  BMFCircle.fromMap(Map map)
      : assert(map['center'] != null),
        assert(map['radius'] != null),
        super.fromMap(map) {
    center = BMFCoordinate.fromMap(map['center']);
    radius = map['radius'];
    width = map['width'];
    strokeColor = ColorUtil.hexToColor(map['strokeColor']);
    fillColor = ColorUtil.hexToColor(map['fillColor']);
    lineDashType = BMFLineDashType.values[map['lineDashType'] as int];
    dottedLine = map['dottedLine'];

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
    return BMFCircle.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'center': this.center?.toMap(),
      'radius': this.radius,
      'width': this.width,
      'strokeColor': this.strokeColor?.value.toRadixString(16),
      'fillColor': this.fillColor?.value.toRadixString(16),
      'lineDashType': this.lineDashType?.index,
      'dottedLine': this.dottedLine,
      'hollowShapes': this.hollowShapes?.map((e) => e.toMap()).toList(),
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }

  /// 更新圆心点经纬度
  ///
  /// [BMFCoordinate] center 圆心点经纬度
  Future<bool> updateCenter(BMFCoordinate? center) async {
    if (null == center) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateCircleMember(this.methodChannel,
            {'id': this.Id, 'member': 'center', 'value': center.toMap()});

    if (ret) {
      this.center = center;
    }

    return ret;
  }

  /// 更新半径
  Future<bool> updateRadius(double radius) async {
    if (radius < 0) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateCircleMember(this.methodChannel,
            {'id': this.Id, 'member': 'radius', 'value': radius});

    if (ret) {
      this.radius = radius;
    }

    return ret;
  }

  /// 更新线宽
  Future<bool> updateWidth(int width) async {
    if (width < 0) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateCircleMember(this.methodChannel,
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
        .updateCircleMember(this.methodChannel, {
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
        .updateCircleMember(this.methodChannel, {
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
        .updateCircleMember(this.methodChannel, {
      'id': this.Id,
      'member': 'lineDashType',
      'value': lineDashType.index
    });

    if (ret) {
      this.lineDashType = lineDashType;
    }

    return ret;
  }

  /// 更新是否虚线 Android
  ///
  /// dottedLine 折线呢是否显示虚线
  Future<bool> updateDottedLine(bool dottedLine) async {
    if (this.dottedLine == dottedLine) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateCircleMember(this.methodChannel,
            {'id': this.Id, 'member': 'dottedLine', 'value': dottedLine});

    if (ret) {
      this.dottedLine = dottedLine;
    }

    return ret;
  }

  /// 更新镂空区
  ///
  /// List<[BMFHollowShape]> hollowShapes 镂空列表
  Future<bool> updateHollowShapes(List<BMFHollowShape>? hollowShapes) async {
    if (hollowShapes == null) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateCircleMember(this.methodChannel, {
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
