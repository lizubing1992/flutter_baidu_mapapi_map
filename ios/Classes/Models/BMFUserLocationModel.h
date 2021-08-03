//
//  BMFUserLocationModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/3/01.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

@class BMFCoordinate;
@class BMFLocationModel;
@class BMFHeadingModel;
@class BMKUserLocation;
@class CLHeading;
@class CLLocation;
@class BMKLocationViewDisplayParam;

NS_ASSUME_NONNULL_BEGIN

@interface BMFUserLocationModel : BMFModel

/// 位置更新状态，如果正在更新位置信息，则该值为YES
@property (nonatomic, assign) BOOL updating;

/// 位置信息，尚未定位成功，则该值为nil
@property (nonatomic, strong) BMFLocationModel *location;

/// heading信息，尚未定位成功，则该值为nil
@property (nonatomic, strong) BMFHeadingModel *heading;

/// 定位标注点要显示的标题信息
@property (nonatomic, copy) NSString *title;

/// 定位标注点要显示的子标题信息
@property (nonatomic, copy) NSString *subtitle;

- (BMKUserLocation *)toBMKUserLocation;

@end

@interface BMFLocationModel : BMFModel

/// 经纬度
@property(nonatomic, strong) BMFCoordinate *coordinate;

/// 海拔
@property(nonatomic, assign) double altitude;

/// 水平精确度
@property(nonatomic, assign) double horizontalAccuracy;

/// 垂直精确度
@property(nonatomic, assign) double verticalAccuracy;

/// 航向
@property(nonatomic, assign) double course;

/// 速度
@property(nonatomic, assign) double speed;

/// 时间
@property (nonatomic, copy) NSString *timestamp;

- (CLLocation *)toCLLocation;

@end

@interface BMFHeadingModel : BMFModel

/// 磁头
/// 表示度方向，其中0度为磁北。无论设备的方向以及用户界面的方向如何，方向都是从设备的顶部引用的。
/// 范围: 0.0 - 359.9度，0度为地磁北极
@property (nonatomic, assign) double magneticHeading;

/// 表示角度方向，其中0度为真北。参考方向
/// 不考虑设备的方向以及设备的方向
/// 范围: 0.0 - 359.9度，0为正北
@property (nonatomic, assign) double trueHeading;

/// 航向精度
/// 表示磁头可能与实际地磁头偏差的最大度数。负值表示无效的标题。
@property (nonatomic, assign) double headingAccuracy;

/// x轴测量的地磁的原始值
@property (nonatomic, assign) double x;

/// y轴测量的地磁的原始值
@property (nonatomic, assign) double y;

/// z轴测量的地磁的原始值
@property (nonatomic, assign) double z;

/// 时间戳
@property (nonatomic, copy) NSString *timestamp;

- (CLHeading *)toCLHeading;

@end


@interface BMFLocationViewDisplayParam : BMFModel

/// 定位图标X轴偏移量(屏幕坐标)
@property (nonatomic, assign) CGFloat locationViewOffsetX;

/// 定位图标Y轴偏移量(屏幕坐标)
@property (nonatomic, assign) CGFloat locationViewOffsetY;

/// 精度圈是否显示，默认YES
@property (nonatomic, assign) BOOL isAccuracyCircleShow;

/// 精度圈 填充颜色
@property (nonatomic, copy) NSString *accuracyCircleFillColor;

/// 精度圈 边框颜色
@property (nonatomic, copy) NSString *accuracyCircleStrokeColor;

/// 跟随态旋转角度是否生效，默认YES
@property (nonatomic, assign) BOOL isRotateAngleValid;

///// 定位图标名称，需要将该图片放到 mapapi.bundle/images 目录下
//@property (nonatomic, strong) NSString *locationViewImgName;

/// 用户自定义定位图标，V4.2.1以后支持
@property (nonatomic, copy) NSString *locationViewImage;

/// 是否显示气泡，默认YES
@property (nonatomic, assign) BOOL canShowCallOut;

/// locationView在mapview上的层级 默认值为LOCATION_VIEW_HIERARCHY_BOTTOM
@property (nonatomic, assign) int locationViewHierarchy;

- (BMKLocationViewDisplayParam *)toBMKLocationViewDisplayParam;

@end

NS_ASSUME_NONNULL_END
