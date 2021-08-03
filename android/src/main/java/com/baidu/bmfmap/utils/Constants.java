package com.baidu.bmfmap.utils;

public class Constants {
    public static final String VIEW_METHOD_CHANNEL_PREFIX = "flutter_bmfmap/map_";

    public static final String sConfigChangedAction = "com.baidu.flutter_bmfmap.configChanged";

    public static final String NATIVE_SDK_VERSION_CHANNEL = "flutter_bmfmap";
    public static final String NATIVE_SDK_VERSION = "flutter_bmfmap/map/getNativeMapVersion";

    /**
     * view类型
     */
    public static class ViewType {
        public static final String sMapView = "flutter_bmfmap/map/BMKMapView";
        public static final String sTextureMapView = "flutter_bmfmap/map/BMKTextureMapView";
    }

    /**
     * overlayHandler类型
     */
    public static class OverlayHandlerType {
        public static final int OVERLAY_COMMON_HANDLER = 0;
        public static final int CIRCLE_HANDLER = 1;
        public static final int DOT_HANDLER = 2;
        public static final int POLYGON_HANDLER = 3;
        public static final int POLYLINE_HANDLER = 4;
        public static final int TEXT_HANDLER = 5;
        public static final int ARCLINE_HANDLER = 6;
        public static final int GROUND_HANDLER = 7;
        public static final int MARKER_HANDLER = 8;
        public static final int INFOWINDOW_HANDLER = 9;
    }

    /**
     * MapHandler类型
     */
    public static class BMapHandlerType {
        public static final int CUSTOM_MAP = 0;
        public static final int MAP_STATE = 1;
        public static final int INDOOR_MAP = 2;
        public static final int MAP_SNAPSHOT = 3;
        public static final int CUSTOM_COMPASS = 4;
        public static final int CUSTOM_TRAFFIC_COLOR = 5;
        public static final int MAP_UPDATE = 6;
        public static final int HEAT_MAP = 7;
        public static final int TILE_MAP = 8;
        public static final int LOCATION_LAYER = 9;
        public static final int PROJECTION = 10;
    }

    /**
     * 与flutter method协议约定
     */
    public static class MethodProtocol {
        /**
         * 室内图状态协议
         */
        public static class IndoorMapProtocol {
            /**
             * map展示室内地图
             */
            public static final String sShowBaseIndoorMapMethod =
                    "flutter_bmfmap/map/showBaseIndoorMap";

            /**
             * map室内图标注是否显示
             */
            public static final String sShowBaseIndoorMapPoiMethod =
                    "flutter_bmfmap/map/showBaseIndoorMapPoi";

            /**
             * map设置室内图楼层
             */
            public static final String sSwitchBaseIndoorMapFloorMethod =
                    "flutter_bmfmap/map/switchBaseIndoorMapFloor";

            /**
             * map获取当前聚焦的室内图信息
             */
            public static final String sGetFocusedBaseIndoorMapInfoMethod =
                    "flutter_bmfmap/map/getFocusedBaseIndoorMapInfo";
        }

        /**
         * 个性化地图
         */
        public static class CustomMapProtocol {
            /**
             * 开启个性化地图
             */
            public static final String sMapSetCustomMapStyleEnableMethod =
                    "flutter_bmfmap/map/setCustomMapStyleEnable";

            /**
             * 设置个性化地图样式路径
             */
            public static final String sMapSetCustomMapStylePathMethod =
                    "flutter_bmfmap/map/setCustomMapStylePath";

            /**
             * 在线个性化样式加载状态回调接口
             */
            public static final String sMapSetCustomMapStyleWithOptionMethod =
                    "flutter_bmfmap/map/setCustomMapStyleWithOption";
        }

        /**
         * overlay协议
         */
        public static class OverlayProtocol {
            /**
             * 删除overlay
             */
            public static final String sMapRemoveOverlayMethod =
                    "flutter_bmfmap/overlay/removeOverlay";
        }

