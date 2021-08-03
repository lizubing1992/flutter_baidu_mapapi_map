package com.baidu.bmfmap.interfaces;

import com.baidu.mapapi.map.LogoPosition;
import com.baidu.mapapi.model.LatLngBounds;

import android.graphics.Point;

/**
 * Copyright (C) 2019 Baidu, Inc. All Rights Reserved.
 */
public interface BaiduMapInterface {

    void showMapIndoorPoi(Boolean isShow);

    void setIndoorEnable(Boolean enabled);

    void setViewPadding(int left, int top, int right, int bottom);

    void setBaiduHeatMapEnabled(Boolean enabled);

    void setTrafficEnabled(Boolean enabled);

    void showMapPoi(Boolean isShow);

    void setBuildingsEnabled(Boolean enabled);

    void setMaxAndMinZoomLevel(float max, float min);

    void setMapType(int mapType);

    void showScaleControl(Boolean showScaleControl);

    void setScaleControlPosition(Point scaleControlPosition);

    void setZoomControlsPosition(Point zoomControlsPosition);

    void setLogoPosition(LogoPosition logoPosition);

    void setMapStatusLimits(LatLngBounds latLngBounds);

    void setEnlargeCenterWithDoubleClickEnable(Boolean enabled);

    void setAllGesturesEnabled(Boolean enabled);

    void setCompassEnabled(Boolean enabled);

    void setRotateGesturesEnabled(Boolean enabled);

    void setScrollGesturesEnabled(Boolean enabled);

    void setOverlookingGesturesEnabled(Boolean enabled);

    void setZoomGesturesEnabled(Boolean enabled);

    void setDoubleClickZoomEnabled(Boolean enabled);

    void setTwoTouchClickZoomEnabled(Boolean enabled);

    void clearAllOverlay();

}
