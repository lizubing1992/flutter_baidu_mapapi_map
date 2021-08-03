//
//  BMFAnnotation.m
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/11.
//

#import "BMFAnnotation.h"
#import <objc/runtime.h>
#import <flutter_baidu_mapapi_base/BMFMapModels.h>

static const void *IDKey = &IDKey;
static const void *annotationModelKey = &annotationModelKey;

@implementation BMKPointAnnotation (BMFAnnotation)

- (NSString *)Id {
    return objc_getAssociatedObject(self, IDKey);
}
- (void)setId:(NSString * _Nonnull)Id{
    objc_setAssociatedObject(self, IDKey, Id, OBJC_ASSOCIATION_COPY);
}
- (BMFAnnotationModel *)annotationModel {
    return objc_getAssociatedObject(self, annotationModelKey);
}
-(void)setAnnotationModel:(BMFAnnotationModel * _Nonnull)annotationModel {
    objc_setAssociatedObject(self, annotationModelKey, annotationModel, OBJC_ASSOCIATION_RETAIN);
}

+ (instancetype)annotationWith:(NSDictionary *)dic {
    return [[self alloc] initWith:dic];
}

- (instancetype)initWith:(NSDictionary *)dic {
    if ([super init]) {
        if (dic) {
            BMFAnnotationModel *model = [BMFAnnotationModel bmf_modelWith:dic];
            [self configAnnotation:model];
        }
    }
    return self;
}

- (void)configAnnotation:(BMFAnnotationModel *)model {
    if (model.Id) {
        self.Id = model.Id;
    }
    if (model.title) {
        self.title = model.title;
    }
    if (model.subtitle) {
        self.subtitle = model.subtitle;
    }
    if (model.position) {
        self.coordinate = [model.position toCLLocationCoordinate2D];
    }
    self.isLockedToScreen = model.isLockedToScreen;
    if (model.screenPointToLock) {
        self.screenPointToLock = [model.screenPointToLock toCGPoint];
    }
    self.annotationModel = model;
    
}

@end
