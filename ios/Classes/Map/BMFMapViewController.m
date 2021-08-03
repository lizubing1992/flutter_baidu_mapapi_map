//
//  BMFMapViewController.m
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/6.
//

#import "BMFMapViewController.h"
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/UIColor+BMFString.h>
#import <flutter_baidu_mapapi_base/NSObject+BMFThread.h>
#import <flutter_baidu_mapapi_base/BMFDefine.h>

#import "BMFMapView.h"
#import "BMFMapCallBackConst.h"
#import "BMFMapViewHandles.h"
#import "BMFAnnotationHandles.h"
#import "BMFOverlayHandles.h"
#import "BMFHeatMapHandles.h"
#import "BMFUserLocationHandles.h"
#import "BMFProjectionHandles.h"
#import "BMFMapStatusModel.h"
#import "BMFMapPoiModel.h"
#import "BMFIndoorMapInfoModel.h"

#import "BMFAnnotationViewManager.h"
#import "BMFAnnotationModel.h"

#import "BMFOverlayViewManager.h"
#import "BMFPolylineModel.h"

static NSString *kBMFMapChannelName = @"flutter_bmfmap/map_";
static NSString *kMapMethods = @"flutter_bmfmap/map/";
static NSString *kMarkerMethods = @"flutter_bmfmap/marker/";
static NSString *kOverlayMethods = @"flutter_bmfmap/overlay/";
static NSString *kHeatMapMethods = @"flutter_bmfmap/heatMap/";
static NSString *kUserLocationMethods = @"flutter_bmfmap/userLocation/";
static NSString *kProjectionMethods = @"flutter_bmfmap/projection/";


//#ifdef DEBUG
//#define BMFLog(FORMAT, ...) fprintf(stderr,"time:%s line:%d filename:%s\t\nmethod:%s\n%s\n", __TIME__,__LINE__,[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__func__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
//#else
//#define BMFLog(FORMAT, ...) nil
//#endif

@interface BMFMapViewController()<BMKMapViewDelegate>
{
    FlutterMethodChannel *_channel;
    BMFMapView  *_mapView;
    
}

@end
@implementation BMFMapViewController

- (instancetype)initWithWithFrame:(CGRect)frame
                   viewIdentifier:(int64_t)viewId
                        arguments:(id _Nullable)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if ([super init]) {
        int Id = (int)(viewId);
        NSString *channelName = [NSString stringWithFormat:@"%@%@", kBMFMapChannelName, [NSString stringWithFormat:@"%d", Id]];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        _mapView = [BMFMapView viewWithFrame:frame dic:(NSDictionary*)args];
        _mapView.delegate = self;
        
#pragma mark - flutter -> ios
        __weak __typeof__(_mapView) weakMapView = _mapView;
        [_channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            NSObject<BMFMapViewHandler> *handler;
            // map
            if ([call.method hasPrefix:kMapMethods]) {
                handler = [NSClassFromString([BMFMapViewHandles defalutCenter].mapViewHandles[call.method]) new];
            }
            // marker
            if ([call.method hasPrefix:kMarkerMethods]) {
                handler = [NSClassFromString([BMFAnnotationHandles defalutCenter].annotationHandles[call.method]) new];
            }
            // overlay
            if ([call.method hasPrefix:kOverlayMethods]) {
                handler = [NSClassFromString([BMFOverlayHandles defalutCenter].overlayHandles[call.method]) new];
            }
            // 热力图
            if ([call.method hasPrefix:kHeatMapMethods]) {
                handler = [NSClassFromString([BMFHeatMapHandles defalutCenter].heatMapHandles[call.method]) new];
            }
            // 定位图层
            if ([call.method hasPrefix:kUserLocationMethods]) {
                handler = [NSClassFromString([BMFUserLocationHandles defalutCenter].userLocationHandles[call.method]) new];
            }
            // 数据转换
            if ([call.method hasPrefix:kProjectionMethods]) {
                handler = [NSClassFromString([BMFProjectionHandles defalutCenter].projectionHandles[call.method]) new];
            }
            //            NSLog(@"call.method = %@", call.method);
            
            if (handler) {
                [weakMapView bmf_performBlockOnMainThreadAsync:^{
                    [[handler initWith:weakMapView] handleMethodCall:call result:result];
                }];
            } else {
                
                //                if ([call.method isEqualToString:@"flutter_bmfmap/map/didUpdateWidget"]) {
                ////                    BMFLog(@"native - didUpdateWidget");
                //                    return;
                //                }
                //                if ([call.method isEqualToString:@"flutter_bmfmap/map/reassemble"]) {
                ////                    BMFLog(@"native - reassemble");
                //                     return;
                //                }
                result(FlutterMethodNotImplemented);
            }
        }];
    }
    return self;
}
- (nonnull UIView *)view {
    return _mapView;
}
- (void)dealloc {
    _channel = nil;
    _mapView.delegate = nil;
    _mapView = nil;
    //    BMFLog(@"-BMFMapViewController-dealloc");
}
#pragma mark - ios -> flutter
#pragma mark - BMKMapViewDelegate
/// 地图加载完成
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    if (_mapView) {
        // 对初始时不生效的属性，在此再调用一次.暂时这么解决
        [_mapView updateMapOptions];
    }
    if (!_channel) return;
    [_channel invokeMethod:kBMFMapDidLoadCallback arguments:@{@"success": @YES} result:nil];
}
/// 地图渲染完成
- (void)mapViewDidFinishRendering:(BMKMapView *)mapView {
    if (!_channel) return;
    [_channel invokeMethod:kBMFMapDidRenderCallback arguments:@{@"success": @YES} result:nil];
}

