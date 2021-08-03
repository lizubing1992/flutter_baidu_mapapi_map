import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_baseindoormap_info.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_mappoi.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_mapstatus.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_marker.dart';
import 'package:flutter_baidu_mapapi_map/src/models/overlays/bmf_polyline.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_method_id.dart';

/// 地图无参数回调
typedef BMFMapCallback = void Function();

/// 地图成功回调
typedef BMFMapSuccessCallback = void Function(bool success);

/// 地图区域改变回调
typedef BMFMapRegionChangeCallback = void Function(BMFMapStatus mapStatus);

/// 地图区域改变原因回调
typedef BMFMapRegionChangeReasonCallback = void Function(
    BMFMapStatus mapStatus, BMFRegionChangeReason regionChangeReason);

/// 点中底图标注后会回调此接口
typedef BMFMapOnClickedMapPoiCallback = void Function(BMFMapPoi mapPoi);

/// 地图marker事件回调
typedef BMFMapMarkerCallback = void Function(BMFMarker marker);

/// 地图拖拽marker回调
typedef BMFMapDragMarkerCallback = void Function(
    BMFMarker marker, BMFMarkerDragState newState, BMFMarkerDragState oldState);

/// 地图点击覆盖物回调，目前只支持polyline
typedef BMFMapOnClickedOverlayCallback = void Function(BMFPolyline polyline);

/// 地图经纬度回调
typedef BMFMapCoordinateCallback = void Function(BMFCoordinate coordinate);

/// 地图3DTouch回调
///
/// coordinate 触摸点的经纬度
///
/// force 触摸该点的力度(参考UITouch的force属性)
///
/// maximumPossibleForce 当前输入机制下的最大可能力度(参考UITouch的maximumPossibleForce属性)
typedef BMFMapOnForceTouchCallback = void Function(
    BMFCoordinate coordinate, double force, double maximumPossibleForce);

/// 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
typedef BMFMapOnDrawMapFrameCallback = void Function(BMFMapStatus mapStatus);

/// 地图View进入/移出室内图会调用此方法
///
/// flag true:进入室内图，false：移出室内图
///
/// baseIndoorMapInfo 室内图信息
typedef BMFMapInOrOutBaseIndoorMapCallback = void Function(
    bool flag, BMFBaseIndoorMapInfo baseIndoorMapInfo);

/// 地图绘制出有效数据的监听
typedef BMFMapRenderValidDataCallback = void Function(
    bool isValid, int errorCode, String errorMessage);

///处理native发送过来的消息
class BMFMethodChannelHandler {
  static const sTag = 'BMFMethodChannelHandler';

  /// 加载完成回调
  BMFMapCallback? _mapDidLoadCallback;

  /// 渲染完成回调
  BMFMapSuccessCallback? _mapDidFinishRenderCallback;

  /// 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
  BMFMapOnDrawMapFrameCallback? _mapOnDrawMapFrameCallback;

  /// 两端类型不一致，Android返回的是MapStatus状态，ios没有返回参数
  ///
  /// 地图区域即将改变时会调用此接口
  BMFMapRegionChangeCallback? _mapRegionWillChangeCallback;

  /// 两端类型不一致，Android返回的是MapStatus状态，ios没有返回参数
  ///
  /// 地图区域改变完成后会调用此接口
  BMFMapRegionChangeCallback? _mapRegionDidChangeCallback;

  /// 两端类型不一致，Android返回的是MapStatus状态，ios没有返回参数
  ///
  /// 地图区域即将改变时会调用此接口reason
  BMFMapRegionChangeReasonCallback? _mapRegionWillChangeWithReasonCallback;

  /// 两端类型不一致，Android返回的是MapStatus状态，ios没有返回参数
  ///
  /// 地图区域改变完成后会调用此接口reason
  BMFMapRegionChangeReasonCallback? _mapRegionDidChangeWithReasonCallback;

  /// 点中覆盖物后会回调此接口，目前只支持点中Polyline时回调
  BMFMapOnClickedOverlayCallback? _mapOnClickedOverlayCallback;

  /// 点中底图标注后会回调此接口
  BMFMapOnClickedMapPoiCallback? _mapOnClickedMapPoiCallback;

  /// 点中底图空白处会回调此接口
  BMFMapCoordinateCallback? _mapOnClickedMapBlankCallback;

  /// 双击地图时会回调此接口
  BMFMapCoordinateCallback? _mapOnDoubleClickCallback;

  /// 长按地图时会回调此接口
  BMFMapCoordinateCallback? _mapOnLongClickCallback;

  /// (ios) 独有
  ///
  /// 3DTouch 按地图时会回调此接口
  ///
  ///（仅在支持3D Touch，且fouchTouchEnabled属性为true时，会回调此接口）
  BMFMapOnForceTouchCallback? _mapOnForceTouchCallback;