        /**
         * marker协议
         */
        public static class MarkerProtocol {
            /**
             * 添加marker
             */
            public static final String sMapAddMarkerMethod = "flutter_bmfmap/marker/addMarker";

            /**
             * 添加markers
             */
            public static final String sMapAddMarkersMethod = "flutter_bmfmap/marker/addMarkers";

            /**
             * 删除marker
             */
            public static final String sMapRemoveMarkerMethod =
                    "flutter_bmfmap/marker/removeMarker";

            /**
             * 删除markers
             */
            public static final String sMapRemoveMarkersMethod =
                    "flutter_bmfmap/marker/removeMarkers";

            /**
             * 清除所有的markers
             */
            public static final String sMapCleanAllMarkersMethod =
                    "flutter_bmfmap/marker/cleanAllMarkers";

            /**
             * marker点击回调
             */
            public static final String sMapClickedmarkedMethod =
                    "flutter_bmfmap/marker/clickedMarker";

            /**
             * marker 选中回调
             */
            public static final String sMapDidSelectMarkerMethod =
                    "flutter_bmfmap/marker/didSelectedMarker";

            /**
             * marker取消选中回调
             */
            public static final String sMapDidDeselectMarkerMethod =
                    "flutter_bmfmap/marker/didDeselectMarker";

            /**
             * marker拖拽
             */
            public static final String sMapDragMarkerMethod = "flutter_bmfmap/marker/dragMarker";

            /**
             * marker更新
             */
            public static final String sMapUpdateMarkerMemberMethod =
                    "flutter_bmfmap/marker/updateMarkerMember";

            /**
             * marker拖拽状态枚举
             */
            public static enum MarkerDragState {
                // 静止状态
                None,

                // 开始拖动
                Starting,

                // 拖动中
                Dragging,

                // 取消拖动
                Canceling,

                // 拖动结束
                Ending
            }
        }

        /**
         * infowindow协议
         */
        public static class InfoWindowProtocol {
            /**
             * marker的infoWindow（iOS paopaoView）点击回调
             */
            public static final String sMapDidClickedInfoWindowMethod =
                    "flutter_bmfmap/map/didClickedInfoWindow";

            // 添加infoWindow
            public static final String sAddInfoWindowMapMethod = "flutter_bmfmap/map/addInfoWindow";

            // 添加infoWindow
            public static final String sAddInfoWindowsMapMethod =
                    "flutter_bmfmap/map/addInfoWindows";

            // 移除infoWindow
            public static final String sRemoveInfoWindowMapMethod =
                    "flutter_bmfmap/map/removeInfoWindow";
        }

        /**
         * polyline协议
         */
        public static class PolylineProtocol {
            /**
             * 添加polyline
             */
            public static final String sMapAddPolylineMethod = "flutter_bmfmap/overlay/addPolyline";
            /**
             * polyline点击事件
             */
            public static final String sMapOnClickedOverlayCallback =
                    "flutter_bmfmap/overlay/onClickedOverlay";

            /**
             * 更新polyline属
             */
            public static final String sMapUpdatePolylineMemberMethod =
                    "flutter_bmfmap/overlay/updatePolylineMember";
        }

        /**
         * polygon协议
         */
        public static class PolygonProtocol {
            /**
             * 添加polyline
             */
            public static final String sMapAddPolygonMethod = "flutter_bmfmap/overlay/addPolygon";

            /**
             * 更新polygon属性
             */
            public static final String sMapUpdatePolygonMemberMethod =
                    "flutter_bmfmap/overlay/updatePolygonMember";
        }

        /**
         * arline协议
         */
        public static class ArclineProtocol {
            /**
             * 添加arcline
             */
            public static final String sMapAddArclinelineMethod =
                    "flutter_bmfmap/overlay/addArcline";

            /**
             * 更新arcline属性
             */
            public static final String sMapUpdateArclineMemberMethod =
                    "flutter_bmfmap/overlay/updateArclineMember";
        }

