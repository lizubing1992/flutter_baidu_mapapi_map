//
//  BMFFileManager.m
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/12.
//

#import "BMFFileManager.h"

@implementation BMFFileManager

static BMFFileManager *_instance = nil;
+ (instancetype)defaultCenter{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[BMFFileManager alloc] init];
        });
    }
    return _instance;
}
/// 获取flutter端图片资源路径
- (NSString *)pathForFlutterImageName:(NSString *)imageName{
    if (!_registar) return nil;
    return [[NSBundle mainBundle] pathForResource:[_registar lookupKeyForAsset:imageName] ofType:nil];
}
/// 获取flutter端文件资源路径
- (NSString *)pathForFlutterFileName:(NSString *)fileName{
    if (!_registar) return nil;
    return [[NSBundle mainBundle] pathForResource:[_registar lookupKeyForAsset:fileName] ofType:nil];
}

/// 获取flutter端瓦片图路径
- (NSString *)pathForFlutterTileResources:(NSString *)tileName{
    if (!_registar) return nil;
    // 指定resoures/bmflocaltileimage/目录下存放瓦片图资源
    return [[NSBundle mainBundle] pathForResource:[_registar lookupKeyForAsset:[NSString stringWithFormat:@"resoures/bmflocaltileimage/%@", tileName]] ofType:nil];
}
@end
