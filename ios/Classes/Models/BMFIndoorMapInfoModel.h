//
//  BMFIndoorMapInfoModel.h
//  flutter_baidu_mapapi_map
//
//  Created by zhangbaojin on 2020/2/28.
//

#import <flutter_baidu_mapapi_base/BMFModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMFIndoorMapInfoModel : BMFModel

/// 室内ID
@property (nonatomic, strong) NSString* strID;
/// 当前楼层
@property (nonatomic, strong) NSString* strFloor;
/// 所有楼层信息
@property (nonatomic, strong) NSMutableArray<NSString *>* listStrFloors;

@end

NS_ASSUME_NONNULL_END