/// 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus*)status {
    if (!_channel) return;
    BMFMapStatusModel *mapStatus = [BMFMapStatusModel fromMapStatus:status];
    [_channel invokeMethod:kBMFMapOnDrawMapFrameCallback
                 arguments:@{@"mapStatus": [mapStatus bmf_toDictionary]}
                    result:nil];
    
}

/// 地图区域即将改变时会调用此接口
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    if (!_channel) return;
    BMFMapStatusModel *mapStatus = [BMFMapStatusModel fromMapStatus:[_mapView getMapStatus]];
    [_channel invokeMethod:kBMFMapRegionWillChangeCallback
                 arguments:@{@"mapStatus": [mapStatus bmf_toDictionary]}
                    result:nil];
}

/// 地图区域即将改变时会调用此接口
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated reason:(BMKRegionChangeReason)reason {
    if (!_channel) return;
    BMFMapStatusModel *mapStatus = [BMFMapStatusModel fromMapStatus:[_mapView getMapStatus]];
    [_channel invokeMethod:kBMFMapRegionWillChangeWithReasonCallback
                 arguments:@{@"mapStatus": [mapStatus bmf_toDictionary], @"reason": @(reason)}
                    result:nil];
}

/// 地图区域改变完成后会调用此接口
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if (!_channel) return;
    BMFMapStatusModel *mapStatus = [BMFMapStatusModel fromMapStatus:[_mapView getMapStatus]];
    [_channel invokeMethod:kBMFMapRegionDidChangeCallback
                 arguments:@{@"mapStatus": [mapStatus bmf_toDictionary]}
                    result:nil];
}

/// 地图区域改变完成后会调用此接口
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated reason:(BMKRegionChangeReason)reason {
    if (!_channel) return;
    BMFMapStatusModel *mapStatus = [BMFMapStatusModel fromMapStatus:[_mapView getMapStatus]];
    [_channel invokeMethod:kBMFMapRegionDidChangeWithReasonCallback
                 arguments:@{@"mapStatus": [mapStatus bmf_toDictionary], @"reason": @(reason)}
                    result:nil];
}
/// 点中底图标注后会回调此接口
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi {
    if (!_channel) return;
    BMFMapPoiModel *model = [BMFMapPoiModel fromBMKMapPoi:mapPoi];
    [_channel invokeMethod:kBMFMapOnClickedMapPoiCallback arguments:@{@"poi": [model bmf_toDictionary]} result:nil];
}
/// 点中底图空白处会回调此接口
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    if (!_channel) return;
    BMFCoordinate *coord = [BMFCoordinate fromCLLocationCoordinate2D:coordinate];
    [_channel invokeMethod:kBMFMapOnClickedMapBlankCallback arguments:@{@"coord": [coord bmf_toDictionary]} result:nil];
}

/// 双击地图时会回调此接口
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    if (!_channel) return;
    BMFCoordinate *coord = [BMFCoordinate fromCLLocationCoordinate2D:coordinate];
    [_channel invokeMethod:kBMFMapOnDoubleClickCallback arguments:@{@"coord": [coord bmf_toDictionary]} result:nil];
}

/// 长按地图时会回调此接口
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate {
    if (!_channel) return;
    BMFCoordinate *coord = [BMFCoordinate fromCLLocationCoordinate2D:coordinate];
    [_channel invokeMethod:kBMFMapOnLongClickCallback arguments:@{@"coord": [coord bmf_toDictionary]} result:nil];
}

/// 3DTouch 按地图时会回调此接口（仅在支持3D Touch，且fouchTouchEnabled属性为YES时，会回调此接口）
/// force 触摸该点的力度(参考UITouch的force属性)
/// maximumPossibleForce 当前输入机制下的最大可能力度(参考UITouch的maximumPossibleForce属性)
- (void)mapview:(BMKMapView *)mapView onForceTouch:(CLLocationCoordinate2D)coordinate force:(CGFloat)force maximumPossibleForce:(CGFloat)maximumPossibleForce {
    if (!_channel) return;
    BMFCoordinate *coord = [BMFCoordinate fromCLLocationCoordinate2D:coordinate];
    [_channel invokeMethod:kBMFMapOnForceTouchCallback arguments:@{@"coord": [coord bmf_toDictionary], @"force": @(force), @"maximumPossibleForce": @(maximumPossibleForce)} result:nil];
}

///地图状态改变完成后会调用此接口
- (void)mapStatusDidChanged:(BMKMapView *)mapView {
    if (!_channel) return;
    [_channel invokeMethod:kBMFMapStatusDidChangedCallback arguments:nil result:nil];
}

