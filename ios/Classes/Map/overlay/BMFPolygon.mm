//
//  BMFPolygon.m
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/2/27.
//

#import "BMFPolygon.h"
#import <objc/runtime.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import "BMFHollowShapeModel.h"

static const void *IDKey = &IDKey;
static const void *polygonModelKey = &polygonModelKey;
@implementation BMKPolygon (BMFPolygon)

+ (BMKPolygon *)polygonWith:(NSDictionary *)dic {
    if (dic) {
        BMFPolygonModel *model = [BMFPolygonModel bmf_modelWith:dic];
        size_t _coordsCount = model.coordinates.count;
        CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[_coordsCount];
        for (size_t i = 0; i < _coordsCount; i++) {
            coords[i] = [model.coordinates[i] toCLLocationCoordinate2D];
        }
        
        BMKPolygon *polygon = [BMKPolygon polygonWithCoordinates:coords count:_coordsCount];
        delete[] coords;
        
        polygon.Id = model.Id;
        polygon.polygonModel = model;
        // 镂空判断
        if (model.hollowShapes && model.hollowShapes.count > 0) { // 有镂空
            polygon.hollowShapes = [BMFHollowShapeModel fromHollowShapes:model.hollowShapes];
        }
        return polygon;
    }
    return nil;
}

- (NSString *)Id {
    return objc_getAssociatedObject(self, IDKey);
}
- (void)setId:(NSString * _Nonnull)Id {
    objc_setAssociatedObject(self, IDKey, Id, OBJC_ASSOCIATION_COPY);
}

- (BMFPolygonModel *)polygonModel {
    return objc_getAssociatedObject(self, polygonModelKey);
}
- (void)setPolygonModel:(BMFPolygonModel * _Nonnull)polygonModel {
    objc_setAssociatedObject(self, polygonModelKey, polygonModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
