import 'package:flutter/foundation.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

/// 镂空类型
enum BMFHollowShapeType {
  /// 圆形镂空
  circle,

  /// 多边形镂空
  polygon
}

/// 镂空图形数据模型
/// 注意：一个实例BMFHollowShape对象只可对应一个镂空区域
class BMFHollowShape implements BMFModel {
  /// 镂空类型
  BMFHollowShapeType? hollowShapeType;

  /// *********以下属性为多边形镂空属性**********
  /// 多边形镂空区域 赋值coordinates
  /// 经纬度数组
  List<BMFCoordinate?>? coordinates;

  /// ********以下属性为圆形镂空属性***********
  /// 圆形镂空区域 赋值center radius
  /// 圆心点经纬度
  BMFCoordinate? center;

  /// 圆的半径(单位米)
  double? radius;

  /// 多边形镂空
  BMFHollowShape.polygon({required this.coordinates}) {
    hollowShapeType = BMFHollowShapeType.polygon;
  }

  /// 圆形镂空
  BMFHollowShape.circle({required this.center, this.radius}) {
    hollowShapeType = BMFHollowShapeType.circle;
  }

  /// 有参构造
  BMFHollowShape(
      {@required this.hollowShapeType,
      this.coordinates,
      this.center,
      this.radius});

  /// map => BMFHollowShape
  BMFHollowShape.fromMap(Map map)
      : assert(map.containsKey('coordinates')),
        assert(map.containsKey('center')) {
    if (map['coordinates'] != null) {
      coordinates = <BMFCoordinate>[];
      map['coordinates'].forEach((v) {
        coordinates?.add(BMFCoordinate.fromMap(v as Map));
      });
    }
    hollowShapeType = map['hollowShapeType'] == null
        ? null
        : BMFHollowShapeType.values[map['hollowShapeType'] as int];
    center =
        map['center'] == null ? null : BMFCoordinate.fromMap(map['center']);
    radius = map['radius'];
  }
  @override
  fromMap(Map map) {
    return BMFHollowShape.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'hollowShapeType': this.hollowShapeType?.index,
      'coordinates': this.coordinates?.map((e) => e?.toMap())?.toList(),
      'center': this.center?.toMap(),
      'radius': this.radius
    };
  }
}
