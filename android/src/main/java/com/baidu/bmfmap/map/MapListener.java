package com.baidu.bmfmap.map;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.microedition.khronos.opengles.GL10;

import com.baidu.bmfmap.utils.Constants;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.MarkerProtocol.MarkerDragState;
import com.baidu.bmfmap.utils.Env;
import com.baidu.bmfmap.utils.MapTaskManager;
import com.baidu.bmfmap.utils.ThreadPoolUtil;
import com.baidu.bmfmap.utils.converter.FlutterDataConveter;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.MapBaseIndoorMapInfo;
import com.baidu.mapapi.map.MapPoi;
import com.baidu.mapapi.map.MapStatus;
import com.baidu.mapapi.map.Marker;
import com.baidu.mapapi.map.Polyline;
import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.model.LatLngBounds;

import android.graphics.Point;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;

import io.flutter.plugin.common.MethodChannel;

@SuppressWarnings("unchecked")
public class MapListener implements BaiduMap.OnMapClickListener, BaiduMap.OnMapLoadedCallback,
        BaiduMap.OnMapStatusChangeListener, BaiduMap.OnMapRenderCallback,
        BaiduMap.OnMapDrawFrameCallback,
        BaiduMap.OnBaseIndoorMapListener, BaiduMap.OnMarkerClickListener,
        BaiduMap.OnPolylineClickListener,
        BaiduMap.OnMapDoubleClickListener, BaiduMap.OnMapLongClickListener,
        BaiduMap.OnMarkerDragListener,
        BaiduMap.OnMapRenderValidDataListener, BaiduMap.OnMyLocationClickListener {

    private static final int DRAW_FRAME_MESSAGE = 0;
    private static final String TAG = "MapListener";
    private BaiduMap mBaiduMap;
    private MethodChannel mMethodChannel;
    private final Handler mHandler = new Handler() {
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            if (msg != null && msg.what == DRAW_FRAME_MESSAGE) {
                if (null != msg.obj) {
                    mMethodChannel.invokeMethod(
                            Constants.MethodProtocol.MapStateProtocol.sMapOnDrawMapFrameCallback,
                            (HashMap<String, HashMap>) msg.obj);
                }
            }
        }
    };
    private int mReason;

    public MapListener(FlutterMapViewWrapper mapView, MethodChannel methodChannel) {
        this.mMethodChannel = methodChannel;

        if (null == mapView) {
            return;
        }
        mBaiduMap = mapView.getBaiduMap();
        //        init();
    }

    public void init() {
        if (null == mBaiduMap) {
            return;
        }
        mBaiduMap.setOnMapClickListener(this);
        mBaiduMap.setOnMapLoadedCallback(this);
        mBaiduMap.setOnMapStatusChangeListener(this);
        mBaiduMap.setOnMapDrawFrameCallback(this);
        mBaiduMap.setOnMapRenderCallbadk(this);
        mBaiduMap.setOnBaseIndoorMapListener(this);
        mBaiduMap.setOnMarkerClickListener(this);
        mBaiduMap.setOnPolylineClickListener(this);
        mBaiduMap.setOnMapDoubleClickListener(this);
        mBaiduMap.setOnMapLongClickListener(this);
        mBaiduMap.setOnMarkerDragListener(this);
        mBaiduMap.setOnMapRenderValidDataListener(this);
        mBaiduMap.setOnMyLocationClickListener(this);
    }

    public void release() {
        if (null == mBaiduMap) {
            return;
        }
        mBaiduMap.setOnMapClickListener(null);
        mBaiduMap.setOnMapLoadedCallback(null);
        mBaiduMap.setOnMapStatusChangeListener(null);
        mBaiduMap.setOnMapDrawFrameCallback(null);
        mBaiduMap.setOnMapRenderCallbadk(null);
        mBaiduMap.setOnBaseIndoorMapListener(null);
        mBaiduMap.setOnMarkerClickListener(null);
        mBaiduMap.setOnPolylineClickListener(null);
        mBaiduMap.setOnMapDoubleClickListener(null);
        mBaiduMap.setOnMapLongClickListener(null);
        mBaiduMap.setOnMarkerDragListener(null);
        mBaiduMap.setOnMapRenderValidDataListener(null);
        mBaiduMap.setOnMyLocationClickListener(null);
    }

    @Override
    public void onMapClick(LatLng latLng) {
        if (null == latLng || mMethodChannel == null) {
            return;
        }
        HashMap<String, HashMap> coordinateMap = new HashMap<>();
        HashMap<String, Double> coord = new HashMap<>();
        coord.put("latitude", latLng.latitude);
        coord.put("longitude", latLng.longitude);
        coordinateMap.put("coord", coord);
        mMethodChannel.invokeMethod(
                Constants.MethodProtocol.MapStateProtocol.sMapOnClickedMapBlankCallback,
                coordinateMap);
    }

    @Override
    public void onMapPoiClick(MapPoi mapPoi) {
        if (null == mapPoi || mMethodChannel == null) {
            return;
        }
        HashMap<String, Double> pt = new HashMap<>();
        LatLng position = mapPoi.getPosition();
        if (null != position) {
            pt.put("latitude", mapPoi.getPosition().latitude);
            pt.put("longitude", mapPoi.getPosition().longitude);
        }
        HashMap<String, HashMap> poiMap = new HashMap<>();
        HashMap poi = new HashMap();
        poi.put("text", mapPoi.getName());
        poi.put("uid", mapPoi.getUid());
        poi.put("pt", pt);
        poiMap.put("poi", poi);
        mMethodChannel
                .invokeMethod(Constants.MethodProtocol.MapStateProtocol.sMapOnClickedMapPoiCallback,
                        poiMap);
    }

    @Override
    public void onMapLoaded() {
        mMethodChannel
                .invokeMethod(Constants.MethodProtocol.MapStateProtocol.sMapDidLoadCallback, "");
    }

    @Override
    public void onMapStatusChangeStart(MapStatus mapStatus) {
        if (null == mapStatus || mMethodChannel == null) {
            return;
        }
        HashMap<String, Double> targetScreenMap = new HashMap<>();
        Point targetScreen = mapStatus.targetScreen;
        if (null == targetScreen) {
            return;
        }
        targetScreenMap.put("x", (double) targetScreen.x);
        targetScreenMap.put("y", (double) targetScreen.y);
        HashMap<String, Double> targetMap = new HashMap<>();
        LatLng latLng = mapStatus.target;
        if (null == latLng) {
            return;
        }
        targetMap.put("latitude", latLng.latitude);
        targetMap.put("longitude", latLng.longitude);

        LatLngBounds bound = mapStatus.bound;
        if (null == bound) {
            return;
        }
        HashMap latLngBoundMap = latLngBounds(bound);
        if (null == latLngBoundMap) {
            return;
        }
        HashMap statusMap = new HashMap<>();
        HashMap status = new HashMap();
        status.put("fLevel", ((double) mapStatus.zoom));
        double rotate = mapStatus.rotate;
        if (rotate > 180) {
            rotate = rotate - 360;
        }
        status.put("fRotation", rotate);
        status.put("fOverlooking", ((double) mapStatus.overlook));
        status.put("targetScreenPt", targetScreenMap);
        status.put("targetGeoPt", targetMap);
        status.put("visibleMapBounds", latLngBoundMap);
        statusMap.put("mapStatus", status);
        mMethodChannel.invokeMethod(
                Constants.MethodProtocol.MapStateProtocol.sMapRegionWillChangeCallback, statusMap);
    }

    @Override
    public void onMapStatusChangeStart(MapStatus mapStatus, int reason) {
        if (null == mapStatus || mMethodChannel == null) {
            return;
        }
        mReason = reason;
        HashMap<String, Double> targetScreenMap = new HashMap<>();
        Point targetScreen = mapStatus.targetScreen;
        if (null == targetScreen) {
            return;
        }
        targetScreenMap.put("x", (double) targetScreen.x);
        targetScreenMap.put("y", (double) targetScreen.y);
        HashMap<String, Double> targetMap = new HashMap<>();
        LatLng latLng = mapStatus.target;
        if (null == latLng) {
            return;
        }
        targetMap.put("latitude", latLng.latitude);
        targetMap.put("longitude", latLng.longitude);

        LatLngBounds bound = mapStatus.bound;
        if (null == bound) {
            return;
        }
        HashMap latLngBoundMap = latLngBounds(bound);
        if (null == latLngBoundMap) {
            return;
        }
        HashMap statusMap = new HashMap<>();
        HashMap status = new HashMap();
        status.put("fLevel", ((double) mapStatus.zoom));
        double rotate = mapStatus.rotate;
        if (rotate > 180) {
            rotate = rotate - 360;
        }
        status.put("fRotation", rotate);
        status.put("fOverlooking", ((double) mapStatus.overlook));
        status.put("targetScreenPt", targetScreenMap);
        status.put("targetGeoPt", targetMap);
        status.put("visibleMapBounds", latLngBoundMap);
        statusMap.put("mapStatus", status);
        // reason返回值-1与flutter值对应
        statusMap.put("reason", mReason - 1);
        mMethodChannel.invokeMethod(Constants.MethodProtocol.MapStateProtocol.
                sMapRegionWillChangeWithReasonCallback, statusMap);
    }

    @Override
    public void onMapStatusChange(MapStatus mapStatus) {
        if (null == mapStatus || mMethodChannel == null) {
            return;
        }
        HashMap<String, Double> targetScreenMap = new HashMap<>();
        Point targetScreen = mapStatus.targetScreen;
        if (null == targetScreen) {
            return;
        }
        targetScreenMap.put("x", (double) targetScreen.x);
        targetScreenMap.put("y", (double) targetScreen.y);
        HashMap<String, Double> targetMap = new HashMap<>();
        LatLng latLng = mapStatus.target;
        if (null == latLng) {
            return;
        }
        targetMap.put("latitude", latLng.latitude);
        targetMap.put("longitude", latLng.longitude);

        LatLngBounds bound = mapStatus.bound;
        if (null == bound) {
            return;
        }
        HashMap latLngBoundMap = latLngBounds(bound);
        if (null == latLngBoundMap) {
            return;
        }
        final HashMap statusMap = new HashMap<>();
        HashMap status = new HashMap();
        status.put("fLevel", ((double) mapStatus.zoom));
        double rotate = mapStatus.rotate;
        if (rotate > 180) {
            rotate = rotate - 360;
        }
        status.put("fRotation", rotate);
        status.put("fOverlooking", ((double) mapStatus.overlook));
        status.put("targetScreenPt", targetScreenMap);
        status.put("targetGeoPt", targetMap);
        status.put("visibleMapBounds", latLngBoundMap);
        statusMap.put("mapStatus", status);

        MapTaskManager.postToMainThread(new Runnable() {
            @Override
            public void run() {
                mMethodChannel.invokeMethod(
                        Constants.MethodProtocol.MapStateProtocol.sMapRegionDidChangeCallback,
                        statusMap);
            }
        }, 0);

    }

    @Override
    public void onMapStatusChangeFinish(MapStatus mapStatus) {
        if (null == mapStatus || mMethodChannel == null) {
            return;
        }
        HashMap<String, Double> targetScreenMap = new HashMap<>();
        Point targetScreen = mapStatus.targetScreen;
        if (null == targetScreen) {
            return;
        }
        targetScreenMap.put("x", (double) targetScreen.x);
        targetScreenMap.put("y", (double) targetScreen.y);
        HashMap<String, Double> targetMap = new HashMap<>();
        LatLng latLng = mapStatus.target;
        if (null == latLng) {
            return;
        }
        targetMap.put("latitude", latLng.latitude);
        targetMap.put("longitude", latLng.longitude);

        LatLngBounds bound = mapStatus.bound;
        if (null == bound) {
            return;
        }
        HashMap latLngBoundMap = latLngBounds(bound);
        if (null == latLngBoundMap) {
            return;
        }
        HashMap statusMap = new HashMap<>();
        HashMap status = new HashMap();
        status.put("fLevel", ((double) mapStatus.zoom));
        double rotate = mapStatus.rotate;
        if (rotate > 180) {
            rotate = rotate - 360;
        }
        status.put("fRotation", rotate);
        status.put("fOverlooking", ((double) mapStatus.overlook));
        status.put("targetScreenPt", targetScreenMap);
        status.put("targetGeoPt", targetMap);
        status.put("visibleMapBounds", latLngBoundMap);
        statusMap.put("mapStatus", status);
        // reason返回值-1与flutter值对应
        statusMap.put("reason", mReason - 1);
        mMethodChannel.invokeMethod(
                Constants.MethodProtocol.MapStateProtocol.sMapRegionDidChangeWithReasonCallback,
                statusMap);
        mMethodChannel.invokeMethod(
                Constants.MethodProtocol.MapStateProtocol.sMapStatusDidChangedCallback, "");
    }

    @Override
    public void onMapRenderFinished() {
        HashMap hashMap = new HashMap();
        hashMap.put("success", true);
        mMethodChannel
                .invokeMethod(Constants.MethodProtocol.MapStateProtocol.sMapDidFinishRenderCallback,
                        hashMap);
    }

    @Override
    public void onMapDrawFrame(GL10 gl10, MapStatus mapStatus) {

    }

    @Override
    public void onMapDrawFrame(MapStatus mapStatus) {
        if (null == mapStatus || mMethodChannel == null) {
            return;
        }
        HashMap<String, Double> targetScreenMap = new HashMap<>();
        Point targetScreen = mapStatus.targetScreen;
        if (null == targetScreen) {
            return;
        }
        targetScreenMap.put("x", (double) targetScreen.x);
        targetScreenMap.put("y", (double) targetScreen.y);
        HashMap<String, Double> targetMap = new HashMap<>();
        LatLng latLng = mapStatus.target;
        if (null == latLng) {
            return;
        }
        targetMap.put("latitude", latLng.latitude);
        targetMap.put("longitude", latLng.longitude);

        LatLngBounds bound = mapStatus.bound;
        if (null == bound) {
            return;
        }

        HashMap latLngBoundMap = latLngBounds(bound);
        if (null == latLngBoundMap) {
            return;
        }
        final HashMap<String, HashMap> statusMap = new HashMap<>();
        HashMap status = new HashMap();
        status.put("fLevel", ((double) mapStatus.zoom));
        double rotate = mapStatus.rotate;
        if (rotate > 180) {
            rotate = rotate - 360;
        }
        status.put("fRotation", rotate);
        status.put("fOverlooking", ((double) mapStatus.overlook));
        status.put("targetScreenPt", targetScreenMap);
        status.put("targetGeoPt", targetMap);
        status.put("visibleMapBounds", latLngBoundMap);
        statusMap.put("mapStatus", status);

        ThreadPoolUtil.getInstance().execute(new Runnable() {
            @Override
            public void run() {
                Message msg = Message.obtain();
                msg.arg1 = DRAW_FRAME_MESSAGE;
                msg.obj = statusMap;
                mHandler.sendMessage(msg);
            }
        });

    }

    @Override
    public void onBaseIndoorMapMode(boolean isIndoorMap,
                                    MapBaseIndoorMapInfo mapBaseIndoorMapInfo) {
        if (mMethodChannel == null) {
            return;
        }
        HashMap indoorHashMap = new HashMap();
        indoorHashMap.put("flag", isIndoorMap);
        HashMap indoorMap = new HashMap();
        if (isIndoorMap) {
            if (null == mapBaseIndoorMapInfo) {
                return;
            }
            String curFloor = mapBaseIndoorMapInfo.getCurFloor();
            String id = mapBaseIndoorMapInfo.getID();
            ArrayList<String> floors = mapBaseIndoorMapInfo.getFloors();
            indoorMap.put("strFloor", curFloor);
            indoorMap.put("strID", id);
            indoorMap.put("listStrFloors", floors);
        }
        indoorHashMap.put("info", indoorMap);
        mMethodChannel.invokeMethod(
                Constants.MethodProtocol.MapStateProtocol.sMapInOrOutBaseIndoorMapCallback
                , indoorHashMap);
    }

    @Override
    public boolean onMarkerClick(Marker marker) {
        if (Env.DEBUG) {
            Log.d(TAG, "onMarkerClick");
        }
        if (null == mMethodChannel) {
            return false;
        }

        Bundle bundle = marker.getExtraInfo();
        if (null == bundle) {
            if (Env.DEBUG) {
                Log.d(TAG, "bundle is null");
            }
            return false;
        }

        String id = bundle.getString("id");
        if (TextUtils.isEmpty(id)) {
            if (Env.DEBUG) {
                Log.d(TAG, "marker id is null ");
            }
            return false;
        }

        Map<String, Object> markerMap = createMarkerMap(marker);
        if (null == markerMap) {
            return false;
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("marker", markerMap);

        mMethodChannel.invokeMethod(Constants.MethodProtocol.MarkerProtocol.sMapClickedmarkedMethod,
                resultMap);

        return true;
    }

    private Map<String, Object> createMarkerMap(Marker marker) {
        if (null == marker) {
            return null;
        }

        Bundle bundle = marker.getExtraInfo();
        if (null == bundle) {
            if (Env.DEBUG) {
                Log.d(TAG, "bundle is null");
            }
            return null;
        }

        String id = bundle.getString("id");
        if (TextUtils.isEmpty(id)) {
            if (Env.DEBUG) {
                Log.d(TAG, "marker id is null ");
            }
            return null;
        }

        String icon = bundle.getString("icon");
        if (TextUtils.isEmpty(icon)) {
            return null;
        }

        Map<String, Object> markerMap = new HashMap<>();
        markerMap.put("id", id);
        markerMap.put("title", marker.getTitle());
        markerMap.put("icon", icon);
        markerMap.put("position", FlutterDataConveter.latLngToMap(marker.getPosition()));
        markerMap.put("isLockedToScreen", marker.isFixed());
        Map<String, Double> centerOffset = new HashMap<>();
        centerOffset.put("y", (double) marker.getYOffset());
        centerOffset.put("x", 0.0);
        markerMap.put("centerOffset", centerOffset);
        markerMap.put("enabled", marker.isClickable());
        markerMap.put("draggable", marker.isDraggable());
        markerMap.put("scaleX", marker.getScaleX());
        markerMap.put("scaleY", marker.getScaleY());
        markerMap.put("alpha", marker.getAlpha());
        markerMap.put("isPerspective", marker.isPerspective());
        markerMap.put("isPerspective", marker.isPerspective());
        markerMap.put("screenPointToLock",
                FlutterDataConveter.pointToMap(marker.getFixedPosition()));

        return markerMap;
    }

    @Override
    public boolean onPolylineClick(Polyline polyline) {

        Log.d("polyline", "polyline click");

        HashMap hashMap = polylineClick(polyline);
        HashMap<String, Object> polyLineMap = new HashMap<>();
        polyLineMap.put("polyline", hashMap);
        mMethodChannel.invokeMethod(
                Constants.MethodProtocol.PolylineProtocol.sMapOnClickedOverlayCallback,
                polyLineMap);

        return true;
    }

    private HashMap polylineClick(Polyline polyline) {
        if (null == polyline) {
            return null;
        }

        Bundle bundle = polyline.getExtraInfo();
        if (null == bundle) {
            return null;
        }

        String id = bundle.getString("id");
        if (TextUtils.isEmpty(id)) {
            return null;
        }

        ArrayList<Integer> indexs = bundle.getIntegerArrayList("indexs");
        if (null == indexs) {
            return null;
        }

        ArrayList<String> textures = bundle.getStringArrayList("textures");

        HashMap polylineMap = new HashMap();

        List<LatLng> points = polyline.getPoints();
        List<Object> latlngLists = new ArrayList<>();
        if (null != points) {
            for (int i = 0; i < points.size(); i++) {
                HashMap<String, Double> latlngHashMap = new HashMap<>();
                latlngHashMap.put("latitude", points.get(i).latitude);
                latlngHashMap.put("longitude", points.get(i).longitude);
                latlngLists.add(latlngHashMap);
            }
        }
        polylineMap.put("id", id);
        polylineMap.put("coordinates", latlngLists);

        ArrayList<String> colorList = new ArrayList<>();
        int[] colors = polyline.getColorList();
        if (null != colors) {
            for (int i = 0; i < colors.length; i++) {
                colorList.add(Integer.toHexString(colors[i]));
            }
        }

        polylineMap.put("colors", colorList);

        polylineMap.put("color", polyline.getColor());
        polylineMap.put("lineDashType", polyline.getDottedLineType());
        polylineMap.put("lineCapType", 0);
        polylineMap.put("lineJoinType", 0);
        polylineMap.put("width", polyline.getWidth());
        polylineMap.put("zIndex", polyline.getZIndex());
        polylineMap.put("indexs", indexs);
        polylineMap.put("textures", textures);

        return polylineMap;
    }

    @Override
    public void onMapDoubleClick(LatLng latLng) {
        if (null == latLng || mMethodChannel == null) {
            return;
        }
        HashMap<String, HashMap> coordinateMap = new HashMap<>();
        HashMap<String, Double> coord = new HashMap<>();
        coord.put("latitude", latLng.latitude);
        coord.put("longitude", latLng.longitude);
        coordinateMap.put("coord", coord);
        mMethodChannel
                .invokeMethod(Constants.MethodProtocol.MapStateProtocol.sMapOnDoubleClickCallback,
                        coordinateMap);
    }

    @Override
    public void onMapLongClick(LatLng latLng) {
        if (null == latLng || mMethodChannel == null) {
            return;
        }
        HashMap<String, HashMap> coordinateMap = new HashMap<>();
        HashMap<String, Double> coord = new HashMap<>();
        coord.put("latitude", latLng.latitude);
        coord.put("longitude", latLng.longitude);
        coordinateMap.put("coord", coord);
        mMethodChannel
                .invokeMethod(Constants.MethodProtocol.MapStateProtocol.sMapOnLongClickCallback,
                        coordinateMap);
    }

    @Override
    public void onMarkerDrag(Marker marker) {
        if (Env.DEBUG) {
            Log.d(TAG, "onMarkerDrag");
        }
        if (null == mMethodChannel) {
            return;
        }

        Map<String, Object> markerMap = createMarkerMap(marker);
        if (null == markerMap) {
            return;
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("marker", markerMap);
        resultMap.put("oldState", MarkerDragState.Starting.ordinal());
        resultMap.put("newState", MarkerDragState.Dragging.ordinal());

        mMethodChannel.invokeMethod(Constants.MethodProtocol.MarkerProtocol.sMapDragMarkerMethod,
                resultMap);
    }

    @Override
    public void onMarkerDragEnd(Marker marker) {
        if (Env.DEBUG) {
            Log.d(TAG, "onMarkerDrag");
        }
        if (null == mMethodChannel) {
            return;
        }

        Map<String, Object> markerMap = createMarkerMap(marker);
        if (null == markerMap) {
            return;
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("marker", markerMap);
        resultMap.put("oldState", MarkerDragState.Dragging.ordinal());
        resultMap.put("newState", MarkerDragState.Ending.ordinal());

        mMethodChannel.invokeMethod(Constants.MethodProtocol.MarkerProtocol.sMapDragMarkerMethod,
                resultMap);
    }

    @Override
    public void onMarkerDragStart(Marker marker) {
        if (Env.DEBUG) {
            Log.d(TAG, "onMarkerDrag");
        }

        Map<String, Object> markerMap = createMarkerMap(marker);
        if (null == markerMap) {
            return;
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("marker", markerMap);
        resultMap.put("oldState", MarkerDragState.None.ordinal());
        resultMap.put("newState", MarkerDragState.Starting.ordinal());

        mMethodChannel.invokeMethod(Constants.MethodProtocol.MarkerProtocol.sMapDragMarkerMethod,
                resultMap);
    }

    @Override
    public void onMapRenderValidData(boolean isValid, int errorCode, String errorMessage) {
        HashMap hashMap = new HashMap();
        hashMap.put("isValid", isValid);
        hashMap.put("errorCode", errorCode);
        hashMap.put("errorMessage", errorMessage);
        mMethodChannel
                .invokeMethod(Constants.MethodProtocol.MapStateProtocol.sMapRenderValidDataCallback,
                        hashMap);
    }

    @Override
    public boolean onMyLocationClick() {
        return false;
    }

    private HashMap latLngBounds(LatLngBounds latLngBounds) {
        if (null == latLngBounds) {
            return null;
        }
        // 该地理范围东北坐标
        LatLng northeast = latLngBounds.northeast;
        // 该地理范围西南坐标
        LatLng southwest = latLngBounds.southwest;

        HashMap boundsMap = new HashMap();
        HashMap northeastMap = new HashMap<String, Double>();
        if (null == northeast) {
            return null;
        }
        northeastMap.put("latitude", northeast.latitude);
        northeastMap.put("longitude", northeast.longitude);
        HashMap southwestMap = new HashMap<String, Double>();
        if (null == southwest) {
            return null;
        }
        southwestMap.put("latitude", southwest.latitude);
        southwestMap.put("longitude", southwest.longitude);
        boundsMap.put("northeast", northeastMap);
        boundsMap.put("southwest", southwestMap);
        return boundsMap;
    }
}

