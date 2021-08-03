import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_get_state_dispacther.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_status_dispacther.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_marker_dispatcher.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_offline_map_dispatcher.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_overlay_dispatcher.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_userlocation_dispatcher.dart';

class BMFMapDispatcherFactory {
  // 工厂模式
  factory BMFMapDispatcherFactory() => _getInstance();
  static BMFMapDispatcherFactory get instance => _getInstance();
  static BMFMapDispatcherFactory? _instance;

  BMFMapStatusDispatcher? _mapStatusDispatcher;
  BMFMapGetStateDispatcher? _mapGetStateDispatcher;
  BMFMapUserLocationDispatcher? _mapUserLocationDispatcher;
  BMFMarkerDispatcher? _markerDispatcher;
  BMFOverlayDispatcher? _overlayDispatcher;
  BMFOfflineMapDispatcher? _offlineMapDispatcher;

  BMFMapDispatcherFactory._internal() {
    _mapStatusDispatcher = new BMFMapStatusDispatcher();
    _mapGetStateDispatcher = new BMFMapGetStateDispatcher();
    _mapUserLocationDispatcher = new BMFMapUserLocationDispatcher();
    _markerDispatcher = new BMFMarkerDispatcher();
    _overlayDispatcher = new BMFOverlayDispatcher();
    _offlineMapDispatcher = new BMFOfflineMapDispatcher();
  }
  static BMFMapDispatcherFactory _getInstance() {
    if (_instance == null) {
      _instance = new BMFMapDispatcherFactory._internal();
    }
    return _instance!;
  }

  /// mapStateDispatcher
  BMFMapStatusDispatcher get mapStatusDispatcher => _mapStatusDispatcher!;

  /// mapGetStateDispatcher
  BMFMapGetStateDispatcher get mapGetStateDispatcher => _mapGetStateDispatcher!;

  /// mapUserLocationDispatcher
  BMFMapUserLocationDispatcher get mapUserLocationDispatcher =>
      _mapUserLocationDispatcher!;

  /// markerDispatcher
  BMFMarkerDispatcher get markerDispatcher => _markerDispatcher!;

  /// overlayDispatcher
  BMFOverlayDispatcher get overlayDispatcher => _overlayDispatcher!;

  /// offlineMapDispatcher
  BMFOfflineMapDispatcher get OfflineMapDispatcher => _offlineMapDispatcher!;
}
