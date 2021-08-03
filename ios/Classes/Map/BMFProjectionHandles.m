//
//  BMFProjectionHandles.m
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/4/1.
//

#import "BMFProjectionHandles.h"
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

#import "BMFProjectionConst.h"
#import "BMFMapView.h"

@interface BMFProjectionHandles ()
{
    NSDictionary *_handles;
}
@end

@implementation BMFProjectionHandles
static BMFProjectionHandles *_instance = nil;
+ (instancetype)defalutCenter{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[BMFProjectionHandles alloc] init];
        });
    }
    return _instance;
}

- (NSDictionary<NSString *, NSString *> *)projectionHandles{
    if (!_handles) {
        _handles = @{
            kBMFCoordinateFromScreenPointMethod: NSStringFromClass([BMFCoordinateFromBMFPoint class]),
            kBMFScreenPointFromCoordinateMethod: NSStringFromClass([BMFPointFromBMFCoordinate class]),
        };
    }
    return _handles;
}
@end

#pragma mark - convert
@implementation BMFCoordinateFromBMFPoint

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || call.arguments[@"point"]) {
        result([NSNull null]);
        return;
    }
    BMFMapPoint *point = [BMFMapPoint bmf_modelWith:[call.arguments safeObjectForKey:@"point"]];
    CLLocationCoordinate2D coord = [_mapView convertPoint:[point toCGPoint] toCoordinateFromView:_mapView];
    BMFCoordinate *coordinate = [BMFCoordinate fromCLLocationCoordinate2D:coord];
    result(@{@"coordinate" : [coordinate bmf_toDictionary]});
}

@end


@implementation BMFPointFromBMFCoordinate

@synthesize _mapView;

- (nonnull NSObject<BMFMapViewHandler> *)initWith:(nonnull BMFMapView *)mapView {
    _mapView = mapView;
    return self;
}

- (void)handleMethodCall:(nonnull FlutterMethodCall *)call result:(nonnull FlutterResult)result {
    if (!call.arguments || call.arguments[@"coordinate"]) {
        result([NSNull null]);
        return;
    }
    BMFCoordinate *coord = [BMFCoordinate bmf_modelWith:[call.arguments safeObjectForKey:@"coordinate"]];
    CGPoint p = [_mapView convertCoordinate:[coord toCLLocationCoordinate2D] toPointToView:_mapView];
    BMFMapPoint *point = [BMFMapPoint fromCGPoint:p];
    result(@{@"point" : [point bmf_toDictionary]});
}

@end
