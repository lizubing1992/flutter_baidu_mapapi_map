package com.baidu.bmfmap.map.maphandler;

import android.content.Context;
import android.graphics.Color;
import android.text.TextUtils;

import com.baidu.bmfmap.BMFMapController;
import com.baidu.bmfmap.utils.Constants;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MyLocationConfiguration;
import com.baidu.mapapi.map.MyLocationData;
import com.baidu.bmfmap.utils.Env;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public class LocationLayerHandler extends BMapHandler {

    public LocationLayerHandler(BMFMapController bmfMapController) {
        super(bmfMapController);
    }

    @Override
    public void handlerMethodCallResult(Context context, MethodCall call, MethodChannel.Result result) {
        if (null == call) {
            result.success(false);
            return;
        }
        String methodId = call.method;
        if (TextUtils.isEmpty(methodId)) {
            result.success(false);
            return;
        }
        switch (methodId) {
            case Constants.LocationLayerMethodId.sMapShowUserLocationMethod:
                setLocationEnabled(call, result);
                break;

            case Constants.LocationLayerMethodId.sMapUpdateLocationDataMethod:
                setUpdateLocationData(call, result);
                break;

            case Constants.LocationLayerMethodId.sMapUserTrackingModeMethod:
                setLoctype(call, result);

                break;
            case Constants.LocationLayerMethodId.sMapUpdateLocationDisplayParamMethod:
                setCustomLocation(call, result);
                break;
            default:
                break;
        }
    }

    /**
     * 自定义定位图层
     */
    private void setCustomLocation(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> argument = call.arguments();
        if (null == argument || null == mBaiduMap) {
            result.success(false);
            return;
        }
        if (!argument.containsKey("userlocationDisplayParam")) {
            result.success(false);
            return;
        }

        Map<String, Object> locationDisplayParam = (Map<String, Object>) argument.get("userlocationDisplayParam");

        if (null == locationDisplayParam) {
            result.success(false);
            return;
        }

        if (!locationDisplayParam.containsKey("userTrackingMode")
                || !locationDisplayParam.containsKey("enableDirection")
                || !locationDisplayParam.containsKey("accuracyCircleStrokeColor")
                || !locationDisplayParam.containsKey("accuracyCircleFillColor")
                || !locationDisplayParam.containsKey("locationViewImage")
                || !locationDisplayParam.containsKey("locationViewHierarchy")) {
            result.success(false);
            return;
        }

        Integer userTrackingMode = (Integer) locationDisplayParam.get("userTrackingMode");
        Boolean enableDirection = (Boolean) locationDisplayParam.get("enableDirection");
        String locationViewImage = (String) locationDisplayParam.get("locationViewImage");
        String accuracyCircleStrokeColor = (String) locationDisplayParam.get("accuracyCircleStrokeColor");
        String accuracyCircleFillColor = (String) locationDisplayParam.get("accuracyCircleFillColor");


        BitmapDescriptor bitmap = null;
        if (!TextUtils.isEmpty(locationViewImage)) {
             bitmap = BitmapDescriptorFactory.fromAsset("flutter_assets/" + locationViewImage);
        }

        int strokeColor = 0;
        String color = "#";
        if (!TextUtils.isEmpty(accuracyCircleStrokeColor)) {
             strokeColor = Color.parseColor(color.concat(accuracyCircleStrokeColor));
        }

        int fillColor = 0;
        if (!TextUtils.isEmpty(accuracyCircleFillColor)) {
            fillColor = Color.parseColor(color.concat(accuracyCircleFillColor));
        }

        if (null != userTrackingMode && null != enableDirection && null != bitmap
                && strokeColor != 0 && fillColor != 0) {
            switch (userTrackingMode) {
                case Env.LocationMode.NORMAL:
                case Env.LocationMode.MODEHEADING:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.NORMAL, enableDirection,
                            bitmap,fillColor,strokeColor));
                    break;
                case Env.LocationMode.FOLLOWING:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.FOLLOWING, enableDirection,
                            bitmap,fillColor,strokeColor));
                    break;
                case Env.LocationMode.COMPASS:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.COMPASS, enableDirection,
                            bitmap,fillColor,strokeColor));
                    break;
                default:
                    break;
            }

        } else if (null != userTrackingMode && null != enableDirection && strokeColor != 0 && fillColor != 0) {
            switch (userTrackingMode) {
                case Env.LocationMode.NORMAL:
                case Env.LocationMode.MODEHEADING:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.NORMAL, enableDirection,
                            null,fillColor,strokeColor));
                    break;
                case Env.LocationMode.FOLLOWING:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.FOLLOWING, enableDirection,
                            null,fillColor,strokeColor));
                    break;
                case Env.LocationMode.COMPASS:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.COMPASS, enableDirection,
                            null,fillColor,strokeColor));
                    break;
                default:
                    break;
            }
        }
    }

    /**
     * 设置定位模式
     */
    private void setLoctype(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> argument = call.arguments();
        if (null == argument || null == mBaiduMap) {
            result.success(false);
            return;
        }

        if (!argument.containsKey("userTrackingMode")
                || !argument.containsKey("enableDirection")
                || !argument.containsKey("customMarker")) {
            result.success(false);
            return;
        }
        Integer userTrackingMode = (Integer) argument.get("userTrackingMode");
        Boolean enableDirection = (Boolean) argument.get("enableDirection");
        String customMarker = (String) argument.get("customMarker");

        BitmapDescriptor bitmap = BitmapDescriptorFactory.fromAsset("flutter_assets/" + customMarker);
        if (null != userTrackingMode && null != enableDirection && null != bitmap) {
            switch (userTrackingMode) {
                case Env.LocationMode.NORMAL:
                case Env.LocationMode.MODEHEADING:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.NORMAL, enableDirection, bitmap));
                    break;
                case Env.LocationMode.FOLLOWING:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.FOLLOWING, enableDirection, bitmap));
                    break;
                case Env.LocationMode.COMPASS:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.COMPASS, enableDirection, bitmap));
                    break;
                default:
                    break;
            }
            result.success(true);
        } else if (null != userTrackingMode && null != enableDirection) {
            switch (userTrackingMode) {
                case Env.LocationMode.NORMAL:
                case Env.LocationMode.MODEHEADING:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.NORMAL, enableDirection, null));
                    break;
                case Env.LocationMode.FOLLOWING:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.FOLLOWING, enableDirection, null));
                    break;
                case Env.LocationMode.COMPASS:
                    mBaiduMap.setMyLocationConfiguration(new MyLocationConfiguration(
                            MyLocationConfiguration.LocationMode.COMPASS, enableDirection, null));
                    break;
                default:
                    break;
            }
            result.success(true);
        }
        result.success(false);
    }

    /**
     * 定位数据
     */
    private void setUpdateLocationData(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> argument = call.arguments();
        MyLocationData.Builder builder = new MyLocationData.Builder();
        if (null == argument || null == mBaiduMap) {
            result.success(false);
            return;
        }
        if (!argument.containsKey("userLocation")) {
            result.success(false);
            return;
        }

        Map<String,Object> userLocation = (Map<String, Object>) argument.get("userLocation");
        if (null == userLocation) {
            result.success(false);
            return;
        }
        if (!userLocation.containsKey("location")) {
            result.success(false);
            return;
        }

        Map<String,Object> location = (Map<String, Object>) userLocation.get("location");
        if (null == location) {
            result.success(false);
            return;
        }
        if (!location.containsKey("coordinate") || !location.containsKey("course")
                || !location.containsKey("speed") || !location.containsKey("accuracy")
                || !location.containsKey("satellitesNum")) {
            result.success(false);
            return;
        }
        Map<String,Double>  coordinate = (Map<String, Double>) location.get("coordinate");
        if (null !=  coordinate) {
            if (coordinate.containsKey("latitude") && coordinate.containsKey("longitude")) {
                Double latitude = coordinate.get("latitude");
                Double longitude = coordinate.get("longitude");
                if (null != latitude && null != longitude) {
                    builder.latitude(latitude);
                    builder.longitude(longitude);
                }
            }
        }
        Double course = (Double) location.get("course");
        if (null !=  course) {
            builder.direction(course.floatValue());
        }

        Double speed = (Double) location.get("speed");
        if (null !=  speed) {
            builder.speed(speed.floatValue());
        }

        Double accuracy = (Double) location.get("accuracy");
        if (null !=  accuracy) {
            builder.accuracy(accuracy.floatValue());
        }

        Integer satellitesNum = (Integer) location.get("satellitesNum");
        if (null !=  satellitesNum) {
            builder.satellitesNum(satellitesNum);
        }

        mBaiduMap.setMyLocationData(builder.build());
        result.success(true);
    }

    /**
     * 开启定位图层
     */
    private void setLocationEnabled(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> argument = call.arguments();
        if (null == argument || null == mBaiduMap) {
            result.success(false);
            return;
        }

        if (!argument.containsKey("show")) {
            result.success(false);
            return;
        }

        Boolean show = (Boolean) argument.get("show");
        if (null == show) {
            result.success(false);
            return;
        }
        mBaiduMap.setMyLocationEnabled(show);
        result.success(true);
    }
}
