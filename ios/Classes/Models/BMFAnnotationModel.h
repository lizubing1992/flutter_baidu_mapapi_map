//
//  BMFAnnotationModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/11.
//

//#import "BMFModel.h"
#import <flutter_baidu_mapapi_base/BMFModel.h>
@class BMFCoordinate;
@class BMFMapPoint;
//@class BMFAnnotationViewOptions;
NS_ASSUME_NONNULL_BEGIN

@interface BMFAnnotationModel : BMFModel

/// flutter层mark的唯一id(用于区别哪个marker)
@property (nonatomic, copy) NSString *Id;

/// 标题
@property (nonatomic, copy) NSString *title;

/// 子标题
@property (nonatomic, copy) NSString *subtitle;

/// annotation中心坐标.
@property (nonatomic, strong) BMFCoordinate *position;

/// 标注固定在指定屏幕位置,  必须与screenPointToLock一起使用。 注意：拖动Annotation isLockedToScreen会被设置为false。
/// 若isLockedToScreen为true，拖动地图时annotaion不会跟随移动；
/// 若isLockedToScreen为false，拖动地图时annotation会跟随移动。
@property (nonatomic, assign) BOOL isLockedToScreen;

/// 标注锁定在屏幕上的位置，注意：地图初始化后才能设置screenPointToLock。
/// 可以在地图加载完成的回调方法：mapViewDidFinishLoading中使用此属性。
@property (nonatomic, strong)BMFMapPoint *screenPointToLock;

/// annotationView的参数集合
//@property (nonatomic, strong) BMFAnnotationViewOptions *annotationViewOptions;


/// annotationView复用标识符
@property (nonatomic, copy) NSString *identifier;

/// 图片路径
@property (nonatomic, copy) NSString *icon;

/// 默认情况下, annotation
/// view的中心位于annotation的坐标位置，可以设置centerOffset改变view的位置，
/// 正的偏移使view朝右下方移动，负的朝左上方，单位是像素
@property (nonatomic, strong) BMFMapPoint *centerOffset;

/// 默认情况下,标注没有3D效果，可以设置enabled3D改变使用3D效果，使得标注在地图旋转和俯视时跟随旋转、俯视
@property (nonatomic, assign) BOOL enabled3D;

/// 默认为YES,当为NO时view忽略触摸事件
@property (nonatomic, assign) BOOL enabled;

/// 当设为YES并实现了setCoordinate:方法时，支持将view在地图上拖动, iOS 3.2以后支持
@property (nonatomic, assign) BOOL draggable;

/// 默认为NO,当为YES时为会弹出气泡
@property (nonatomic, assign) BOOL selected;

/// 当为YES时，view被选中时会弹出气泡，annotation必须实现了title这个方法
@property (nonatomic, assign) BOOL canShowCallout;


///当发生单击地图事件时，当前的annotation的泡泡是否隐藏，默认值为YES
@property (nonatomic, assign) BOOL hidePaopaoWhenSingleTapOnMap;
///当发生双击地图事件时，当前的annotation的泡泡是否隐藏，默认值为NO
@property (nonatomic, assign) BOOL hidePaopaoWhenDoubleTapOnMap;
///当发生两个手指点击地图（缩小地图）事件时，当前的annotation的泡泡是否隐藏，默认值为NO
@property (nonatomic, assign) BOOL hidePaopaoWhenTwoFingersTapOnMap;
///当选中其他annotation时，当前annotation的泡泡是否隐藏，默认值为YES
@property (nonatomic, assign) BOOL hidePaopaoWhenSelectOthers;
///当拖拽当前的annotation时，当前annotation的泡泡是否隐藏，默认值为NO
@property (nonatomic, assign) BOOL hidePaopaoWhenDrag;
///当拖拽其他annotation时，当前annotation的泡泡是否隐藏，默认值为NO
@property (nonatomic, assign) BOOL hidePaopaoWhenDragOthers;

/// marker展示优先级
@property (nonatomic, assign) int displayPriority;

@end


//@interface BMFAnnotationViewOptions :  BMFModel
//
///// annotationView复用标识符
//@property (nonatomic, copy) NSString *identifier;
//
///// 图片路径
//@property (nonatomic, copy) NSString *icon;
//
///// 默认情况下, annotation
///// view的中心位于annotation的坐标位置，可以设置centerOffset改变view的位置，
///// 正的偏移使view朝右下方移动，负的朝左上方，单位是像素
//@property (nonatomic, strong) BMFMapPoint *centerOffset;
//
///// 默认情况下,标注没有3D效果，可以设置enabled3D改变使用3D效果，使得标注在地图旋转和俯视时跟随旋转、俯视
//@property (nonatomic, assign) BOOL enabled3D;
//
///// 默认为YES,当为NO时view忽略触摸事件
//@property (nonatomic, assign) BOOL enabled;
//
///// 当设为YES并实现了setCoordinate:方法时，支持将view在地图上拖动, iOS 3.2以后支持
//@property (nonatomic, assign) BOOL draggable;
//
///// 默认为NO,当为YES时为会弹出气泡
//@property (nonatomic, assign) BOOL selected;
//
//@end
NS_ASSUME_NONNULL_END
