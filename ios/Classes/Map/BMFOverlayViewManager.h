//
//  BMFOverlayViewManager.h
//  flutter_baidu_mapapi_map
//
//  Created by Zhang,Baojin on 2020/11/12.
//

// overlayView处理中心

#ifndef __BMFOverlayViewManager__H__
#define __BMFOverlayViewManager__H__
#ifdef __OBJC__
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#endif
#endif

@class BMFPolylineModel;

NS_ASSUME_NONNULL_BEGIN

@interface BMFOverlayViewManager : NSObject

+ (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay;

+ (BMFPolylineModel *)polylineModelWith:(BMKPolylineView *)view;

@end

NS_ASSUME_NONNULL_END
