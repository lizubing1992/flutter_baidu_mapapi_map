//
//  BMFArclineModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/15.
//

//#import "BMFModel.h"
#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
NS_ASSUME_NONNULL_BEGIN

@interface BMFArclineModel : BMFModel

/// flutter层arcline的唯一id(用于区别哪个arcline)
@property (nonatomic, copy) NSString *Id;

/// 指定的经纬度坐标点数组(需传入3个点)
@property (nonatomic, strong)  NSArray<BMFCoordinate *> *coordinates;

///// arclineView属性model
//@property (nonatomic, strong) BMFArclineViewOptions *arclineOptions;

/// 颜色16进制
@property (nonatomic, copy) NSString *color;

/// 线宽
@property (nonatomic, assign) int width;

/// 虚线类型
@property (nonatomic, assign) int lineDashType;

@end
NS_ASSUME_NONNULL_END
