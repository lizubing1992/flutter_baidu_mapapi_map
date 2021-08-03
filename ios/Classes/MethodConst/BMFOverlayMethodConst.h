#ifndef __BMFOverlayMethodConst__H__
#define __BMFOverlayMethodConst__H__

#import <Foundation/Foundation.h>

/// map添加polyline
FOUNDATION_EXPORT NSString *const kBMFMapAddPolylineMethod;
/// map添加arcline
FOUNDATION_EXPORT NSString *const kBMFMapAddArcineMethod;
/// map添加polygon
FOUNDATION_EXPORT NSString *const kBMFMapAddPolygonMethod;
/// map添加circle
FOUNDATION_EXPORT NSString *const kBMFMapAddCircleMethod;
/// map添加tile
FOUNDATION_EXPORT NSString *const kBMFMapAddTileMethod;
/// map添加ground
FOUNDATION_EXPORT NSString *const kBMFMapAddGroundMethod;
/// map删除指定id的overlay
FOUNDATION_EXPORT NSString *const kBMFMapRemoveOverlayMethod;
/// map删除指定id的瓦片图(适配android)
FOUNDATION_EXPORT NSString *const kBMFMapRemoveTileMethod;

/// 更新polyline属性
FOUNDATION_EXPORT NSString *const kBMFMapUpdatePolylineMemberMethod;
/// 更新arcline属性
FOUNDATION_EXPORT NSString *const kBMFMapUpdateArclineMemberMethod;
/// 更新circle属性
FOUNDATION_EXPORT NSString *const kBMFMapUpdateCircleMemberMethod;
/// 更新polygon属性
FOUNDATION_EXPORT NSString *const kBMFMapUpdatePolygonMemberMethod;

#endif