        /**
         * circleline协议
         */
        public static class CirclelineProtocol {
            /**
             * 添加circlr
             */
            public static final String sMapAddCirclelineMethod = "flutter_bmfmap/overlay/addCircle";

            /**
             * 更新circle属性
             */
            public static final String sMapUpdateCircleMemberMethod =
                    "flutter_bmfmap/overlay/updateCircleMember";
        }

        /**
         * dot协议
         */
        public static class DotProtocol {
            /**
             * 添加Dot
             */
            public static final String sMapAddDotMethod = "flutter_bmfmap/overlay/addDot";

            /**
             * 更新Dot属性
             */
            public static final String sMapUpdateDotMemberMethod = "flutter_bmfmap/overlay"
                    + "/updateDotMember";
        }

        /**
         * Text协议
         */
        public static class TextProtocol {
            /**
             * 添加Text
             */
            public static final String sMapAddTextMethod = "flutter_bmfmap/overlay/addText";

            /**
             * 更新Text属性
             */
            public static final String sMapUpdateTextMemberMethod =
                    "flutter_bmfmap/overlay/updateTextMember";
        }

        /**
         * Ground协议
         */
        public static class GroundProtocol {
            /**
             * 添加Ground
             */
            public static final String sMapAddGroundMethod = "flutter_bmfmap/overlay/addGround";

            /**
             * 更新Ground属性
             */
            public static final String sMapUpdateGroundMemberMethod =
                    "flutter_bmfmap/overlay/updateGroundMember";
        }

        public static class HeatMapProtocol {
            /**
             * 添加HeapMap
             */
            public static final String sMapAddHeatMapMethod = "flutter_bmfmap/heatMap/addHeatMap";

            /**
             * 开关
             */
            public static final String sMapRemoveHeatMapMethod =
                    "flutter_bmfmap/heatMap/removeHeatMap";

            /**
             * 是否展示热力图
             */
            public static final String sShowHeatMapMethod = "flutter_bmfmap/heatMap/showHeatMap";
        }

        /**
         * mapState协议
         */
        public static class MapStateProtocol {
            // 更新地图参数
            public static final String sMapUpdateMethod = "flutter_bmfmap/map/updateMapOptions";

            // map放大一级比例尺
            public static final String sMapZoomInMethod = "flutter_bmfmap/map/zoomIn";

            // map缩小一级比例尺
            public static final String sMapZoomOutMethod = "flutter_bmfmap/map/zoomOut";

            // 设置路况颜色
            public static final String sMapSetCustomTrafficColorMethod =
                    "flutter_bmfmap/map/setCustomTrafficColor";

            // 更新地图状态
            public static final String sMapSetMapStatusMethod = "flutter_bmfmap/map/setMapStatus";

            // 获取地图状态
            public static final String sMapGetMapStatusMethod = "flutter_bmfmap/map/getMapStatus";

            // 按像素移动地图中心点
            public static final String sMapSetScrollByMethod = "flutter_bmfmap/map/setScrollBy";

            // 根据给定增量缩放地图级别
            public static final String sMapSetZoomByMethod = "flutter_bmfmap/map/setZoomBy";

            // 根据给定增量以及给定的屏幕坐标缩放地图级别
            public static final String sMapSetZoomPointByMethod =
                    "flutter_bmfmap/map/setZoomPointBy";

            // 设置地图缩放级别
            public static final String sMapSetZoomToMethod = "flutter_bmfmap/map/setZoomTo";

            // 设定地图中心点坐标
            public static final String sMapSetCenterCoordinateMethod =
                    "flutter_bmfmap/map/setCenterCoordinate";

            // 设置地图中心点以及缩放级别
            public static final String sMapSetCenterZoomMethod =
                    "flutter_bmfmap/map/setMapCenterZoom";

            // 获得地图当前可视区域截图
            public static final String sMapTakeSnapshotMethod = "flutter_bmfmap/map/takeSnapshot";

