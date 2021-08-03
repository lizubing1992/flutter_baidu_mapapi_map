//
//  BMFHeatMapHandles.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/4/3.
//

#import "BMFMapViewHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMFHeatMapHandles : NSObject
/// BMFHeatMapHandles管理中心
+ (instancetype)defalutCenter;

- (NSDictionary<NSString *, NSString *> *)heatMapHandles;
@end
#pragma mark - heatMap

@interface BMFShowHeatMap : NSObject<BMFMapViewHandler>

@end

@interface BMFAddHeatMap : NSObject<BMFMapViewHandler>

@end

@interface BMFRemoveHeatMap : NSObject<BMFMapViewHandler>

@end

NS_ASSUME_NONNULL_END
