//
//  BMFAnnotationHandles.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/2/11.
//

#import "BMFMapViewHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMFAnnotationHandles : NSObject
/// BMFAnnotationHandler管理中心
+ (instancetype)defalutCenter;

- (NSDictionary<NSString *, NSString *> *)annotationHandles;
@end
#pragma mark - marker

@interface BMFAddAnnotation : NSObject<BMFMapViewHandler>

@end

@interface BMFAddAnnotations : NSObject<BMFMapViewHandler>

@end

@interface BMFRemoveAnnotation : NSObject<BMFMapViewHandler>

@end

@interface BMFRemoveAnnotations : NSObject<BMFMapViewHandler>

@end

@interface BMFCleanAllAnnotations : NSObject<BMFMapViewHandler>

@end

@interface BMFSelectAnnotation : NSObject<BMFMapViewHandler>

@end

@interface BMFDeselectAnnotation : NSObject<BMFMapViewHandler>

@end

@interface BMFUpdateAnnotation : NSObject<BMFMapViewHandler>

@end

NS_ASSUME_NONNULL_END
