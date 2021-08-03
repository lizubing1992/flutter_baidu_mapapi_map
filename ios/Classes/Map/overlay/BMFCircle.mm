//
//  BMFCircle.m
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/15.
//

#import "BMFCircle.h"
#import <objc/runtime.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>
#import "BMFHollowShapeModel.h"

static const void *IDKey = &IDKey;
static const void *circleModelKey = &circleModelKey;
@implementation  BMKCircle (BMFCircle)

+ (BMKCircle *)circlelineWith:(NSDictionary *)dic {
    if (dic) {
        BMFCircleModel *model = [BMFCircleModel bmf_modelWith:dic];
        if (model.center) {
            BMKCircle *circle = [BMKCircle circleWithCenterCoordinate:[model.center toCLLocationCoordinate2D] radius:model.radius];
            circle.circleModel = model;
            circle.Id = model.Id;
            // 镂空判断
            if (model.hollowShapes && model.hollowShapes.count > 0) {
                circle.hollowShapes = [BMFHollowShapeModel fromHollowShapes:model.hollowShapes];
            }
            return circle;
        }
        
    }
    return nil;
}

- (NSString *)Id {
    return objc_getAssociatedObject(self, IDKey);
}
- (void)setId:(NSString * _Nonnull)Id {
    objc_setAssociatedObject(self, IDKey, Id, OBJC_ASSOCIATION_COPY);
}
- (BMFCircleModel *)circleModel {
    return objc_getAssociatedObject(self, circleModelKey);
}
- (void)setCircleModel:(BMFCircleModel * _Nonnull)circleModel {
    objc_setAssociatedObject(self, circleModelKey, circleModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