  /// 地图状态改变完成后会调用此接口
  BMFMapCallback? _mapStatusDidChangedCallback;

  /// 地图View进入/移出室内图会调用此方法
  BMFMapInOrOutBaseIndoorMapCallback? _mapInOrOutBaseIndoorMapCallback;

  //marker
  /// marker点击回调
  BMFMapMarkerCallback? _mapClickedMarkerCallback;

  /// marker选中回调
  BMFMapMarkerCallback? _mapDidSelectMarkerCallback;

  /// marker取消选中回调
  BMFMapMarkerCallback? _mapDidDeselectMarkerCallback;

  /// marker拖拽回调
  BMFMapDragMarkerCallback? _mapDragMarkerCallback;

  /// marker的infoWindow（ios paopaoView）点击回调
  BMFMapMarkerCallback? _mapDidClickedInfoWindowCallback;

  /// 地图绘制出有效数据的监听
  BMFMapRenderValidDataCallback? _mapRenderValidDataCallback;

  /// native -> flutter
  dynamic handlerMethod(MethodCall call) async {
//     BMFLog.d('_handlerMethod--\n method = ${call.method}');
//     BMFLog.d('_handlerMethod--\n arguments = ${call.arguments}');
    switch (call.method) {
      case BMFMapCallbackMethodId.kMapDidLoadCallback:
        {
          if (this._mapDidLoadCallback != null) {
            this._mapDidLoadCallback!();
          }
          break;
        }

      case BMFMapCallbackMethodId.kMapDidFinishRenderCallback:
        {
          // BMFLog.d("kMapDidFinishRenderCallback");
          if (this._mapDidFinishRenderCallback != null) {
            this._mapDidFinishRenderCallback!(call.arguments['success'] as bool);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapOnDrawMapFrameCallback:
        {
          if (this._mapOnDrawMapFrameCallback != null) {
            BMFMapStatus mapStatus =
                BMFMapStatus.fromMap(call.arguments['mapStatus']);
            this._mapOnDrawMapFrameCallback!(mapStatus);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapRegionWillChangeCallback:
        {
          if (this._mapRegionWillChangeCallback != null) {
            BMFMapStatus mapStatus =
                BMFMapStatus.fromMap(call.arguments['mapStatus']);
            this._mapRegionWillChangeCallback!(mapStatus);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapRegionDidChangeCallback:
        {
          if (this._mapRegionDidChangeCallback != null) {
            BMFMapStatus mapStatus =
                BMFMapStatus.fromMap(call.arguments['mapStatus']);
            this._mapRegionDidChangeCallback!(mapStatus);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapRegionWillChangeWithReasonCallback:
        {
          if (this._mapRegionWillChangeWithReasonCallback != null) {
            BMFMapStatus mapStatus =
                BMFMapStatus.fromMap(call.arguments['mapStatus']);
            BMFRegionChangeReason reason =
                BMFRegionChangeReason.values[call.arguments['reason'] as int];
            this._mapRegionWillChangeWithReasonCallback!(mapStatus, reason);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapRegionDidChangeWithReasonCallback:
        {
          if (this._mapRegionDidChangeWithReasonCallback != null) {
            BMFMapStatus mapStatus =
                BMFMapStatus.fromMap(call.arguments['mapStatus']);
            BMFRegionChangeReason reason =
                BMFRegionChangeReason.values[call.arguments['reason'] as int];
            this._mapRegionDidChangeWithReasonCallback!(mapStatus, reason);
          }
          break;
        }
      case BMFOverlayCallbackMethodId.kMapOnClickedOverlayCallback:
        {
          if (this._mapOnClickedOverlayCallback != null) {
            BMFPolyline polyline =
                BMFPolyline.fromMap(call.arguments['polyline']);
            this._mapOnClickedOverlayCallback!(polyline);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapOnClickedMapPoiCallback:
        {
          if (this._mapOnClickedMapPoiCallback != null) {
            BMFMapPoi poi = BMFMapPoi.fromMap(call.arguments['poi']);
            this._mapOnClickedMapPoiCallback!(poi);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapOnClickedMapBlankCallback:
        {
          if (this._mapOnClickedMapBlankCallback != null) {
            BMFCoordinate coordinate =
                BMFCoordinate.fromMap(call.arguments['coord']);
            this._mapOnClickedMapBlankCallback!(coordinate);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapOnDoubleClickCallback:
        {
          if (this._mapOnDoubleClickCallback != null) {
            BMFCoordinate coordinate =
                BMFCoordinate.fromMap(call.arguments['coord']);
            this._mapOnDoubleClickCallback!(coordinate);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapOnLongClickCallback:
        {
          if (this._mapOnLongClickCallback != null) {
            BMFCoordinate coordinate =
                BMFCoordinate.fromMap(call.arguments['coord']);
            this._mapOnLongClickCallback!(coordinate);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapOnForceTouchCallback:
        {
          if (this._mapOnForceTouchCallback != null) {
            BMFCoordinate coordinate =
                BMFCoordinate.fromMap(call.arguments['coord']);
            double force = call.arguments['force'] as double;
            double maximumPossibleForce =
                call.arguments['maximumPossibleForce'] as double;
            this._mapOnForceTouchCallback!(
                coordinate, force, maximumPossibleForce);
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapStatusDidChangedCallback:
        {
          if (this._mapStatusDidChangedCallback != null) {
            this._mapStatusDidChangedCallback!();
          }
          break;
        }
      case BMFMapCallbackMethodId.kMapInOrOutBaseIndoorMapCallback:
        {
          if (this._mapInOrOutBaseIndoorMapCallback != null) {
            bool flag = call.arguments['flag'];
            BMFBaseIndoorMapInfo info =
                BMFBaseIndoorMapInfo.fromMap(call.arguments['info']);
            this._mapInOrOutBaseIndoorMapCallback!(flag, info);
          }
          break;
        }
      case BMFMarkerCallbackMethodId.kMapClickedMarkerCallback:
        {
          if (this._mapClickedMarkerCallback != null) {
            BMFLog.d(BMFMarkerCallbackMethodId.kMapClickedMarkerCallback);
            // String id = call.arguments['id'];
            // Map<String, dynamic> extra = call.arguments['extra'];
            BMFMarker marker = BMFMarker.fromMap(call.arguments['marker']);
            this._mapClickedMarkerCallback!(marker);
          }
          break;
        }
      case BMFMarkerCallbackMethodId.kMapDidSelectMarkerCallback:
        {
          if (this._mapDidSelectMarkerCallback != null) {
            // String id = call.arguments['id'];
            // Map<String, dynamic> extra = call.arguments['extra'];
            BMFMarker marker = BMFMarker.fromMap(call.arguments['marker']);

            this._mapDidSelectMarkerCallback!(marker);
          }
          break;
        }
      case BMFMarkerCallbackMethodId.kMapDidDeselectMarkerCallback:
        {
          if (this._mapDidDeselectMarkerCallback != null) {
            // String id = call.arguments['id'];
            // Map<String, dynamic> extra = call.arguments['extra'];
            BMFMarker marker = BMFMarker.fromMap(call.arguments['marker']);

            this._mapDidDeselectMarkerCallback!(marker);
          }
          break;
        }
      case BMFMarkerCallbackMethodId.kMapDragMarkerCallback:
        {
          if (this._mapDragMarkerCallback != null) {
            BMFLog.d("drag marker", tag: sTag);
            // String id = call.arguments['id'];
            BMFMarker marker = BMFMarker.fromMap(call.arguments['marker']);
            BMFMarkerDragState newState =
                BMFMarkerDragState.values[call.arguments['newState'] as int];
            BMFMarkerDragState oldState =
                BMFMarkerDragState.values[call.arguments['oldState'] as int];
            this._mapDragMarkerCallback!(marker, newState, oldState);
          }
          break;
        }
      case BMFInfoWindowMethodId.kMapDidClickedInfoWindowMethod:
        {
          if (this._mapDidClickedInfoWindowCallback != null) {
            BMFLog.d("infoWindow click", tag: 'BMFMethodChannelHandler');
            // String id = call.arguments['id'];
            // BMFLog.d(id, tag: 'BMFMethodChannelHandler');
            BMFMarker marker = BMFMarker.fromMap(call.arguments['marker']);

            this._mapDidClickedInfoWindowCallback!(marker);
          }
          break;
        }

      case BMFMapCallbackMethodId.kMapRenderValidDataCallback:
        {
          if (this._mapRenderValidDataCallback != null) {
            bool isValid = call.arguments['isValid'] as bool;
            int errorCode = call.arguments['errorCode'] as int;
            String errorMessage = call.arguments['errorMessage'] as String;
            this._mapRenderValidDataCallback!(isValid, errorCode, errorMessage);
          }
          break;
        }
      default:
        break;
    }
  }

  /// 地图加载完成回调
  void setMapDidLoadCallback(BMFMapCallback block) {
    if (block == null) {
      return;
    }
    this._mapDidLoadCallback = block;
  }

  /// 地图渲染回调
  void setMapDidFinishedRenderCallback(BMFMapSuccessCallback block) {
    if (block == null) {
      return;
    }
    this._mapDidFinishRenderCallback = block;
  }

  /// 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
  void setMapOnDrawMapFrameCallback(BMFMapOnDrawMapFrameCallback block) {
    if (block == null) {
      return;
    }
    this._mapOnDrawMapFrameCallback = block;
  }

  /// 地图区域即将改变时会调用此接口
  void setMapRegionWillChangeCallback(BMFMapRegionChangeCallback block) {
    if (block == null) {
      return;
    }
    this._mapRegionWillChangeCallback = block;
  }

  /// 地图区域改变完成后会调用此接口
  void setMapRegionDidChangeCallback(BMFMapRegionChangeCallback block) {
    if (block == null) {
      return;
    }
    this._mapRegionDidChangeCallback = block;
  }

  /// 地图区域即将改变时会调用此接口reason
  void setMapRegionWillChangeWithReasonCallback(
      BMFMapRegionChangeReasonCallback block) {
    if (block == null) {
      return;
    }
    this._mapRegionWillChangeWithReasonCallback = block;
  }

  /// 地图区域改变完成后会调用此接口reason
  void setMapRegionDidChangeWithReasonCallback(
      BMFMapRegionChangeReasonCallback block) {
    if (block == null) {
      return;
    }
    this._mapRegionDidChangeWithReasonCallback = block;
  }

  /// 地图点击覆盖物回调，目前只支持polyline
  void setMapOnClickedOverlayCallback(BMFMapOnClickedOverlayCallback block) {
    if (block == null) {
      return;
    }
    this._mapOnClickedOverlayCallback = block;
  }

  /// 点中底图标注后会回调此接口
  void setMapOnClickedMapPoiCallback(BMFMapOnClickedMapPoiCallback block) {
    if (block == null) {
      return;
    }
    this._mapOnClickedMapPoiCallback = block;
  }

  /// 点中底图空白处会回调此接口
  void setMapOnClickedMapBlankCallback(BMFMapCoordinateCallback block) {
    if (block == null) {
      return;
    }
    this._mapOnClickedMapBlankCallback = block;
  }

  /// 双击地图时会回调此接口
  void setMapOnDoubleClickCallback(BMFMapCoordinateCallback block) {
    if (block == null) {
      return;
    }
    this._mapOnDoubleClickCallback = block;
  }

  /// 长按地图时会回调此接口
  void setMapOnLongClickCallback(BMFMapCoordinateCallback block) {
    if (block == null) {
      return;
    }
    this._mapOnLongClickCallback = block;
  }

  /// 3DTouch 按地图时会回调此接口
  ///
  ///（仅在支持3D Touch，且fouchTouchEnabled属性为true时，会回调此接口）
  void setMapOnForceTouchCallback(BMFMapOnForceTouchCallback block) {
    if (block == null) {
      return;
    }
    this._mapOnForceTouchCallback = block;
  }

  /// 地图状态改变完成后会调用此接口
  void setMapStatusDidChangedCallback(BMFMapCallback block) {
    if (block == null) {
      return;
    }
    this._mapStatusDidChangedCallback = block;
  }

  /// 设置地图View进入/移出室内图回调
  void setMapInOrOutBaseIndoorMapCallback(
      BMFMapInOrOutBaseIndoorMapCallback block) {
    if (block == null) {
      return;
    }
    this._mapInOrOutBaseIndoorMapCallback = block;
  }

  /// 设置marker点击回调
  void setMapClickedMarkerCallback(BMFMapMarkerCallback block) {
    if (block == null) {
      return;
    }
    this._mapClickedMarkerCallback = block;
  }

  /// 设置marker选中回调
  void setMaptDidSelectMarkerCallback(BMFMapMarkerCallback block) {
    if (block == null) {
      return;
    }
    this._mapDidSelectMarkerCallback = block;
  }

  /// 设置marker取消回调
  void setMapDidDeselectMarkerCallback(BMFMapMarkerCallback block) {
    if (block == null) {
      return;
    }
    this._mapDidDeselectMarkerCallback = block;
  }

  /// 设置marker拖拽回调
  void setMapDragMarkerCallback(BMFMapDragMarkerCallback block) {
    if (block == null) {
      return;
    }
    this._mapDragMarkerCallback = block;
  }

  /// 设置marker的infoWindow（iOS paopaoView）点击回调
  void setMapDidClickedInfoWindowCallback(BMFMapMarkerCallback block) {
    if (block == null) {
      return;
    }
    this._mapDidClickedInfoWindowCallback = block;
  }

  /// 设置地图绘制出有效数据的监听
  void setMapRenderValidDataCallback(BMFMapRenderValidDataCallback block) {
    if (block == null) {
      return;
    }
    this._mapRenderValidDataCallback = block;
  }
}
