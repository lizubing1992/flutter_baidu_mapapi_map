//
//  BMFArcline.m
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/15.
//

#import "BMFArcline.h"
#import <objc/runtime.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

static const void *IDKey = &IDKey;
static const void *arclineModelKey = &arclineModelKey;

@implementation BMKArcline (BMFArcline)
+ (BMKArcline *)arclineWith:(NSDictionary *)dic {
    if (dic) {
        BMFArclineModel *model = [BMFArclineModel bmf_modelWith:dic];
        int _coordsCount = (int)model.coordinates.count;
        if (_coordsCount < 3) {
            return nil;
        }
        
        CLLocationCoordinate2D *coords = new CLLocationCoordinate2D[_coordsCount];
        for (int i = 0; i < _coordsCount; i++) {
            coords[i] = [model.coordinates[i] toCLLocationCoordinate2D];
        }
        BMKArcline *arcline = [BMKArcline arclineWithCoordinates:coords];
        delete [] coords;
        arcline.Id = model.Id;
        arcline.arclineModel = model;
        return arcline;
    }
    return nil;
}

- (NSString *)Id {
    return objc_getAssociatedObject(self, IDKey);
}
- (void)setId:(NSString * _Nonnull)Id {
    objc_setAssociatedObject(self, IDKey, Id, OBJC_ASSOCIATION_COPY);
}

- (BMFArclineModel *)arclineModel {
    return objc_getAssociatedObject(self, arclineModelKey);
}
- (void)setArclineModel:(BMFArclineModel * _Nonnull)arclineModel {
    objc_setAssociatedObject(self, arclineModelKey, arclineModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
@end
