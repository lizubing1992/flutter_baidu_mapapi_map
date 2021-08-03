//
//  BMFOverlayViewManager.m
//  flutter_baidu_mapapi_map
//
//  Created by Zhang,Baojin on 2020/11/12.
//

#import "BMFOverlayViewManager.h"

#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import <flutter_baidu_mapapi_base/UIColor+BMFString.h>
//#import <flutter_baidu_mapapi_base/NSObject+BMFThread.h>

#import "BMFFileManager.h"
#import "BMFPolyline.h"
#import "BMFArcline.h"
#import "BMFCircle.h"
#import "BMFPolygon.h"

@implementation BMFOverlayViewManager

+ (BMFPolylineModel *)polylineModelWith:(BMKPolylineView *)view {
    return view.polyline.polylineModel;
}

+ (BMKPolylineView *)viewForPolyline:(BMKPolyline *)polyline {
    BMFPolylineModel *model = polyline.polylineModel;
    BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithPolyline:polyline];
    polylineView.lineWidth = model.width;
    polylineView.lineDashType = model.lineDashType;
    polylineView.lineCapType = model.lineCapType;
    polylineView.lineJoinType = model.lineJoinType;
    
    switch (polyline.lineType) {
        case kBMFDashLine:
        case kBMFColorLine:{
            if ([model.colors firstObject]) {
                polylineView.strokeColor = [UIColor fromColorString:[model.colors firstObject]];
            } else {
                // TODO:strokeColor 默认值
            }
            break;
        }
        case kBMFMultiDashLine:
        case kBMFColorsLine:{
            size_t colorsCount = model.colors.count;
            NSMutableArray<UIColor *> *colors = [NSMutableArray array];
            for (size_t i = 0; i < colorsCount; i++) {
                // TODO:colors加入空值判断
                [colors addObject:[UIColor fromColorString:model.colors[i]]];
            }
            polylineView.colors = colors;
            break;
        }
        case kBMFTextureLine:{
            // TODO:iamge加入空值判断
            NSString *imagePath = [[BMFFileManager defaultCenter] pathForFlutterImageName:[model.textures firstObject]];
            [polylineView loadStrokeTextureImage:[UIImage imageWithContentsOfFile:imagePath]];
            break;
        }
        case kBMFTexturesLine:{
            NSMutableArray<UIImage *> *images = [NSMutableArray array];
            size_t imagesCount = model.textures.count;
            NSString *imagePath = nil;
            for (size_t i = 0; i < imagesCount; i++) {
                //TODO:image加入空值判断
                imagePath = model.textures[i];
                UIImage *image = [UIImage imageWithContentsOfFile:[[BMFFileManager defaultCenter] pathForFlutterImageName:imagePath]];
                [images addObject:image];
            }
            [polylineView loadStrokeTextureImages:images];
            break;
        }
        default:
            break;
    }
    
    return polylineView;
}

+ (BMKArclineView *)viewForArcline:(BMKArcline *)arcline {
    BMFArclineModel *model = arcline.arclineModel;
    BMKArclineView *arclineView = [[BMKArclineView alloc] initWithArcline:arcline];
    if (model.color) {
        arclineView.strokeColor = [UIColor fromColorString:model.color];
    } else {
        arclineView.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    arclineView.lineWidth = model.width;
    arclineView.lineDashType = model.lineDashType;
    return arclineView;
}

+ (BMKPolygonView *)viewForPolygon:(BMKPolygon *)polygon {
    BMFPolygonModel *model = polygon.polygonModel;
    BMKPolygonView *polygonView = [[BMKPolygonView alloc] initWithPolygon:polygon];
    if (model.strokeColor) {
        polygonView.strokeColor = [UIColor fromColorString:model.strokeColor];
    } else {
        polygonView.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    if (model.fillColor) {
        polygonView.fillColor = [UIColor fromColorString:model.fillColor];
    }
    polygonView.lineWidth = model.width;
    polygonView.lineDashType = model.lineDashType;
    return polygonView;
}

+ (BMKCircleView *)viewForCircleline:(BMKCircle *)circle {
    BMFCircleModel *model = circle.circleModel;
    BMKCircleView *circleView = [[BMKCircleView alloc] initWithCircle:circle];
    if (model.strokeColor) {
        circleView.strokeColor = [UIColor fromColorString:model.strokeColor];
    } else {
        circleView.strokeColor = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:1.f];
    }
    if (model.fillColor) {
        circleView.fillColor = [UIColor fromColorString:model.fillColor];
    }
    circleView.lineWidth = model.width;
    circleView.lineDashType = model.lineDashType;
    return circleView;
}

+ (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        return [BMFOverlayViewManager viewForPolyline:(BMKPolyline *)overlay];
        
    } else if ([overlay isKindOfClass:[BMKArcline class]]) {
        return [BMFOverlayViewManager viewForArcline:(BMKArcline *)overlay];
        
    } else if ([overlay isKindOfClass:[BMKPolygon class]]){
        return [BMFOverlayViewManager viewForPolygon:(BMKPolygon *)overlay];
        
    } else if ([overlay isKindOfClass:[BMKCircle class]]) {
        return [BMFOverlayViewManager viewForCircleline:(BMKCircle *)overlay];
        
    } else if ([overlay isKindOfClass:[BMKTileLayer class]]){
        return [[BMKTileLayerView alloc] initWithTileLayer:overlay];
        
    } else if ([overlay isKindOfClass:[BMKGroundOverlay class]]) {
        return [[BMKGroundOverlayView alloc] initWithGroundOverlay:overlay];
    }
    
    return nil;
}

@end
