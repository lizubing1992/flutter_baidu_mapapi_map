//
//  BMFPolyline.m
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/12.
//

#import "BMFPolyline.h"
#import <objc/runtime.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

static const void *IDKey = &IDKey;
static const void *lineTypeKey = &lineTypeKey;
static const void *polylineModelKey = &polylineModelKey;

@implementation BMKPolyline (BMFPolyline)

+ (BMKPolyline *)polylineWith:(NSDictionary *)dic {
    if (dic) {
        BMFPolylineModel *model = [BMFPolylineModel bmf_modelWith:dic];
        size_t _coordsCount = model.coordinates.count;
        size_t _indexsCount = model.indexs.count;
        
        if (_coordsCount > 0) {
            CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[_coordsCount];
            
            for (size_t i = 0; i < _coordsCount; i++) {
                coords[i] = [model.coordinates[i] toCLLocationCoordinate2D];
            }
            
            if (_indexsCount > 0) { //多
                BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:coords count:_coordsCount textureIndex:model.indexs];
                if (model.lineDashType == 0) {
                    polyline.lineType = [model.textures count] > 0 ? kBMFTexturesLine :  kBMFColorsLine;
                } else {
                    polyline.lineType = kBMFMultiDashLine;
                }
                polyline.Id = model.Id;
                polyline.isThined = model.isThined;
                polyline.polylineModel = model;
                return polyline;
            } else { //单
                BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:coords count:_coordsCount];
                if (model.lineDashType == 0) {
                    polyline.lineType = [model.textures count] > 0 ? kBMFTextureLine : kBMFColorLine;
                } else {
                    polyline.lineType = kBMFDashLine;
                }
                polyline.Id = model.Id;
                polyline.isThined = model.isThined;
                polyline.polylineModel = model;
                return polyline;
            }
            
        }
    }
    return nil;
}

/// BMKPolyline
+ (BMKPolyline *)polylineWithModel:(BMFPolylineModel *)model {
    if (model) {
        size_t _coordsCount = model.coordinates.count;
        size_t _indexsCount = model.indexs.count;
        
        if (_coordsCount > 0) {
            CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[_coordsCount];
            
            for (size_t i = 0; i < _coordsCount; i++) {
                coords[i] = [model.coordinates[i] toCLLocationCoordinate2D];
            }
            
            if (_indexsCount > 0) { //多
                BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:coords count:_coordsCount textureIndex:model.indexs];
                delete [] coords;
                
                if (model.lineDashType == 0) {
                    polyline.lineType = [model.textures count] > 0 ? kBMFTexturesLine :  kBMFColorsLine;
                } else {
                    polyline.lineType = kBMFMultiDashLine;
                }
                polyline.Id = model.Id;
                polyline.isThined = model.isThined;
                polyline.polylineModel = model;
                return polyline;
            } else { //单
                BMKPolyline *polyline = [BMKPolyline polylineWithCoordinates:coords count:_coordsCount];
                delete [] coords;
                if (model.lineDashType == 0) {
                    polyline.lineType = [model.textures count] > 0 ? kBMFTextureLine : kBMFColorLine;
                } else {
                    polyline.lineType = kBMFDashLine;
                }
                polyline.Id = model.Id;
                polyline.isThined = model.isThined;
                polyline.polylineModel = model;
                return polyline;
            }
            
        }
    }
    return nil;
}
- (NSString *)Id {
    return objc_getAssociatedObject(self, IDKey);
}
- (void)setId:(NSString * _Nonnull)Id{
    objc_setAssociatedObject(self, IDKey, Id, OBJC_ASSOCIATION_COPY);
}

- (NSUInteger)lineType {
    NSNumber *value = objc_getAssociatedObject(self, lineTypeKey);
    return [value unsignedIntegerValue];
}

- (void)setLineType:(BMFLineType)lineType {
    objc_setAssociatedObject(self, lineTypeKey, @(lineType), OBJC_ASSOCIATION_ASSIGN);
}

- (BMFPolylineModel *)polylineModel {
    return objc_getAssociatedObject(self, polylineModelKey);
}

- (void)setPolylineModel:(BMFPolylineModel * _Nonnull)polylineModel {
    objc_setAssociatedObject(self, polylineModelKey, polylineModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
