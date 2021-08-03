import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFNativeViewType;
import 'package:flutter_baidu_mapapi_map/src/map/bmf_map_controller.dart';
import 'package:flutter_baidu_mapapi_map/src/models/bmf_map_options.dart';

/// 地图创建回调
typedef BMFMapCreatedCallback = void Function(BMFMapController controller);

/// 百度地图Widget
class BMFMapWidget extends StatefulWidget {
  /// BMFMapWidget构造方法
  const BMFMapWidget(
      {Key? key,
      required this.onBMFMapCreated,
      this.hitTestBehavior = PlatformViewHitTestBehavior.opaque,
      this.layoutDirection,
      this.mapOptions})
      : super(key: key);

  /// 创建mapView回调
  final BMFMapCreatedCallback onBMFMapCreated;

  /// 渗透点击事件，接收范围 opaque > translucent > transparent；
  final PlatformViewHitTestBehavior hitTestBehavior;

  /// 嵌入视图文本方向
  final TextDirection? layoutDirection;

  /// map属性配置
  final BMFMapOptions? mapOptions;
  @override
  _BMFMapWidgetState createState() => _BMFMapWidgetState();
}

class _BMFMapWidgetState extends State<BMFMapWidget> {
  final _gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>[
    Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
  ].toSet();

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // ios
      return UiKitView(
        viewType: BMFNativeViewType.sMapView, // 原生交互时唯一标识符
        onPlatformViewCreated: _onPlatformViewCreated, // 创建视图后的回调
        gestureRecognizers: _gestureRecognizers, // 透传手势
        hitTestBehavior: widget.hitTestBehavior, // 渗透点击事件
        layoutDirection: widget.layoutDirection, // 嵌入视图文本方向
        creationParams: widget.mapOptions?.toMap() as dynamic, // 向视图传递参数
        creationParamsCodec: new StandardMessageCodec(), // 编解码器类型
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: BMFNativeViewType.sMapView,
        onPlatformViewCreated: _onPlatformViewCreated,
        hitTestBehavior: widget.hitTestBehavior, // 渗透点击事件
        layoutDirection: widget.layoutDirection, // 嵌入视图文本方向
        creationParams: widget.mapOptions?.toMap() as dynamic, // 向视图传递参数
        creationParamsCodec: new StandardMessageCodec(), // 编解码器类型
      );
    } else {
      return Text('flutter_bmfmap插件尚不支持$defaultTargetPlatform');
    }
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onBMFMapCreated == null) {
      return;
    }

    widget.onBMFMapCreated(new BMFMapController.withId(id));
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    print('implement dispose');
    super.dispose();
  }

  @override
  void didUpdateWidget(BMFMapWidget oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    print('reassemble');
    super.reassemble();
  }
}
