//
//  BMFCircleModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/15.
//

//#import "BMFModel.h"
#import <flutter_baidu_mapapi_base/BMFModel.h>


@class BMFCoordinate;
@class BMFHollowShapeModel;
NS_ASSUME_NONNULL_BEGIN

@interface BMFCircleModel : BMFModel

/// flutter层circle的唯一id(用于区别哪个circle)
@property (nonatomic, copy) NSString *Id;

/// 半径，单位：米
@property (nonatomic, assign) double radius;

/// 中心点坐标
@property (nonatomic, strong) BMFCoordinate *center;

/// 镂空数组
@property (nonatomic, strong) NSArray<BMFHollowShapeModel *> *hollowShapes;

///// circleView属性model
//@property (nonatomic,strong) BMFCircleViewOptions *circleOptions;

/// 线宽
@property (nonatomic, assign) int width;

/// 颜色16进制strokeColor
@property (nonatomic, copy) NSString *strokeColor;

/// 颜色16进制fillColor
@property (nonatomic, copy) NSString *fillColor;

/// 虚线类型
@property (nonatomic, assign) int lineDashType;

@end

NS_ASSUME_NONNULL_END