            // 获得地图指定区域截图
            public static final String sMapTakeSnapshotWithRectMethod =
                    "flutter_bmfmap/map/takeSnapshotWithRect";

            // 设置罗盘的图片
            public static final String sMapSetCompassImageMethod =
                    "flutter_bmfmap/map/setCompassImage";

            // 设置显示在屏幕中的地图地理范围
            public static final String sMapSetVisibleMapBoundsMethod =
                    "flutter_bmfmap/map/setVisibleMapBounds";

            // 设定地图的显示范围,并使mapRect四周保留insets指定的边界区域
            public static final String sMapSetVisibleMapBoundsWithPaddingMethod =
                    "flutter_bmfmap/map/setVisibleMapBoundsWithPadding";

            // map加载完成
            public static final String sMapDidLoadCallback =
                    "flutter_bmfmap/map/mapViewDidFinishLoad";

            // map渲染完成
            public static final String sMapDidFinishRenderCallback =
                    "flutter_bmfmap/map/mapViewDidFinishRender";

            // 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
            public static final String sMapOnDrawMapFrameCallback =
                    "flutter_bmfmap/map/mapViewOnDrawMapFrame";

            // 地图绘制出有效数据的监听
            public static final String sMapRenderValidDataCallback =
                    "flutter_bmfmap/map/mapRenderValidDataCallback";

            // 地图View进入/移出室内图
            public static final String sMapInOrOutBaseIndoorMapCallback =
                    "flutter_bmfmap/map/mapViewInOrOutBaseIndoorMap";

            // 地图区域即将改变时会调用此接口
            public static final String sMapRegionWillChangeCallback =
                    "flutter_bmfmap/map/mapViewRegionWillChange";

            // 地图区域即将改变时会调用此接口reason
            public static final String sMapRegionWillChangeWithReasonCallback =
                    "flutter_bmfmap/map/mapViewRegionWillChangeWithReason";

            // 地图区域改变完成后会调用此接口
            public static final String sMapRegionDidChangeCallback =
                    "flutter_bmfmap/map/mapViewRegionDidChange";

            // 地图区域改变完成后会调用此接口reason
            public static final String sMapRegionDidChangeWithReasonCallback =
                    "flutter_bmfmap/map/mapViewRegionDidChangeWithReason";

            // 点中底图空白处会回调此接口
            public static final String sMapOnClickedMapBlankCallback =
                    "flutter_bmfmap/map/mapViewOnClickedMapBlank";

            // 点中底图标注后会回调此接口
            public static final String sMapOnClickedMapPoiCallback =
                    "flutter_bmfmap/map/mapViewonClickedMapPoi";

            // 双击地图时会回调此接口
            public static final String sMapOnDoubleClickCallback =
                    "flutter_bmfmap/map/mapViewOnDoubleClick";

            // 长按地图时会回调此接口
            public static final String sMapOnLongClickCallback =
                    "flutter_bmfmap/map/mapViewOnLongClick";

            // 地图状态改变完成后会调用此接口
            public static final String sMapStatusDidChangedCallback =
                    "flutter_bmfmap/map/mapViewStatusDidChanged";

            // widget 状态更新
            public static final String sMapDidUpdateWidget = "flutter_bmfmap/map/didUpdateWidget";

            // widget 热重载
            public static final String sMapReassemble = "flutter_bmfmap/map/reassemble";

        }

        /**
         * 地图获取属性方法id集合
         */
        public static class BMFMapGetPropertyMethodId {

            // 获取map的展示类型
            public static final String sMapGetMapTypeMethod = "flutter_bmfmap/map/getMapType";

            // 获取map的比例尺级别
            public static final String sMapGetZoomLevelMethod = "flutter_bmfmap/map/getZoomLevel";

            // 获取map的自定义最小比例尺级别
            public static final String sMapGetMinZoomLevelMethod =
                    "flutter_bmfmap/map/getMinZoomLevel";

