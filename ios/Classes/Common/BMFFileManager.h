//
//  BMFFileManager.h
//  flutter_baidu_mapapi_map
//
//  Created by zbj on 2020/2/12.
//

#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMFFileManager : NSObject

/// registar
@property (nonatomic, strong) NSObject<FlutterPluginRegistrar> *registar;

/// BMFFileManagerCenter
+ (instancetype)defaultCenter;

/// 获取flutter端图片资源路径
- (NSString *)pathForFlutterImageName:(NSString *)imageName;

/// 获取flutter端文件资源路径
- (NSString *)pathForFlutterFileName:(NSString *)fileName;

/// 获取flutter端瓦片图路径
- (NSString *)pathForFlutterTileResources:(NSString *)tileName;
@end

NS_ASSUME_NONNULL_END
