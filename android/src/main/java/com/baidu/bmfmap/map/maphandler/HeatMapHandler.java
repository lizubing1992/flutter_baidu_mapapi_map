package com.baidu.bmfmap.map.maphandler;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.baidu.bmfmap.BMFMapController;
import com.baidu.bmfmap.utils.Constants.MethodProtocol.HeatMapProtocol;
import com.baidu.bmfmap.utils.Env;
import com.baidu.bmfmap.utils.converter.FlutterDataConveter;
import com.baidu.bmfmap.utils.converter.TypeConverter;
import com.baidu.mapapi.map.Gradient;
import com.baidu.mapapi.map.HeatMap;
import com.baidu.mapapi.map.WeightedLatLng;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

class HeatMapHandler extends BMapHandler {
    private static final String TAG = "HeapMapHandler";

    private HeatMap mHeatMap = null;
    
    public HeatMapHandler(BMFMapController bmfMapController) {
        super(bmfMapController);
    }

    @Override
    public void handlerMethodCallResult(Context context, MethodCall call,
                                        MethodChannel.Result result) {
        if (null == call) {
            result.success(false);
            return;
        }

        String methodId = call.method;
        if (TextUtils.isEmpty(methodId)) {
            result.success(false);
            return;
        }

        boolean ret = false;
        switch (methodId) {
            case HeatMapProtocol.sMapAddHeatMapMethod:
                ret = addHeapMap(context, call);
                break;
            case HeatMapProtocol.sMapRemoveHeatMapMethod:
                ret = removeHeatMap(context, call);
                break;
            case HeatMapProtocol.sShowHeatMapMethod:
                ret = isShowBaiduHeatMap(call);
                break;
            default:
                break;
        }

        result.success(ret);
    }

    /**
     * 是否显示百度热力图
     */
    public boolean isShowBaiduHeatMap(MethodCall call) {
        Map<String, Object> argument = call.arguments();
        if (argument == null || !argument.containsKey("show")) {
            return false;
        }
        Boolean show = (Boolean) argument.get("show");
        if (null == show) {
            return false;
        }
        if (null == mBaiduMap) {
            return false;
        }
        mBaiduMap.setBaiduHeatMapEnabled(show);

        return true;
    }

    public boolean addHeapMap(Context context, MethodCall call) {
        if (Env.DEBUG) {
            Log.d(TAG, "addHeapMap enter");
        }
        Map<String, Object> argument = call.arguments();
        if (null == argument) {
            if (Env.DEBUG) {
                Log.d(TAG, "argument is null");
            }
            return false;
        }

        Object heatMapObj = argument.get("heatMap");
        if (null == heatMapObj) {
            if (Env.DEBUG) {
                Log.d(TAG, "null == heatMapObj");
            }
            return false;
        }

        Map<String, Object> heatMapMap = (Map<String, Object>) heatMapObj;
        if (null == heatMapMap) {
            if (Env.DEBUG) {
                Log.d(TAG, "null == heatMapMap");
            }
            return false;
        }

        if (!heatMapMap.containsKey("data")
                || !heatMapMap.containsKey("radius")
                || !heatMapMap.containsKey("opacity")
                || !heatMapMap.containsKey("gradient")) {
            if (Env.DEBUG) {
                Log.d(TAG, "argument does not contain" + argument.toString());

            }
            return false;
        }

        HeatMap.Builder builder = new HeatMap.Builder();

        List<WeightedLatLng> weightedLatLngList = getData(heatMapMap);
        if (null == weightedLatLngList) {
            if (Env.DEBUG) {
                Log.d(TAG, "null == weightedLatLngList");
            }
            return false;
        }
        builder.weightedData(weightedLatLngList);

        Object gradientObj = heatMapMap.get("gradient");
        if (null == gradientObj) {
            if (Env.DEBUG) {
                Log.d(TAG, "null == gradientObj");
            }
            return false;
        }
        Map<String, Object> gradientMap = (Map<String, Object>) gradientObj;
        if (null == gradientMap) {
            if (Env.DEBUG) {
                Log.d(TAG, "null == gradientMap");
            }
            return false;
        }

        Gradient gradient = getGradient(gradientMap);
        builder.gradient(gradient);

        Double opacity = new TypeConverter<Double>().getValue(heatMapMap, "opacity");
        if (null == opacity) {
            if (Env.DEBUG) {
                Log.d(TAG, "null == opacity");
            }
            return false;
        }

        builder.opacity(opacity);

        Integer radius = new TypeConverter<Integer>().getValue(heatMapMap, "radius");
        if (null == radius) {
            if (Env.DEBUG) {
                Log.d(TAG, "null == radius");
            }
            return false;
        }
        builder.radius(radius);

        mHeatMap = builder.build();

        if (null == mHeatMap) {
            if (Env.DEBUG) {
                Log.d(TAG, "null == mHeatMap");
            }
            return false;
        }

        if (null == mBaiduMap) {
            return false;
        }

        mBaiduMap.addHeatMap(mHeatMap);
        return true;
    }

    private List<WeightedLatLng> getData(Map<String, Object> heatMapMap) {
        List<WeightedLatLng> weightedLatLngList = null;
        Object dataObj = heatMapMap.get("data");
        if (null == dataObj) {
            return null;
        }

        List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataObj;
        if (null == dataList) {
            return null;
        }

        weightedLatLngList = FlutterDataConveter.mapToWeightedLatLngList(dataList);

        return weightedLatLngList;
    }

    private Gradient getGradient(Map<String, Object> heatMapMap) {
        if (!heatMapMap.containsKey("colors") || !heatMapMap.containsKey("startPoints")) {
            return null;
        }

        Object colorsObj = heatMapMap.get("colors");
        Object startPointsObj = heatMapMap.get("startPoints");
        if (null == colorsObj || null == startPointsObj) {
            return null;
        }

        List<String> colorsList = (List<String>) colorsObj;
        List<Double> startPointsList = (List<Double>) startPointsObj;
        if (null == colorsList || null == startPointsList) {
            return null;
        }

        int[] intColors = new int[colorsList.size()];
        Iterator<String> itr = colorsList.iterator();
        int i = 0;
        while (itr.hasNext()) {
            String colorStr = itr.next();
            int color = FlutterDataConveter.strColorToInteger(colorStr);
            intColors[i++] = color;
        }

        float[] startPoints = new float[startPointsList.size()];
        Iterator<Double> startPointsItr = startPointsList.iterator();
        i = 0;
        while (startPointsItr.hasNext()) {
            startPoints[i++] = startPointsItr.next().floatValue();
        }

        Gradient gradient = new Gradient(intColors, startPoints);
        return gradient;
    }

    public boolean removeHeatMap(Context context, MethodCall call) {
        if (Env.DEBUG) {
            Log.d(TAG, "switchHeatMap enter");
        }

        if (null == mHeatMap) {
            return false;
        }

        mHeatMap.removeHeatMap();
        mHeatMap = null;

        return true;
    }

}