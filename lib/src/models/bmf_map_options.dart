import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

/// mapView属性集合
class BMFMapOptions {
  /// 当前地图类型，默认标准地图
  ///
  /// MapTypeNone = MapTypeNone
  ///
  /// 标准地图 = MapTypeStandard
  ///
  /// 卫星地图 = MapTypeSatellite
  BMFMapType? mapType;

  /// 限制地图的显示范围（地图状态改变时，该范围不会在地图显示范围外。设置成功后，会调整地图显示该范围）
  BMFCoordinateBounds? limitMapBounds;

  /// 指南针的位置，设定坐标以BMKMapView左上角为原点，向右向下增长
  BMFPoint? compassPosition;

  /// 是否显示指南针
  bool? compassEnabled;

  /// 当前地图的中心点，改变该值时，地图的比例尺级别不会发生变化
  BMFCoordinate? center;

  /// 地图比例尺级别，在手机上当前可使用的级别为4-21级
  int? zoomLevel;

  /// 地图的自定义最小比例尺级别
  int? minZoomLevel;

  /// 地图的自定义最大比例尺级别
  int? maxZoomLevel;

  /// 地图旋转角度，在手机上当前可使用的范围为－180～180度 (ios取int值)
  double? rotation;

  /// 地图俯视角度，在手机上当前可使用的范围为－45～0度 (ios取int值)
  double? overlooking;

  /// 地图俯视角度最小值（即角度最大值），在手机上当前可设置的范围为-79～0度
  ///
  /// iOS独有
  int? minOverlooking;

  /// 设定地图是否现显示3D楼块效果
  bool? buildingsEnabled;

  /// 设定地图是否显示底图poi标注(不包含室内图标注)，默认true
  bool? showMapPoi;

  /// 设定地图是否打开路况图层
  bool? trafficEnabled;

  /// 设定地图是否打开百度城市热力图图层（百度自有数据）,
  ///
  /// 注：地图层级大于11时，可显示热力图
  bool? baiduHeatMapEnabled;

  /// 设定地图View能否支持所有手势操作
  bool? gesturesEnabled;

  /// 设定地图View能否支持用户多点缩放(双指)
  bool? zoomEnabled;

  /// 设定地图View能否支持用户缩放(双指单击)
  bool? zoomEnabledWithTap;

  /// 设定地图View能否支持用户缩放(单指双击)
  bool? zoomEnabledWithDoubleClick;

  /// 设定地图View能否支持用户移动地图
  bool? scrollEnabled;

  /// 设定地图View能否支持俯仰角
  bool? overlookEnabled;

  /// 设定地图View能否支持旋转
  bool? rotateEnabled;

  /// 设定地图是否回调force touch事件，默认为false，仅适用于支持3D Touch的情况，
  ///
  /// 开启后会回调 - mapview:onForceTouch:force:maximumPossibleForce:
  ///
  /// iOS独有
  bool? forceTouchEnabled;

  /// 设定是否显示比例尺
  bool? showMapScaleBar;

  /// 比例尺的位置，设定坐标以BMFMapWidget左上角为原点，向右向下增长
  BMFPoint? mapScaleBarPosition;

  /// 设置是否先是缩放控件
  ///
  /// Android独有
  bool? showZoomControl;

  /// 缩放控件的位置，设定坐标以BMFMapWidget左上角为原点，向右向下增长
  ///
  /// Android独有
  BMFPoint? mapZoomControlPosition;

  /// logo位置 默认BMFLogoPositionLeftBottom
  BMFLogoPosition? logoPosition;

  /// 当前地图可显示范围(东北，西南)角坐标
  BMFCoordinateBounds? visibleMapBounds;

  /// 地图预留边界，默认：(top:0, left:0, bottom:0, right:0)。
  ///
  /// 注：设置后，会根据mapPadding调整logo、比例尺、指南针的位置。
  ///
  /// 当updateTargetScreenPtWhenMapPaddingChanged==true时，地图中心(屏幕坐标：BMKMapStatus.targetScreenPt)跟着改变
  BMFEdgeInsets? mapPadding;

  /// 设置mapPadding时，地图中心(屏幕坐标：BMKMapStatus.targetScreenPt)是否跟着改变，默认true
  ///
  /// iOS独有
  bool? updateTargetScreenPtWhenMapPaddingChanged;

  /// 设定双指手势操作时，BMKMapView的旋转和缩放效果的中心点。
  ///
  /// 设置为true时，以手势的中心点（二个指头的中心点）为中心进行旋转和缩放，地图中心点会改变；
  ///
  /// 设置为false时，以当前地图的中心点为中心进行旋转和缩放，地图中心点不变；
  ///
  /// 默认值为false。
  ///
  /// (iOS独有)
  bool? changeWithTouchPointCenterEnabled;