            // 获取map的自定义最大比例尺级别
            public static final String sMapGetMaxZoomLevelMethod =
                    "flutter_bmfmap/map/getMaxZoomLevel";

            // 获取map的旋转角度
            public static final String sMapGetRotationMethod = "flutter_bmfmap/map/getRotation";

            // 获取map的地图俯视角度
            public static final String sMapGetOverlookingMethod =
                    "flutter_bmfmap/map/getOverlooking";

            // 获取map的是否现显示3D楼块效果
            public static final String sMapGetBuildingsEnabledMethod =
                    "flutter_bmfmap/map/getBuildingsEnabled";

            // 获取map的是否打开路况图层
            public static final String sMapGetTrafficEnabledMethod =
                    "flutter_bmfmap/map/getTrafficEnabled";

            // 获取map的是否打开百度城市热力图图层
            public static final String sMapGetBaiduHeatMapEnabledMethod =
                    "flutter_bmfmap/map/getBaiduHeatMapEnabled";

            // 获取map的是否支持所有手势操作
            public static final String sMapGetGesturesEnabledMethod =
                    "flutter_bmfmap/map/getGesturesEnabled";

            // 获取map是否支持缩放
            public static final String sMapGetZoomEnabledMethod =
                    "flutter_bmfmap/map/getZoomEnabled";

            // 获取map是否支持拖拽手势
            public static final String sMapGetScrollEnabledMethod =
                    "flutter_bmfmap/map/getScrollEnabled";

            // 获取map是否支持俯仰角
            public static final String sMapGetOverlookEnabledMethod =
                    "flutter_bmfmap/map/getOverlookEnabled";

            // 获取map是否支持旋转
            public static final String sMapGetRotateEnabledMethod =
                    "flutter_bmfmap/map/getRotateEnabled";

            // 获取map的比例尺的位置
            public static final String sMapGetMapScaleBarPositionMethod =
                    "flutter_bmfmap/map/getMapScaleBarPosition";

            // 获取map的logo位置
            public static final String sMapGetLogoPositionMethod =
                    "flutter_bmfmap/map/getLogoPosition";

            // 获取map的可视范围
            public static final String sMapGetVisibleMapBoundsMethod =
                    "flutter_bmfmap/map/getVisibleMapBounds";

            // 获取map的显示室内图
            public static final String sMapGetBaseIndoorMapEnabledMethod =
                    "flutter_bmfmap/map/getBaseIndoorMapEnabled";

            // 获取map的室内图标注是否显示
            public static final String sMapGetShowIndoorMapPoiMethod = "flutter_bmfmap/map"
                    + "/getShowIndoorMapPoi";
        }

        public static class BMFOfflineMethodId {
            // 初使化
            public static final String sMapInitOfflineMethod =
                    "flutter_bmfmap/offlineMap/initOfflineMap";

            // 状态回调
            public static final String sMapOfflineCallBackMethod =
                    "flutter_bmfmap/offlineMap/offlineCallBack";

            // 启动下载指定城市ID的离线地图，或在暂停更新某城市后继续更新下载某城市离线地图
            public static final String sMapStartOfflineMethod =
                    "flutter_bmfmap/offlineMap/startOfflineMap";

            // 启动更新指定城市ID的离线地图
            public static final String sMapUpdateOfflineMethod =
                    "flutter_bmfmap/offlineMap/updateOfflineMap";

            // 暂停下载或更新指定城市ID的离线地图
            public static final String sMapPauseOfflineMethod =
                    "flutter_bmfmap/offlineMap/pauseOfflineMap";

            // 删除指定城市ID的离线地图
            public static final String sMapRemoveOfflineMethod =
                    "flutter_bmfmap/offlineMap/removeOfflineMap";

            // 销毁离线地图管理模块，不用时调用
            public static final String sMapDestroyOfflineMethod =
                    "flutter_bmfmap/offlineMap/destroyOfflineMap";

            // 返回热门城市列表
            public static final String sMapGetHotCityListMethod =
                    "flutter_bmfmap/offlineMap/getHotCityList";

