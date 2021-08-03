//
//  BMFPolylineModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/11.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
//@class BMFPolylineViewOptions;

NS_ASSUME_NONNULL_BEGIN

@interface BMFPolylineModel : BMFModel

/// flutter层polylinr的唯一id(用于区别哪个polyline)
@property (nonatomic, copy) NSString *Id;

/// 经纬度数组
@property (nonatomic, strong) NSArray<BMFCoordinate *> *coordinates;

/// indexs
@property (nonatomic, strong) NSArray<NSNumber *> *indexs;

/// 是否抽希
@property (nonatomic, assign) BOOL isThined;


///// polylineView属性model
//@property (nonatomic, strong) BMFPolylineViewOptions *polylineOptions;


/// 颜色数组16进制
@property (nonatomic, strong) NSArray<NSString *> *colors;

/// 图片路径数组
@property (nonatomic, strong) NSArray<NSString *> *textures;

/// 线宽
@property (nonatomic, assign) int width;

/// 虚线类型
@property (nonatomic, assign) int lineDashType;

/// line头尾处理方式(不支持虚线)
@property (nonatomic, assign) int lineCapType;

/// line拐角处理方式（不支持虚线）
@property (nonatomic, assign) int lineJoinType;

@end

NS_ASSUME_NONNULL_END
