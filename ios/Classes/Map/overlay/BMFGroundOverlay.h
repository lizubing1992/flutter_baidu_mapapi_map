//
//  BMFGroundOverlay.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/3/22.
//

#ifndef __BMFGroundOverlay__H__
#define __BMFGroundOverlay__H__
#ifdef __OBJC__
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#endif
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BMKGroundOverlay (BMFGroundOverlay)

/// 唯一id
@property (nonatomic, copy, readonly) NSString *Id;

+ (BMKGroundOverlay *)groundOverlayWith:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
