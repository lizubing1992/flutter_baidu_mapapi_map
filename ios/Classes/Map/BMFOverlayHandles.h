//
//  BMFOverlayHandles.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/2/12.
//

#import "BMFMapViewHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMFOverlayHandles : NSObject
/// BMFOverlayHandler管理中心
+ (instancetype)defalutCenter;

- (NSDictionary<NSString *, NSString *> *)overlayHandles;
@end


#pragma mark - overlay

@interface BMFAddPolyline : NSObject<BMFMapViewHandler>

@end

@interface BMFAddArcline : NSObject<BMFMapViewHandler>

@end

@interface BMFAddPolygon : NSObject<BMFMapViewHandler>

@end

@interface BMFAddCircle : NSObject<BMFMapViewHandler>

@end

@interface BMFAddTile : NSObject<BMFMapViewHandler>

@end

@interface BMFAddGround : NSObject<BMFMapViewHandler>

@end

@interface BMFRemoveOverlay : NSObject<BMFMapViewHandler>

@end

@interface BMFRemoveTileOverlay : NSObject<BMFMapViewHandler>

@end

@interface BMFUpdatePolyline : NSObject<BMFMapViewHandler>

@end

@interface BMFUpdateArcline : NSObject<BMFMapViewHandler>

@end

@interface BMFUpdateCircle : NSObject<BMFMapViewHandler>

@end

@interface BMFUpdatePolygon : NSObject<BMFMapViewHandler>

@end

NS_ASSUME_NONNULL_END