            // 返回支持离线地图城市列表
            public static final String sMapGetOfflineCityListMethod =
                    "flutter_bmfmap/offlineMap/getOfflineCityList";

            // 根据城市名搜索该城市离线地图记录
            public static final String sMapSearchCityMethod =
                    "flutter_bmfmap/offlineMap/searchCityList";

            // 返回各城市离线地图更新信息
            public static final String sMapGetAllUpdateInfoMethod =
                    "flutter_bmfmap/offlineMap/getAllUpdateInfo";

            // 返回指定城市ID离线地图更新信息
            public static final String sMapGetUpdateInfoMethod =
                    "flutter_bmfmap/offlineMap/getUpdateInfo";
        }

        public static class ProjectionMethodId {
            //屏幕坐标转地理坐标ID
            public static final String sFromScreenLocation =
                    "flutter_bmfmap/projection/screenPointfromCoordinate";

            //将地理坐标转换成屏幕坐标
            public static final String sToScreenLocation =
                    "flutter_bmfmap/projection/coordinateFromScreenPoint";

            //米为计量单位的距离（沿赤道）在当前缩放水平下转换到一个以像素（水平）为计量单位的距离
            public static final String sMetersToEquatorPixels =
                    "flutter_bmfmap/map/metersToEquatorPixels";
        }

        public static class TileMapProtocol {
            // 添加室内地图
            public static final String sAddTileMapMethod = "flutter_bmfmap/overlay/addTile";

            // 展示室内地图
            public static final String sRemoveTileMapMethod = "flutter_bmfmap/overlay/removeTile";
        }
    }

    public static class ErrorCode {

        /**
         * 没有错误
         */
        public static final int sErrorNon = 0;

        /**
         * flutter传递参数为空
         */
        public static final int sErrorNullFlutterParam = 1;

        /**
         * flutter参数缺少指定内容
         */
        public static final int sErrorFlutterParamMissingContent = 2;

        /**
         * flutter参数类型不对
         */
        public static final int sErrorFlutterParamType = 3;

        /**
         * flutter参数转换出错
         */
        public static final int sErrorParamConvertFailed = 4;

        /**
         * flutter参数转换出错
         */
        public static final int sErrorEngineError = 5;
    }

    // 定位图层
    public static class LocationLayerMethodId {
        // 设定是否显示定位图层
        public static final String sMapShowUserLocationMethod =
                "flutter_bmfmap/userLocation/showUserLocation";

        // 设定定位模式，取值为：BMFUserTrackingMode
        public static final String sMapUserTrackingModeMethod =
                "flutter_bmfmap/userLocation/userTrackingMode";

        // 动态定制我的位置样式
        public static final String sMapUpdateLocationDisplayParamMethod =
                "flutter_bmfmap/userLocation/updateLocationDisplayParam";

        // 动态更新我的位置数据
        public static final String sMapUpdateLocationDataMethod =
                "flutter_bmfmap/userLocation/updateLocationData";
    }

    /**
     * 枚举：室内图切换楼层结果
     */
    public class SwitchIndoorFloorError {
        /**
         * 切换楼层成功
         */
        public static final int SUCCESS = 0;

        /**
         * 切换楼层失败
         */
        public static final int FAILED = 1;

        /**
         * 地图还未聚焦到传入的室内图
         */
        public static final int NOT_FOCUSED = 2;

        /**
         * 当前室内图不存在该楼层
         */
        public static final int NOT_EXIST = 3;

        /**
         * 切换楼层, 室内ID信息错误 [android] 独有
         */
        public static final int SWICH_FLOOR_INFO_ERROR = 4;
    }

    /**
     * 镂空类型
     */
    public class HoleType {

        /**
         * circle(圆形)镂空类型
         */
        public static final int CIRCLE_HOLE_TYPE = 0;

        /**
         * (polygon)多边形镂空类型
         */
        public static final int POLYGON_HOLE_TYPE = 1;
    }
}
