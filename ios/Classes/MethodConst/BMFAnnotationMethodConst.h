
#ifndef __BMFAnnotationMethodConst__H__
#define __BMFAnnotationMethodConst__H__

#import <Foundation/Foundation.h>

/// map添加marker
FOUNDATION_EXPORT NSString *const kBMFMapAddMarkerMethod;
/// map批量添加marker
FOUNDATION_EXPORT NSString *const kBMFMapAddMarkersMethod;
/// map删除marker
FOUNDATION_EXPORT NSString *const kBMFMapRemoveMarkerMethod;
/// map批量删除markers
FOUNDATION_EXPORT NSString *const kBMFMapRemoveMarkersMethod;
/// map清除所有的markers
FOUNDATION_EXPORT NSString *const kBMFMapCleanAllMarkersMethod;

/// map选中marker
FOUNDATION_EXPORT NSString *const kBMFMapSelectMarkerMethod;
/// map取消选中marker
FOUNDATION_EXPORT NSString *const kBMFMapDeselectMarkerMethod;

/// marker添加完成
FOUNDATION_EXPORT NSString *const kBMFMapDidAddMarkerMethod;

/// 更新marker属性
FOUNDATION_EXPORT NSString *const kBMFMapUpdateMarkerMemberMethod;
#endif