  /// 设定双击手势放大地图时，BMKMapView的放大效果的中心点。
  ///
  /// 设置为true时，以双击的位置为中心点进行放大，地图中心点会改变；
  ///
  /// 设置为false时，以当前地图的中心点为中心进行放大，地图中心点不变；
  ///
  /// 默认值为true。
  bool? changeCenterWithDoubleTouchPointEnabled;

  /// 设定地图是否显示室内图（包含室内图标注），默认不显示
  bool? baseIndoorMapEnabled;

  /// 设定室内图标注是否显示，默认true，仅当显示室内图（baseIndoorMapEnabled为true）时生效
  bool? showIndoorMapPoi;

  /// BMFMapOptions构造方法
  BMFMapOptions({
    this.mapType: BMFMapType.Standard,
    this.limitMapBounds,
    this.compassPosition,
    this.compassEnabled: false,
    this.center,
    this.zoomLevel,
    this.minZoomLevel,
    this.maxZoomLevel,
    this.showZoomControl: true,
    this.rotation,
    this.overlooking,
    this.minOverlooking,
    this.buildingsEnabled,
    this.showMapPoi,
    this.trafficEnabled,
    this.baiduHeatMapEnabled: false,
    this.gesturesEnabled: true,
    this.zoomEnabled: true,
    this.zoomEnabledWithTap: true,
    this.zoomEnabledWithDoubleClick: true,
    this.scrollEnabled: true,
    this.overlookEnabled: true,
    this.rotateEnabled: true,
    this.forceTouchEnabled: false,
    this.showMapScaleBar: true,
    this.mapScaleBarPosition,
    this.mapZoomControlPosition,
    this.logoPosition: BMFLogoPosition.LeftBottom,
    this.visibleMapBounds,
    this.mapPadding,
    this.updateTargetScreenPtWhenMapPaddingChanged: true,
    this.changeWithTouchPointCenterEnabled: false,
    this.changeCenterWithDoubleTouchPointEnabled: true,
    this.baseIndoorMapEnabled: false,
    this.showIndoorMapPoi: true,
  });

  /// BMFMapOptions -> map
  Map<String, Object?> toMap() {
    return {
      'mapType': this.mapType?.index,
      'limitMapBounds': this.limitMapBounds?.toMap(),
      'compassPosition': this.compassPosition?.toMap(),
      'compassEnabled': this.compassEnabled,
      'center': this.center?.toMap(),
      'zoomLevel': this.zoomLevel,
      'minZoomLevel': this.minZoomLevel,
      'maxZoomLevel': this.maxZoomLevel,
      'showZoomControl': this.showZoomControl,
      'rotation': this.rotation,
      'overlooking': this.overlooking,
      'minOverlooking': this.minOverlooking,
      'buildingsEnabled': this.buildingsEnabled,
      'showMapPoi': this.showMapPoi,
      'trafficEnabled': this.trafficEnabled,
      'baiduHeatMapEnabled': this.baiduHeatMapEnabled,
      'gesturesEnabled': this.gesturesEnabled,
      'zoomEnabled': this.zoomEnabled,
      'zoomEnabledWithTap': this.zoomEnabledWithTap,
      'zoomEnabledWithDoubleClick': this.zoomEnabledWithDoubleClick,
      'scrollEnabled': this.scrollEnabled,
      'overlookEnabled': this.overlookEnabled,
      'rotateEnabled': this.rotateEnabled,
      'forceTouchEnabled': this.forceTouchEnabled,
      'showMapScaleBar': this.showMapScaleBar,
      'mapScaleBarPosition': this.mapScaleBarPosition?.toMap(),
      'mapZoomControlPosition': this.mapZoomControlPosition?.toMap(),
      'logoPosition': this.logoPosition?.index,
      'visibleMapBounds': this.visibleMapBounds?.toMap(),
      'mapPadding': this.mapPadding?.toMap(),
      'updateTargetScreenPtWhenMapPaddingChanged':
          this.updateTargetScreenPtWhenMapPaddingChanged,
      'changeWithTouchPointCenterEnabled':
          this.changeWithTouchPointCenterEnabled,
      'changeCenterWithDoubleTouchPointEnabled':
          this.changeCenterWithDoubleTouchPointEnabled,
      'baseIndoorMapEnabled': this.baseIndoorMapEnabled,
      'showIndoorMapPoi': this.showIndoorMapPoi
    };
  }
}
