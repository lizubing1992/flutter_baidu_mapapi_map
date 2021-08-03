import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMFPoint, BMFLog;
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_method_id.dart'
    show BMFProjectionMethodId;

/// Projection接口用于屏幕像素点坐标系统和地球表面经纬度点坐标系统之间的变换。
class BMFProjection {

  /// 通信
  MethodChannel? _mapChannel;

  BMFProjection(MethodChannel methodChannel) {
    _mapChannel = methodChannel;
  }

  /// 将屏幕坐标转换成地理坐标
  ///
  /// [BMFPoint] point 屏幕坐标 如果传入null 则返回null
  ///
  /// [BMFCoordinate] 地理坐标
  Future<BMFCoordinate?> convertScreenPointToCoordinate(BMFPoint? point) async {
    if (null == _mapChannel) {
      return null;
    }

    if (null == point) {
      return null;
    }
    BMFCoordinate? result;
    try {
      Map map = (await _mapChannel?.invokeMethod(
          BMFProjectionMethodId.kCoordinateFromScreenPointMethod,
          {'point': point.toMap()} as dynamic)) as Map;
      result = BMFCoordinate.fromMap(map['coordinate']);
    } on PlatformException catch (e) {
      BMFLog.e(e.toString());
    }

    return result;
  }

  /// 将地理坐标转换成屏幕坐标
  ///
  /// [BMFCoordinate] location 地理坐标 如果传入 null 则返回null
  ///
  /// [BMFPoint] 屏幕坐标
  Future<BMFPoint?> convertCoordinateToScreenPoint(
      BMFCoordinate? location) async {
    if (null == _mapChannel) {
      return null;
    }

    if (null == location) {
      return null;
    }

    BMFPoint? point;
    try {
      Map map = ((await _mapChannel?.invokeMethod(
          BMFProjectionMethodId.kScreenPointFromCoordinateMethod,
          {'coordinate': location.toMap()} as dynamic))) as Map;
      point = BMFPoint.fromMap(map['point']);
    } on PlatformException catch (e) {
      BMFLog.e(e.toString());
    }
    return point;
  }
}
