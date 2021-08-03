package com.baidu.bmfmap.map.overlayHandler;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.baidu.bmfmap.BMFMapController;
import com.baidu.bmfmap.utils.Constants;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.ArclineProtocol;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.CirclelineProtocol;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.DotProtocol;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.GroundProtocol;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.OverlayProtocol;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.PolygonProtocol;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.PolylineProtocol;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.TextProtocol;
import com.baidu.bmfmap.utils.Constants.OverlayHandlerType;
import com.baidu.bmfmap.utils.Env;
import com.baidu.bmfmap.utils.converter.TypeConverter;
import com.baidu.mapapi.map.Overlay;

import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class OverlayHandlerFactory {
    private static final String TAG = "OverlayHandlerFactory";

    private HashMap<Integer, OverlayHandler> overlayHandlerHashMap;

    public OverlayHandlerFactory(BMFMapController bmfMapController) {
        init(bmfMapController);
    }

    private void init(BMFMapController bmfMapController) {
        if (null == bmfMapController) {
            return;
        }

        overlayHandlerHashMap = new HashMap<>();
        overlayHandlerHashMap
                .put(OverlayHandlerType.OVERLAY_COMMON_HANDLER, new OverlayHandler(bmfMapController));
        overlayHandlerHashMap
                .put(OverlayHandlerType.CIRCLE_HANDLER, new CircleHandler(bmfMapController));
        overlayHandlerHashMap.put(OverlayHandlerType.DOT_HANDLER, new DotHandler(bmfMapController));
        overlayHandlerHashMap
                .put(OverlayHandlerType.POLYGON_HANDLER, new PolygonHandler(bmfMapController));
        overlayHandlerHashMap
                .put(OverlayHandlerType.POLYLINE_HANDLER, new PolylineHandler(bmfMapController));
        overlayHandlerHashMap
                .put(OverlayHandlerType.TEXT_HANDLER, new TextHandler(bmfMapController));
        overlayHandlerHashMap
                .put(OverlayHandlerType.ARCLINE_HANDLER, new ArcLineHandler(bmfMapController));
        overlayHandlerHashMap
                .put(OverlayHandlerType.GROUND_HANDLER, new GroundHandler(bmfMapController));
        overlayHandlerHashMap
                .put(OverlayHandlerType.INFOWINDOW_HANDLER,
                        new InfoWindowHandler(bmfMapController));
        overlayHandlerHashMap
                .put(OverlayHandlerType.MARKER_HANDLER, new MarkerHandler(bmfMapController));
    }

    public boolean dispatchMethodHandler(MethodCall call, MethodChannel.Result result) {
        if (null == call) {
            if (Env.DEBUG) {
                Log.d(TAG, "dispatchMethodHandler: null == call");
            }
            return false;
        }

        String methodId = call.method;
        if (Env.DEBUG) {
            Log.d(TAG, "dispatchMethodHandler: " + methodId);
        }
        OverlayHandler overlayHandler = null;
        switch (methodId) {
            case Constants.MethodProtocol.MarkerProtocol.sMapAddMarkerMethod:
            case Constants.MethodProtocol.MarkerProtocol.sMapAddMarkersMethod:
            case Constants.MethodProtocol.MarkerProtocol.sMapRemoveMarkerMethod:
            case Constants.MethodProtocol.MarkerProtocol.sMapRemoveMarkersMethod:
            case Constants.MethodProtocol.MarkerProtocol.sMapDidSelectMarkerMethod:
            case Constants.MethodProtocol.MarkerProtocol.sMapDidDeselectMarkerMethod:
            case Constants.MethodProtocol.MarkerProtocol.sMapCleanAllMarkersMethod:
            case Constants.MethodProtocol.MarkerProtocol.sMapUpdateMarkerMemberMethod:
                overlayHandler =
                        overlayHandlerHashMap.get(OverlayHandlerType.MARKER_HANDLER);
                break;
            case Constants.MethodProtocol.InfoWindowProtocol.sAddInfoWindowMapMethod:
            case Constants.MethodProtocol.InfoWindowProtocol.sRemoveInfoWindowMapMethod:
            case Constants.MethodProtocol.InfoWindowProtocol.sAddInfoWindowsMapMethod:
                overlayHandler =
                        overlayHandlerHashMap.get(OverlayHandlerType.INFOWINDOW_HANDLER);
                break;
            case ArclineProtocol.sMapAddArclinelineMethod:
            case ArclineProtocol.sMapUpdateArclineMemberMethod:
                overlayHandler = overlayHandlerHashMap.get(OverlayHandlerType.ARCLINE_HANDLER);
                break;
            case PolygonProtocol.sMapAddPolygonMethod:
            case PolygonProtocol.sMapUpdatePolygonMemberMethod:
                overlayHandler = overlayHandlerHashMap.get(OverlayHandlerType.POLYGON_HANDLER);
                break;
            case CirclelineProtocol.sMapAddCirclelineMethod:
            case CirclelineProtocol.sMapUpdateCircleMemberMethod:
                overlayHandler = overlayHandlerHashMap.get(OverlayHandlerType.CIRCLE_HANDLER);
                break;
            case PolylineProtocol.sMapAddPolylineMethod:
            case PolylineProtocol.sMapUpdatePolylineMemberMethod:
                overlayHandler = overlayHandlerHashMap.get(OverlayHandlerType.POLYLINE_HANDLER);
                break;
            case DotProtocol.sMapAddDotMethod:
            case DotProtocol.sMapUpdateDotMemberMethod:
                overlayHandler = overlayHandlerHashMap.get(OverlayHandlerType.DOT_HANDLER);
                break;
            case TextProtocol.sMapAddTextMethod:
            case TextProtocol.sMapUpdateTextMemberMethod:
                overlayHandler = overlayHandlerHashMap.get(OverlayHandlerType.TEXT_HANDLER);
                break;
            case GroundProtocol.sMapAddGroundMethod:
            case GroundProtocol.sMapUpdateGroundMemberMethod:
                overlayHandler = overlayHandlerHashMap.get(OverlayHandlerType.GROUND_HANDLER);
                break;
            case OverlayProtocol.sMapRemoveOverlayMethod:
                overlayHandler = overlayHandlerHashMap.get(OverlayHandlerType.OVERLAY_COMMON_HANDLER);
                break;
            default:
                break;
        }

        if (null == overlayHandler) {
            return false;
        }

        overlayHandler.handlerMethodCall(call, result);
        return true;
    }

    public void release() {
        if (null == overlayHandlerHashMap || overlayHandlerHashMap.size() == 0) {
            return;
        }

        OverlayHandler overlayHandler = null;
        Iterator iterator = overlayHandlerHashMap.values().iterator();
        while (iterator.hasNext()) {
            overlayHandler = (OverlayHandler) iterator.next();
            if (null == overlayHandler) {
                continue;
            }

            overlayHandler.clean();
        }
    }

}