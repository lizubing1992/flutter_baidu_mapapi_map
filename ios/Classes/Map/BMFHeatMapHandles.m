//
//  BMFHeatMapHandles.m
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/4/3.
//

#import <flutter_baidu_mapapi_base/NSObject+BMFVerify.h>
#import "BMFHeatMapHandles.h"
#import "BMFMapView.h"
#import "BMFHeatMapConst.h"
#import "BMFHeatMapModel.h"
@interface BMFHeatMapHandles ()
{
    NSDictionary *_handles;
}
@end

@implementation BMFHeatMapHandles
static BMFHeatMapHandles *_instance = nil;
+ (instancetype)defalutCenter{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[BMFHeatMapHandles alloc] init];
        });
    }
    return _instance;
}

- (NSDictionary<NSString *, NSString *> *)heatMapHandles{
    if (!_handles) {
        _handles = @{
            kBMFMapShowHeatMapMethod: NSStringFromClass([BMFShowHeatMap class]),
            kBMFMapAddHeatMapMethod: NSStringFromClass([BMFAddHeatMap class]),
            kBMFMapRemoveHeatMapMethod: NSStringFromClass([BMFRemoveHeatMap class]),
        };
    }
    return _handles;
}
@end

#pragma mark - heatMap

@implementation BMFShowHeatMap

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"show"]) {
        result(@NO);
        return;
    }
    _mapView.baiduHeatMapEnabled = [[call.arguments safeObjectForKey:@"show"] boolValue];
    result(@YES);
}

@end

@implementation BMFAddHeatMap

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || !call.arguments[@"heatMap"]) {
        result(@NO);
        return;
    }
    BMFHeatMapModel *heatMap = [BMFHeatMapModel bmf_modelWith:[call.arguments safeObjectForKey:@"heatMap"]];
    [_mapView addHeatMap:[heatMap toBMKHeatMap]];
    result(@YES);
}

@end

@implementation BMFRemoveHeatMap

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    [_mapView removeHeatMap];
    result(@YES);
}

@end
