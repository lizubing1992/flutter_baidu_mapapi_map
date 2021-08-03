//
//  BMFHeatMapModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/3/26.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFGradient;
@class BMFHeatMapModelNode;
@class BMFCoordinate;
@class BMKHeatMap;
@class BMKGradient;
@class BMKHeatMapNode;
NS_ASSUME_NONNULL_BEGIN

@interface BMFHeatMapModel : BMFModel

///设置热力图点半径，默认为12ps
@property (nonatomic, assign) int radius;

///设置热力图渐变，有默认值 DEFAULT_GRADIENT
@property (nonatomic, strong) BMFGradient *gradient;

///设置热力图层透明度，默认 0.6
@property (nonatomic, assign) double opacity;

///用户传入的热力图数据,数组,成员类型为BMFHeatMapModelNode
@property (nonatomic, strong) NSMutableArray<BMFHeatMapModelNode *> *data;

- (BMKHeatMap *)toBMKHeatMap;

@end

@interface BMFGradient : BMFModel

///渐变色用到的所有颜色数组,数组成员类型为UIColor
@property (nonatomic, strong) NSArray<NSString *> *colors;

///每一个颜色的起始点数组,,数组成员类型为 [0,1]的double值, given as a percentage of the maximum intensity,个数和mColors的个数必须相同，数组内元素必须时递增的
@property (nonatomic, strong) NSArray <NSNumber *> *startPoints;

- (BMKGradient *)toBMKGradient;

@end

@interface BMFHeatMapModelNode : BMFModel

/// 点的强度权值
@property (nonatomic, assign) double intensity;

/// 点的位置坐标
@property (nonatomic, strong) BMFCoordinate *pt;

- (BMKHeatMapNode *)toBMKHeatMapNode;

@end
NS_ASSUME_NONNULL_END