- (void)mapview:(BMKMapView *)mapView baseIndoorMapWithIn:(BOOL)flag baseIndoorMapInfo:(BMKBaseIndoorMapInfo *)info{
    if (!_channel) return;
    BMFIndoorMapInfoModel *model = [BMFIndoorMapInfoModel new];
    model.strID = info.strID;
    model.strFloor = info.strFloor;
    model.listStrFloors = info.arrStrFloors;
    [_channel invokeMethod:kBMFMapInOrOutBaseIndoorMapCallback arguments:@{@"flag": @(flag), @"info": [model bmf_toDictionary]} result:nil];
}
#pragma mark - annotationView
/// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    return [BMFAnnotationViewManager mapView:mapView viewForAnnotation:annotation];
}

/// 当mapView新添加annotation views时，调用此接口
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    if (!_channel) return;
}

/// 每次点击BMKAnnotationView都会回调此接口。
- (void)mapView:(BMKMapView *)mapView clickAnnotationView:(BMKAnnotationView *)view {
    if (!_channel) return;
    if ([view isKindOfClass:NSClassFromString(@"BMKUserLocationView")]) {
        return;
    }
    // 回调marker数据model
    BMFAnnotationModel *model = [BMFAnnotationViewManager annotationModelfromAnnotionView:view];
    [_channel invokeMethod:kBMFMapClickedMarkerCallback arguments:@{@"marker": [model bmf_toDictionary]} result:nil];
}
/// 当选中一个annotation views时，调用此接口
/// @param mapView 地图View
/// @param view 选中的annotation views
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    if (!_channel) return;
    if ([view isKindOfClass:NSClassFromString(@"BMKUserLocationView")]) {
        return;
    }
    // 回调marker数据model
    BMFAnnotationModel *model = [BMFAnnotationViewManager annotationModelfromAnnotionView:view];
    model.selected = view.selected;
    [_channel invokeMethod:kBMFMapDidSelectMarkerCallback arguments:@{@"marker": [model bmf_toDictionary]} result:nil];
}

/// 当取消选中一个annotationView时，调用此接口
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view {
    if (!_channel) return;
    if ([view isKindOfClass:NSClassFromString(@"BMKUserLocationView")]) {
        return;
    }
    // 回调marker数据model
    BMFAnnotationModel *model = [BMFAnnotationViewManager annotationModelfromAnnotionView:view];
    model.selected = view.selected;
    [_channel invokeMethod:kBMFMapDidDeselectMarkerCallback arguments:@{@"marker": [model bmf_toDictionary]} result:nil];
}

/// 拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState {
    if (!_channel) return;
    // 回调marker数据model
    BMFAnnotationModel *model = [BMFAnnotationViewManager annotationModelfromAnnotionView:view];
    model.position = [BMFCoordinate fromCLLocationCoordinate2D:view.annotation.coordinate];
    [_channel invokeMethod:kBMFMapDidDragMarkerCallback
                 arguments:@{@"marker" : [model bmf_toDictionary],
                             @"newState" : @(newState),
                             @"oldState" : @(oldState)
                 }
                    result:nil];
    
}

/// 当点击annotationView的泡泡view时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
    if (!_channel) return;
    // 回调marker数据model
    BMFAnnotationModel *model = [BMFAnnotationViewManager annotationModelfromAnnotionView:view];
    [_channel invokeMethod:kBMFMapDidClickedPaoPaoCallback arguments:@{@"marker": [model bmf_toDictionary]} result:nil];
}
#pragma mark - overlayView

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
    return [BMFOverlayViewManager mapView:mapView viewForOverlay:overlay];
}
/**
 *当mapView新添加overlay views时，调用此接口
 *@param mapView 地图View
 *@param overlayViews 新添加的overlay views
 */
- (void)mapView:(BMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews {
    if (!_channel) return;
    
    //TODO:didAddOverlayViews
}
/**
 *点中覆盖物后会回调此接口，目前只支持点中BMKPolylineView时回调
 *@param mapView 地图View
 *@param overlayView 覆盖物view信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedBMKOverlayView:(BMKOverlayView *)overlayView {
    if (!_channel) return;
    
    if ([overlayView isKindOfClass:[BMKPolylineView class]]) {
        BMFPolylineModel *model = [BMFOverlayViewManager polylineModelWith:(BMKPolylineView *)overlayView];
        //        NSLog(@"%@", [model bmf_toDictionary]);
        // 传整个polylineModel对象
        [_channel invokeMethod:kMapOnClickedOverlayCallback arguments:@{@"polyline": [model bmf_toDictionary]} result:nil];
    }
}
@end

@interface FlutterMapViewFactory()
{
    NSObject<FlutterBinaryMessenger> *_messenger;
}
@end
@implementation FlutterMapViewFactory
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager {
    if ([super init]) {
        _messenger = messager;
    }
    return self;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args {
    BMFMapViewController *mapViewController = [[BMFMapViewController alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    return mapViewController;
}


@end
