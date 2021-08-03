//
//  BMFArcline.h
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/15.
//

#ifndef __BMFArcline__H__
#define __BMFArcline__H__
#ifdef __OBJC__
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#endif
#endif
#import "BMFArclineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BMKArcline (BMFArcline)

/// arclineView唯一id
@property (nonatomic, copy, readonly) NSString *Id;

/// arclineViewOptions
@property (nonatomic, strong, readonly) BMFArclineModel *arclineModel;

+ (BMKArcline *)arclineWith:(NSDictionary *)dic;



@end

NS_ASSUME_NONNULL_END
