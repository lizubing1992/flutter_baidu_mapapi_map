import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'bmf_map_method_id.dart' show BMFMapGetPropertyMethodId;

/// 获取地图状态
class BMFMapGetStateDispatcher {
  /// 获取map的展示类型
  Future<BMFMapType?> getMapType(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    BMFMapType? mapType;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetMapTypeMethod);
      mapType = BMFMapType.values[result['mapType'] as int];
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return mapType;
  }

  /// 获取map的比例尺级别
  Future<int?> getZoomLevel(MethodChannel?_mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    int? zoomLevel;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetZoomLevelMethod);
      zoomLevel = result['zoomLevel'] as int;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return zoomLevel;
  }

  /// 获取map的自定义最小比例尺级别
  Future<int?> getMinZoomLevel(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    int? minZoomLevel;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetMinZoomLevelMethod);
      minZoomLevel = result['minZoomLevel'] as int;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return minZoomLevel;
  }

  /// 获取map的自定义最大比例尺级别
  Future<int?> getMaxZoomLevel(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    int? maxZoomLevel;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetMaxZoomLevelMethod);
      maxZoomLevel = result['maxZoomLevel'] as int;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return maxZoomLevel;
  }

  /// 获取map的旋转角度
  Future<double?> getRotation(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    double? rotation;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetRotationMethod);
      rotation = result['rotation'] as double;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return rotation;
  }

  /// 获取map的地图俯视角度
  Future<double?> getOverlooking(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    double? overlooking;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetOverlookingMethod);
      overlooking = result['overlooking'] as double;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return overlooking;
  }

  /// 获取map的俯视角度最小值
  ///
  ///  ios 独有
  Future<int?> getMinOverlooking(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    int? minOverlooking;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetMinOverlookingMethod);
      minOverlooking = result['minOverlooking'] as int;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return minOverlooking;
  }

  /// 获取map的是否现显示3D楼块效果
  Future<bool?> getBuildingsEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? buildingsEnabled;
    try {
      Map result = await _mapChannel.invokeMethod(
          BMFMapGetPropertyMethodId.kMapGetBuildingsEnabledMethod);
      buildingsEnabled = result['buildingsEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return buildingsEnabled;
  }

  /// 获取map的是否显示底图poi标注
  ///
  /// ios 独有
  Future<bool?> getShowMapPoi(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? showMapPoi;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetShowMapPoiMethod);
      showMapPoi = result['showMapPoi'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return showMapPoi;
  }

  /// 获取map的是否打开路况图层
  Future<bool?> getTrafficEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? trafficEnabled;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetTrafficEnabledMethod);
      trafficEnabled = result['trafficEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return trafficEnabled;
  }

  /// 获取map的是否打开百度城市热力图图层
  Future<bool?> getBaiduHeatMapEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? baiduHeatMapEnabled;
    try {
      Map result = await _mapChannel.invokeMethod(
          BMFMapGetPropertyMethodId.kMapGetBaiduHeatMapEnabledMethod);
      baiduHeatMapEnabled = result['baiduHeatMapEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return baiduHeatMapEnabled;
  }

  /// 获取map的是否支持所有手势操作
  Future<bool?> getGesturesEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? gesturesEnabled;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetGesturesEnabledMethod);
      gesturesEnabled = result['gesturesEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return gesturesEnabled;
  }

  /// 获取map的是否支持用户多点缩放(双指)
  ///
  /// android 中效果是否允许缩放手势包括（双击,双指单击,双指缩放）
  Future<bool?> getZoomEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? zoomEnabled;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetZoomEnabledMethod);
      zoomEnabled = result['zoomEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return zoomEnabled;
  }

  /// 获取map的是否支持用户缩放(双击或双指单击)
  ///
  /// ios 独有
  Future<bool?> getZoomEnabledWithTap(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? zoomEnabledWithTap;
    try {
      Map result = await _mapChannel.invokeMethod(
          BMFMapGetPropertyMethodId.kMapGetZoomEnabledWithTapMethod);
      zoomEnabledWithTap = result['zoomEnabledWithTap'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return zoomEnabledWithTap;
  }

  /// 获取map的是否支持用户移动地图
  Future<bool?> getScrollEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? scrollEnabled;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetScrollEnabledMethod);
      scrollEnabled = result['scrollEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return scrollEnabled;
  }

  /// 获取map的是否支持俯仰角
  Future<bool?> getOverlookEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? overlookEnabled;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetOverlookEnabledMethod);
      overlookEnabled = result['overlookEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return overlookEnabled;
  }

  /// 获取map的是否支持旋转
  Future<bool?> getRotateEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? rotateEnabled;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetRotateEnabledMethod);
      rotateEnabled = result['rotateEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return rotateEnabled;
  }

  /// 获取map的是否支持3Dtouch
  ///
  /// ios 独有
  Future<bool?> getForceTouchEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? forceTouchEnabled;
    try {
      Map result = await _mapChannel.invokeMethod(
          BMFMapGetPropertyMethodId.kMapGetForceTouchEnabledMethod);
      forceTouchEnabled = result['forceTouchEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return forceTouchEnabled;
  }

  /// 获取map的是否显式比例尺
  ///
  /// ios 独有
  Future<bool?> getShowMapScaleBar(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? showMapScaleBar;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetShowMapScaleBarMethod);
      showMapScaleBar = result['showMapScaleBar'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return showMapScaleBar;
  }

  /// 获取map的比例尺的位置
  Future<BMFPoint?> getMapScaleBarPosition(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    BMFPoint? mapScaleBarPosition;
    try {
      Map result = await _mapChannel.invokeMethod(
          BMFMapGetPropertyMethodId.kMapGetMapScaleBarPositionMethod);
      if (null == result) {
        return null;
      }
      mapScaleBarPosition = BMFPoint.fromMap(result['mapScaleBarPosition']);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return mapScaleBarPosition;
  }

  /// 获取map的logo位置
  Future<BMFLogoPosition?> getLogoPosition(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    BMFLogoPosition? logoPosition;
    try {
      Map result = await _mapChannel
          .invokeMethod(BMFMapGetPropertyMethodId.kMapGetLogoPositionMethod);
      if (null == result) {
        return null;
      }
      logoPosition = BMFLogoPosition.values[result['logoPosition'] as int];
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return logoPosition;
  }

  /// 获取map的可视范围
  Future<BMFCoordinateBounds?> getVisibleMapBounds(
      MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    BMFCoordinateBounds? visibleMapBounds;
    try {
      Map result = await _mapChannel.invokeMethod(
          BMFMapGetPropertyMethodId.kMapGetVisibleMapBoundsMethod);
      visibleMapBounds =
          BMFCoordinateBounds.fromMap(result['visibleMapBounds']);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return visibleMapBounds;
  }

  /// 获取map的显示室内图
  Future<bool?> getBaseIndoorMapEnabled(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? baseIndoorMapEnabled;
    try {
      Map result = await _mapChannel.invokeMethod(
          BMFMapGetPropertyMethodId.kMapGetBaseIndoorMapEnabledMethod);
      baseIndoorMapEnabled = result['baseIndoorMapEnabled'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return baseIndoorMapEnabled;
  }

  /// 获取map的室内图标注是否显示
  ///
  /// ios 独有
  Future<bool?> getShowIndoorMapPoi(MethodChannel? _mapChannel) async {
    if (_mapChannel == null) {
      return null;
    }
    bool? showIndoorMapPoi;
    try {
      Map result = await _mapChannel.invokeMethod(
          BMFMapGetPropertyMethodId.kMapGetShowIndoorMapPoiMethod);
      showIndoorMapPoi = result['showIndoorMapPoi'] as bool;
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return showIndoorMapPoi;
  }
}
