//
//  BMFMapViewHandle.h
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/11.
//

#import <Flutter/Flutter.h>

@class BMFMapView;

NS_ASSUME_NONNULL_BEGIN

@protocol BMFMapViewHandler <NSObject>

@required

/// mapView (弱引用)
@property(nonatomic, weak) BMFMapView *_mapView;

/// 创建协议实例
- (NSObject <BMFMapViewHandler> *)initWith:(BMFMapView *)mapView;

/// flutter --> ios
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
