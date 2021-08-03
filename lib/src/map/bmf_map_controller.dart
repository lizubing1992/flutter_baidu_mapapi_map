import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/src/map/bmf_projection.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_baseindoormap_info.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_custommap_option.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_heatmap.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_infowindow.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_map_options.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_mapstatus.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_userlocation.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_arcline.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_circle.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_dot.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_ground.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_marker.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_polygon.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_polyline.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_text.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_tile.dart';
import 'package:flutter_baidu_mapapi_map/src/private/bmf_method_channel_handler.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';

/// 地图通信中心
class BMFMapController {
  // static const _tag = "BMFMapController";

  /// 通信
  late MethodChannel _mapChannel;

  late BMFMethodChannelHandler _methodChannelHandler;

  late BMFProjection _BMFProjection;

  BMFMapController.withId(int id) {
    _init(id);
  }

  void _init(int id) {
    _mapChannel = MethodChannel('flutter_bmfmap/map_$id');
    _methodChannelHandler = new BMFMethodChannelHandler();
    _mapChannel.setMethodCallHandler(_handlerMethod);
    _BMFProjection = BMFProjection(_mapChannel);
  }

  /// flutter -> native
  ///
  /// 更新地图属性
  ///
  /// [BMFMapOptions] change 地图参数集合
  ///
  /// bool 更新成功返回true 失败false
  Future<bool> updateMapOptions(BMFMapOptions change) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .updateMapOptions(_mapChannel, change);
  }

  /// 获取地图状态
  ///
  /// [BMFMapStatus] mapStatus 地图状态
  Future<BMFMapStatus?> getMapStatus() async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .getMapStatus(_mapChannel);
  }

  /// 获取map的展示类型
  ///
  /// [BMFMapType] mapType 地图的展示类型
  Future<BMFMapType?> getMapType() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getMapType(_mapChannel);
  }

  /// 获取map的比例尺级别
  ///
  /// zoomLevel 比例尺级别
  Future<int?> getZoomLevel() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getZoomLevel(_mapChannel);
  }

  /// 获取map的自定义最小比例尺级别
  ///
  /// minZoomLevel 自定义最小比例尺级别
  Future<int?> getMinZoomLevel() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getMinZoomLevel(_mapChannel);
  }

  /// 获取map的自定义最大比例尺级别
  ///
  /// maxZoomLevel  自定义最大比例尺级别
  Future<int?> getMaxZoomLevel() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getMaxZoomLevel(_mapChannel);
  }

  /// 获取map的旋转角度
  ///
  /// rotation  旋转角度
  Future<double?> getRotation() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getRotation(_mapChannel);
  }

  /// 获取map的地图俯视角度
  ///
  /// overlooking 地图俯视角度
  Future<double?> getOverlooking() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getOverlooking(_mapChannel);
  }

  /// 获取map的俯视角度最小值
  ///
  /// minOverlooking 俯视角度最小值
  ///
  /// ios 独有
  Future<int?> getMinOverlooking() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getMinOverlooking(_mapChannel);
  }

  /// 获取map是否现显示3D楼块效果
  ///
  /// buildingsEnabled 是否现显示3D楼块效果
  Future<bool?> getBuildingsEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getBuildingsEnabled(_mapChannel);
  }

  /// 获取map是否显示底图poi标注
  ///
  /// showMapPoi  是否显示底图poi标注
  ///
  /// ios 独有
  Future<bool?> getShowMapPoi() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getShowMapPoi(_mapChannel);
  }

  /// 获取map是否打开路况图层(在某些Android机型上，路况图无法正常展示)
  ///
  /// trafficEnabled 是否打开路况图层
  Future<bool?> getTrafficEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getTrafficEnabled(_mapChannel);
  }

  /// 获取map是否打开百度城市热力图图层
  ///
  /// baiduHeatMapEnabled  是否打开百度城市热力图图层
  Future<bool?> getBaiduHeatMapEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getBaiduHeatMapEnabled(_mapChannel);
  }

  /// 获取map是否支持所有手势操作
  ///
  /// gesturesEnabled  是否支持所有手势操作
  Future<bool?> getGesturesEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getGesturesEnabled(_mapChannel);
  }

  /// 获取map是否支持用户多点缩放(双指)
  ///
  /// zoomEnabled  是否支持用户多点缩放(双指)
  ///
  /// android 中效果是否允许缩放手势包括（双击,双指单击,双指缩放）
  Future<bool?> getZoomEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getZoomEnabled(_mapChannel);
  }

  /// 获取map是否支持用户缩放(双击或双指单击)
  ///
  /// zoomEnabledWithTap  是否支持用户缩放(双击或双指单击)
  ///
  /// ios 独有
  Future<bool?> getZoomEnabledWithTap() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getZoomEnabledWithTap(_mapChannel);
  }

  /// 获取map是否支持用户移动地图
  ///
  /// scrollEnabled  是否支持用户移动地图
  Future<bool?> getScrollEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getScrollEnabled(_mapChannel);
  }

  /// 获取map是否支持俯仰角
  ///
  /// overlookEnabled  是否支持俯仰角
  Future<bool?> getOverlookEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getOverlookEnabled(_mapChannel);
  }

  /// 获取map是否支持旋转
  ///
  /// rotateEnabled  是否支持旋转
  Future<bool?> getRotateEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getRotateEnabled(_mapChannel);
  }

  /// 获取map是否支持3Dtouch
  ///
  /// forceTouchEnabled  是否支持3Dtouch
  ///
  /// ios 独有
  Future<bool?> getForceTouchEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getForceTouchEnabled(_mapChannel);
  }

  /// 获取map是否显式比例尺
  ///
  /// showMapScaleBar  是否显式比例尺
  ///
  /// ios 独有
  Future<bool?> getShowMapScaleBar() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getShowMapScaleBar(_mapChannel);
  }

  /// 获取map的比例尺的位置
  ///
  /// mapScaleBarPosition  比例尺的位置
  Future<BMFPoint?> getMapScaleBarPosition() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getMapScaleBarPosition(_mapChannel);
  }

  /// 获取map的logo位置
  ///
  /// logoPosition  地图logo的位置
  Future<BMFLogoPosition?> getLogoPosition() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getLogoPosition(_mapChannel);
  }

  /// 获取map的可视范围
  ///
  /// visibleMapBounds  地图的可视范围
  Future<BMFCoordinateBounds?> getVisibleMapBounds() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getVisibleMapBounds(_mapChannel);
  }

  /// 获取map是否显示室内图
  ///
  /// baseIndoorMapEnabled  是否显示室内图
  Future<bool?> getBaseIndoorMapEnabled() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getBaseIndoorMapEnabled(_mapChannel);
  }

  /// 获取map的室内图标注是否显示
  ///
  /// showIndoorMapPoi  室内图标注是否显示
  ///
  /// ios 独有
  Future<bool?> getShowIndoorMapPoi() async {
    return await BMFMapDispatcherFactory.instance.mapGetStateDispatcher
        .getShowIndoorMapPoi(_mapChannel);
  }

  /// map放大一级比例尺
  ///
  /// bool 成功返回true 失败false
  Future<bool?> zoomIn() async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .zoomIn(_mapChannel);
  }

  /// map缩小一级比例尺
  ///
  /// bool 成功返回true 失败false
  Future<bool> zoomOut() async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .zoomOut(_mapChannel);
  }

  /// 自定义路况颜色。
  ///
  /// 注意：如果需要自定义路况颜色，必须4种路况全都设置。4个参数全部合法时，自定义颜色才有效；否则全部使用默认的。
  ///
  /// smooth 路况畅通对应的颜色
  ///
  /// slow 路况缓行对应的颜色
  ///
  /// congestion 路况拥堵对应的颜色
  ///
  /// severeCongestion 路况严重拥堵对应的颜色
  ///
  /// bool 成功返回true 失败false
  Future<bool> setCustomTrafficColor(
      {required Color smooth,
      required Color slow,
      required Color congestion,
      required Color severeCongestion}) async {
    return await BMFMapDispatcherFactory()
        .mapStatusDispatcher
        .setCustomTrafficColor(
            _mapChannel, smooth, slow, congestion, severeCongestion);
  }

  /// 更新地图新状态
  ///
  /// [BMFMapStatus] mapStatus 地图新状态
  ///
  /// animateDurationMs 动画更新时间
  ///
  /// bool 成功返回true 失败false
  Future<bool> setNewMapStatus(
      {required BMFMapStatus mapStatus, int? animateDurationMs}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setNewMapStatus(_mapChannel,
            mapStatus: mapStatus, animateDurationMs: animateDurationMs);
  }

  /// 按像素移动地图中心点(Android独有)
  ///
  /// xPixel 水平方向移动像素数
  ///
  /// yPixel 垂直方向移动像素数
  ///
  /// animateDurationMs 动画更新时间
  ///
  /// bool 成功返回true 失败false
  Future<bool> setScrollBy(int xPixel, int yPixel,
      {int? animateDurationMs}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setScrollBy(_mapChannel, xPixel, yPixel,
            animateDurationMs: animateDurationMs);
  }

  /// 根据给定增量缩放地图级别(Android独有)
  ///
  /// amount 地图缩放级别增量
  ///
  /// animateDurationMs 动画更新时间
  ///
  /// bool 成功返回true 失败false
  Future<bool> setZoomBy(double amount, {int? animateDurationMs}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setZoomBy(_mapChannel, amount, animateDurationMs: animateDurationMs);
  }

  /// 根据给定增量以及给定的屏幕坐标缩放地图级别(Android独有)
  ///
  /// amount 地图缩放级别增量
  ///
  /// [BMFPoint] focus  地图缩放中心点屏幕坐标, 若为 null 则返回 null
  ///
  /// animateDurationMs 动画更新时间
  ///
  /// bool 成功返回true 失败false
  Future<bool> setZoomPointBy(double amount, BMFPoint focus,
      {int? animateDurationMs}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setZoomPointBy(_mapChannel, amount, focus,
            animateDurationMs: animateDurationMs);
  }

  /// 设置地图缩放级别(Android独有)
  ///
  /// zoom 设置地图缩放级别
  ///
  /// animateDurationMs 动画更新时间
  ///
  /// bool 成功返回true 失败false
  Future<bool> setZoomTo(double zoom, {int? animateDurationMs}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setZoomTo(_mapChannel, zoom, animateDurationMs: animateDurationMs);
  }

  /// 设定地图中心点坐标
  ///
  /// [BMFCoordinate] coordinate 要设定的地图中心点坐标，用经纬度表示
  ///
  /// animated 是否采用动画效果(ios 独有)
  ///
  /// animateDurationMs 动画更新时间(android 独有)
  ///
  /// bool 成功返回true 失败false
  Future<bool> setCenterCoordinate(BMFCoordinate coordinate, bool animated,
      {int? animateDurationMs}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setCenterCoordinate(_mapChannel, coordinate, animated,
            animateDurationMs: animateDurationMs);
  }

  /// 设置地图中心点以及缩放级别(IOS不支持该接口)
  ///
  /// [BMFCoordinate]coordinate 要设定的地图中心点坐标，用经纬度表示
  /// zoom 缩放级别
  ///
  /// animateDurationMs 动画时间
  ///
  /// bool 成功返回true 失败false
  Future<bool> setNewLatLngZoom(
      {required BMFCoordinate coordinate,
      required double zoom,
      int? animateDurationMs}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setNewLatLngZoomDispatcher(_mapChannel,
            coordinate: coordinate,
            zoom: zoom,
            animateDurationMs: animateDurationMs);
  }

  /// 获得地图当前可视区域截图
  ///
  /// 范围内的截取的Images
  Future<Uint8List?> takeSnapshot() async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .takeSnapshot(_mapChannel);
  }

  /// 获得地图指定区域截图 (ios) 处理方式
  ///
  /// 指定区域的截取的Image
  Future<Uint8List?> takeSnapshotWithRect(BMFMapRect rect) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .takeSnapshotWithRect(_mapChannel, rect);
  }

  /// 设置罗盘的图片
  ///
  /// imagePath 设置的图片
  ///
  /// bool 成功返回true 失败false
  Future<bool> setCompassImage(String imagePath) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setCompassImage(_mapChannel, imagePath);
  }

  /// 设置显示在屏幕中的地图地理范围
  ///
  /// [BMFCoordinateBounds]visibleMapBounds 要设定的地图范围(东北，西南)角坐标
  ///
  /// animated 是否采用动画效果 (ios 独有)
  ///
  /// bool 成功返回true 失败false
  Future<bool> setVisibleMapBounds(
      BMFCoordinateBounds visibleMapBounds, bool animated) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setVisibleMapBounds(_mapChannel, visibleMapBounds, animated);
  }

  /// 设置显示在指定相对于MapView的padding中的地图地理范围
  ///
  /// [BMFCoordinateBounds]visibleMapBounds 要设定的地图范围(东北，西南)角坐标
  ///
  /// [EdgeInsets]insets 指定的四周边界大小
  ///
  /// animated 是否采用动画效果(ios 独有)
  ///
  /// bool 成功返回true 失败false
  Future<bool> setVisibleMapRectWithPaddingHandler(
      {required BMFCoordinateBounds visibleMapBounds,
      required EdgeInsets insets,
      required bool animated}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setVisibleMapRectWithPadding(
            _mapChannel, visibleMapBounds, insets, animated);
  }

  /// 地图设定是否显示定位图层
  ///
  /// show 展示ture 隐藏false
  ///
  /// bool 成功返回true 失败false
  Future<bool> showUserLocation(bool show) async {
    return await BMFMapDispatcherFactory.instance.mapUserLocationDispatcher
        .setShowUserLocation(_mapChannel, show);
  }

  /// 设定定位模式
  ///
  /// [BMFUserTrackingMode]userTrackingMode 定位模式
  ///
  /// enableDirection  是否允许显示方向信息 (Android 独有）
  ///
  /// customMarker  设置用户自定义定位图标，可以为 null (Android  独有)
  ///
  /// bool 成功返回true 失败false
  Future<bool> setUserTrackingMode(BMFUserTrackingMode userTrackingMode,
      {bool enableDirection = true, String? customMarker}) async {
    return await BMFMapDispatcherFactory.instance.mapUserLocationDispatcher
        .setUserTrackingMode(_mapChannel, userTrackingMode, enableDirection,
            customMarker: customMarker);
  }

  /// 定位坐标点是否在当前地图可视区域内
  ///
  /// bool true在当前地图可视区域内 false 不在在当前地图可视区域内
  ///
  /// Android 不支持该方法
  Future<bool> isUserLocationVisible() async {
    return await BMFMapDispatcherFactory.instance.mapUserLocationDispatcher
        .setIsUserLocationVisible(_mapChannel);
  }

  /// 动态更新我的位置数据
  ///
  /// [BMFUserLocation]userLocation	定位数据
  ///
  /// bool 成功返回true 失败false
  Future<bool> updateLocationData(BMFUserLocation userLocation) async {
    return await BMFMapDispatcherFactory.instance.mapUserLocationDispatcher
        .setUpdateLocationData(_mapChannel, userLocation);
  }

  /// 动态定制我的位置样式
  ///
  /// [BMFUserLocationDisplayParam]userlocationDisplayParam	样式参数
  ///
  /// bool 成功返回true 失败false
  Future<bool> updateLocationViewWithParam(
      BMFUserLocationDisplayParam userlocationDisplayParam) async {
    return await BMFMapDispatcherFactory.instance.mapUserLocationDispatcher
        .setUpdateLocationViewWithParam(_mapChannel, userlocationDisplayParam);
  }

  /// 地图添加Marker
  ///
  /// [BMFMarker] marker 大头针
  ///
  /// bool 成功返回true 失败false
  Future<bool> addMarker(BMFMarker marker) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .addMarker(_mapChannel, marker);
  }

  /// 地图添加Markers
  ///
  /// [BMFMarker]集合 markers 大头针list,
  ///
  /// bool 成功返回true 失败false
  Future<bool> addMarkers(List<BMFMarker> markers) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .addMarkers(_mapChannel, markers);
  }

  /// 地图添加[BMFInfoWindow] infoWindow
  Future<bool> addInfoWindow(BMFInfoWindow infoWindow) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .addInfoWindow(_mapChannel, infoWindow);
  }

  /// 地图批量添加[BMFInfoWindow] infoWindow
  Future<bool> addInfoWindows(List<BMFInfoWindow> infoWindows) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .addInfoWindows(_mapChannel, infoWindows);
  }

  /// 地图移除[BMFInfoWindow] infoWindow
  Future<bool> removeInfoWindow(BMFInfoWindow infoWindow) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .removeInfoWindow(_mapChannel, infoWindow);
  }

  /// 地图指定删除Marker
  ///
  /// [BMFMarker] marker 要移除的大头针
  ///
  /// bool 成功返回true 失败false
  Future<bool> removeMarker(BMFMarker marker) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .removeMarker(_mapChannel, marker);
  }

  /// 地图批量删除Markers
  ///
  /// [BMFMarker]集合 markers 要移除的大头针list
  ///
  /// bool 成功返回true 失败false
  Future<bool> removeMarkers(List<BMFMarker> markers) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .removeMarkers(_mapChannel, markers);
  }

  /// 地图清除所有Markers
  ///
  /// bool 成功返回true 失败false
  Future<bool> cleanAllMarkers() async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .cleanAllMarkers(_mapChannel);
  }

  /// 选中marker
  ///
  /// bool 成功返回true 失败false
  Future<bool> selectMarker(BMFMarker marker) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .selectMarker(_mapChannel, marker);
  }

  /// 取消指定的marker的选中状态
  ///
  /// bool 成功返回true 失败false
  Future<bool> deselectMarker(BMFMarker marker) async {
    return await BMFMapDispatcherFactory.instance.markerDispatcher
        .deselectMarker(_mapChannel, marker);
  }

  /// 地图添加Polyine
  ///
  /// [BMFPolyline] polyline 折线
  ///
  /// bool 成功返回true 失败false
  Future<bool> addPolyline(BMFPolyline polyline) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .addPolyline(_mapChannel, polyline);
  }

  /// 地图添加Arcline
  ///
  /// [BMFArcLine] arcline 弧线
  ///
  /// bool 成功返回true 失败false
  Future<bool> addArcline(BMFArcLine arcline) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .addArcline(_mapChannel, arcline);
  }

  /// 地图添加Polygon
  ///
  /// [BMFPolygon] polygon 多边形
  ///
  /// bool 成功返回true 失败false
  Future<bool> addPolygon(BMFPolygon polygon) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .addPolygon(_mapChannel, polygon);
  }

  /// 地图添加Circle
  ///
  /// [BMFCircle] circle 圆
  ///
  /// bool 成功返回true 失败false
  Future<bool> addCircle(BMFCircle circle) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .addCircle(_mapChannel, circle);
  }

  /// 地图添加Dot
  ///
  /// [BMFDot] dot 点
  ///
  /// bool 成功返回true 失败false
  Future<bool> addDot(BMFDot dot) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .addDot(_mapChannel, dot);
  }

  /// 地图添加[BMFText] Text
  Future<bool> addText(BMFText text) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .addText(_mapChannel, text);
  }

  /// 地图添加Ground
  ///
  /// [BMFGround] ground 图片图层
  ///
  /// bool 成功返回true 失败false
  Future<bool> addGround(BMFGround ground) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .addGround(_mapChannel, ground);
  }

  /// 地图指定删除overlay
  ///
  /// overlayId 要删除overlay的id
  ///
  /// bool 成功返回true 失败false
  Future<bool> removeOverlay(String overlayId) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .removeOverlay(_mapChannel, overlayId);
  }

  /// 添加热力图
  ///
  /// [BMFHeatMap] heatMap 热力图
  ///
  /// bool 成功返回true 失败false
  Future<bool> addHeatMap(BMFHeatMap heatMap) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .addHeatMap(_mapChannel, heatMap);
  }

  /// 删除热力图
  ///
  /// bool 成功返回true 失败false
  Future<bool> removeHeatMap() async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .removeHeatMap(_mapChannel);
  }

  /// 显示热力图(在某些Android机型上，该方法执行无效)
  ///
  /// show ture展示 false关闭
  ///
  /// bool 成功返回true 失败false
  Future<bool> showHeatMap(bool show) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .showHeatMap(_mapChannel, show);
  }

  /// 添加瓦片图(在线瓦片图在某些Android机型上暂时不生效，等后续升级解决)
  ///
  /// [BMFTile] tile 瓦片图
  ///
  /// bool 成功返回true 失败false
  Future<bool> addTile(BMFTile tile) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .addTile(_mapChannel, tile);
  }

  /// 移除瓦片图
  ///
  /// [BMFTile] tile 瓦片图
  /// bool 成功返回true 失败false
  Future<bool> removeTile(BMFTile tile) async {
    return await BMFMapDispatcherFactory.instance.overlayDispatcher
        .removeTile(_mapChannel, tile);
  }

  /// 是否展示室内地图
  ///
  /// show 展示true 隐藏false
  ///
  /// bool 成功返回true 失败false
  Future<bool> showBaseIndoorMap(bool show) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .showBaseIndoorMap(_mapChannel, show);
  }

  /// 室内图标注是否显示
  ///
  /// showPoi 展示true 隐藏false
  ///
  /// bool 成功返回true 失败false
  Future<bool> showBaseIndoorMapPoi(bool showPoi) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .showBaseIndoorMapPoi(_mapChannel, showPoi);
  }

  /// 设置室内图楼层
  ///
  /// floorId 楼层id
  ///
  /// indoorId 室内图ID
  ///
  /// [BMFSwitchIndoorFloorError] 枚举：室内图切换楼层结果
  Future<BMFSwitchIndoorFloorError?> switchBaseIndoorMapFloor(
      String? floorId, String? indoorId) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .switchBaseIndoorMapFloor(_mapChannel, floorId, indoorId);
  }

  /// 获取当前聚焦的室内图信息
  ///
  /// [BMFBaseIndoorMapInfo] 当前聚焦的室内图信息。没有聚焦的室内图，返回nil
  Future<BMFBaseIndoorMapInfo?> getFocusedBaseIndoorMapInfo() async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .getFocusedBaseIndoorMapInfo(_mapChannel);
  }

  /// 个性化地图样式开关，仅影响前mapView对象，需在地图创建后调用
  ///
  /// enable 当前自定义地图样式是否生效
  ///
  /// bool 成功返回true 失败false
  Future<bool> setCustomMapStyleEnable(bool enable) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setCustomMapStyleEnable(_mapChannel, enable);
  }

  /// 设置个性化地图样式路径，仅影响当前mapView对象，需在对象创建后调用
  ///
  /// path 本地个性化样式文件所在路径，包含文件名
  ///
  /// mode 加载模式，0:加载本地文件 1:加载在线文件或在线缓存文件
  ///
  /// bool 成功返回true 失败false
  Future<bool> setCustomMapStyle(String path, int mode) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setCustomMapStylePath(_mapChannel, path, mode);
  }

  /// 设置个性化地图样式路径，仅影响当前mapView对象，需在对象创建后调用
  ///
  /// 在线个性化样式加载状态回调接口。
  ///
  /// 在线个性化样式创建地址：http://lbsyun.baidu.com/apiconsole/custommap
  ///
  /// 调用该接口加载个性化样式的默认策略为：
  ///
  /// 1、优先通过[BMFCustomMapStyleOption]配置的个性化样式ID，加载在线个性化样式;
  ///
  /// 2、如果配置的个性化样式ID无效或在线个性化样式请求失败,则加载本地缓存的最新一次请求成功的在线个性化样式;
  ///
  /// 3、如果本地缓存中没有最新一次请求成功的在线个性化样式，则通过BMFCustomMapStyleOption中配置的本地离线样式路径加载本地样式;
  ///
  /// 4、如果以上样式加载都失败，则显示普通地图样式。
  ///
  /// [BMFCustomMapStyleOption] customMapStyleOption 在线个性化样式配置选项
  ///
  /// preLoad 当预加载成功时会执行的block对象，path：本地缓存的最新一次请求成功的在线个性化样式路径
  ///
  /// success 当加载成功时会执行的block对象，path：请求成功的在线个性化样式路径
  ///
  /// error 当加载未成功时会执行的block对象，error:失败错误信息，path:失败后根据策略加载的个性化样式路径（路径可能会为nil）
  ///
  /// bool 成功返回true 失败false
  Future<bool?> setCustomMapStyleWithOptionPath(
      {required BMFCustomMapStyleOption customMapStyleOption,
      required void Function(String path) preload,
      required void Function(String path) success,
      required void Function(int errorCode, String path) error}) async {
    return await BMFMapDispatcherFactory.instance.mapStatusDispatcher
        .setCustomMapStyleWithOption(
            _mapChannel, customMapStyleOption, preload, success, error);
  }

  /// 地图代理回调
  ///
  /// native -> flutter
  Future<dynamic> _handlerMethod(MethodCall call) async {
    // BMFLog.d("_handlerMethod", tag: _tag);
    if (_methodChannelHandler != null) {
      return await _methodChannelHandler.handlerMethod(call);
    }
  }

  /// 设置地图加载完成回调
  ///
  /// [BMFMapCallback] callback 回调接口
  void setMapDidLoadCallback({required BMFMapCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapDidLoadCallback(callback);
    }
  }

  /// 设置地图渲染回调
  ///
  /// [BMFMapSuccessCallback] callback 回调接口
  void setMapDidFinishedRenderCallback(
      {required BMFMapSuccessCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapDidFinishedRenderCallback(callback);
    }
  }

  /// 设置地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）回调接口
  ///
  /// [BMFMapOnDrawMapFrameCallback] callback 回调接口
  void setMapOnDrawMapFrameCallback(
      {required BMFMapOnDrawMapFrameCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapOnDrawMapFrameCallback(callback);
    }
  }

  /// 设置地图区域即将改变时会调用接口
  ///
  /// [BMFMapRegionChangeCallback] callback 回调接口
  void setMapRegionWillChangeCallback(
      {required BMFMapRegionChangeCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapRegionWillChangeCallback(callback);
    }
  }

  /// 设置地图区域改变完成后会调用接口
  ///
  /// [BMFMapRegionChangeCallback] callback 回调接口
  void setMapRegionDidChangeCallback(
      {required BMFMapRegionChangeCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapRegionDidChangeCallback(callback);
    }
  }

  /// 设置地图区域即将改变时会调用接口
  ///
  /// [BMFMapRegionChangeReasonCallback] callback 回调接口
  void setMapRegionWillChangeWithReasonCallback(
      {required BMFMapRegionChangeReasonCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapRegionWillChangeWithReasonCallback(callback);
    }
  }

  /// 设置地图区域改变完成后会调用接口
  ///
  /// [BMFMapRegionChangeReasonCallback] callback
  void setMapRegionDidChangeWithReasonCallback(
      {required BMFMapRegionChangeReasonCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapRegionDidChangeWithReasonCallback(callback);
    }
  }

  /// 设置地图点击覆盖物回调，目前只支持[BMFPolyline]polyline
  ///
  /// [BMFMapOnClickedOverlayCallback] callback
  ///
  /// polyline只返回了id 与 polylineOptions
  void setMapOnClickedOverlayCallback(
      {required BMFMapOnClickedOverlayCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapOnClickedOverlayCallback(callback);
    }
  }

  /// 设置点中底图标注后会回调接口
  ///
  /// [BMFMapOnClickedMapPoiCallback] callback 回调接口
  void setMapOnClickedMapPoiCallback(
      {required BMFMapOnClickedMapPoiCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapOnClickedMapPoiCallback(callback);
    }
  }

  /// 设置点中底图空白处会回调接口
  ///
  /// [BMFMapCoordinateCallback] callback 回调接口
  void setMapOnClickedMapBlankCallback(
      {required BMFMapCoordinateCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapOnClickedMapBlankCallback(callback);
    }
  }

  /// 设置双击地图时会回调接口
  ///
  /// [BMFMapCoordinateCallback] callback 回调接口
  void setMapOnDoubleClickCallback(
      {required BMFMapCoordinateCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapOnDoubleClickCallback(callback);
    }
  }

  /// 设置长按地图时会回调接口
  ///
  /// [BMFMapCoordinateCallback] callback 回调接口
  void setMapOnLongClickCallback({required BMFMapCoordinateCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapOnLongClickCallback(callback);
    }
  }

  /// 设置3DTouch回调接口
  ///
  /// [BMFMapOnForceTouchCallback] callback 回调接口
  void setMapOnForceTouchCallback(
      {required BMFMapOnForceTouchCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapOnForceTouchCallback(callback);
    }
  }

  /// 设置地图状态改变完成后回调接口
  ///
  /// [BMFMapCallback] callback 回调接口
  void setMapStatusDidChangedCallback({required BMFMapCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapStatusDidChangedCallback(callback);
    }
  }

  /// 设置地图View进入/移出室内地图回调接口
  ///
  /// [BMFMapInOrOutBaseIndoorMapCallback] callback 回调接口
  void setMapInOrOutBaseIndoorMapCallback(
      {required BMFMapInOrOutBaseIndoorMapCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapInOrOutBaseIndoorMapCallback(callback);
    }
  }

  /// 设置marker点击回调
  ///
  /// [BMFMapMarkerCallback] callback 回调接口
  void setMapClickedMarkerCallback({required BMFMapMarkerCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapClickedMarkerCallback(callback);
    }
  }

  /// 设置marker选中回调
  ///
  /// [BMFMapMarkerCallback] callback 回调接口
  ///
  /// Android不支持该接口
  void setMaptDidSelectMarkerCallback(
      {required BMFMapMarkerCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMaptDidSelectMarkerCallback(callback);
    }
  }

  /// 设置marker取消回调
  ///
  /// [BMFMapMarkerCallback] callback 回调接口
  ///
  /// Android不支持该接口
  void setMapDidDeselectMarkerCallback(
      {required BMFMapMarkerCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapDidDeselectMarkerCallback(callback);
    }
  }

  /// 设置marker拖拽回调
  ///
  /// [BMFMapMarkerCallback] callback 回调接口
  void setMapDragMarkerCallback({required BMFMapDragMarkerCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapDragMarkerCallback(callback);
    }
  }

  /// 设置marker的infoWindow（iOS paopaoView）点击回调
  ///
  /// [BMFMapMarkerCallback] callback 回调接口
  void setMapDidClickedInfoWindowCallback(
      {required BMFMapMarkerCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapDidClickedInfoWindowCallback(callback);
    }
  }

  /// 设置地图绘制出有效数据的监听回调接口
  ///
  /// [BMFMapRenderValidDataCallback] callback 回调接口
  ///
  /// ios不支持该接口
  void setMapRenderValidDataCallback(
      {required BMFMapRenderValidDataCallback callback}) {
    if (_methodChannelHandler != null || callback != null) {
      _methodChannelHandler.setMapRenderValidDataCallback(callback);
    }
  }
}
