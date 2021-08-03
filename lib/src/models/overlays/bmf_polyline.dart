import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/src/map/bmf_map_linedraw_types.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';
import 'bmf_overlay.dart';

/// 折线
///
class BMFPolyline extends BMFOverlay {
  /// 经纬度数组
  List<BMFCoordinate?>? coordinates;

  /// 分段索引(多纹理，多颜色折线请赋值)
  List<int>? indexs;

  /// 线宽
  int? width;

  /// 颜色折线的colors 用于颜色绘制
  ///
  /// 与textures二者必须选择其一进行传参
  List<Color?>? colors;

  /// 纹理折线的纹理图片路径 用于纹理绘制
  ///
  /// 注意：纹理图片宽高必须是2的n次幂
  /// 与colors二者必须选择其一进行传参
  List<String>? textures;

  /// 设置折线是否虚线(Android独有)
  ///
  /// 当以纹理形式渲染polyline时，该属性为true，则显示纹理上的元素，为false不显示
  /// 当以颜色形式渲染polyline时，与BMFLineDashType配合使用;为true，则polyline可以渲染成虚线，为false则不能
  bool? dottedLine;

  /// 虚线绘制样式 默认实折线 BMFLineDashTypeNone
  ///
  /// 实折线 LineDashTypeNone,
  /// 方块虚线 LineDashTypeSquare,
  /// 圆点虚线 LineDashTypeDot,
  ///
  /// Android平台要想渲染成虚线，必须设置dottedLine为true
  BMFLineDashType? lineDashType;

  /// line头尾处理方式(不支持虚线) 默认普通头 LineCapButt,
  ///
  /// 普通头 LineCapButt,
  /// 圆形头 LineCapRound
  /// Android平台要想生效，必须设置dottedLine为false
  BMFLineCapType? lineCapType;

  /// line拐角处理方式（不支持虚线）默认平角衔接 LineJoinBevel,
  ///
  /// 平角衔接  BMFLineJoinBevel,
  /// 尖角衔接(尖角过长(大于线宽)按平角处理) LineJoinMiter,
  /// 圆⻆角衔接 LineJoinRound
  ///
  /// Android平台要想生效，必须设置dottedLine为false
  BMFLineJoinType? lineJoinType;

  /// 是否抽稀 默认ture
  bool? isThined;

  /// 是否可点击
  ///
  /// Android独有属性，iOS polyline默认可点击，目前不支持通过该属性设置可点击状态
  bool? clickable;

  /// 纹理宽、高是否保持原比例渲染,默认为false
  ///
  /// Android独有
  bool? isKeepScale;

  /// 是否可以被选中，获得焦点,默认true
  ///
  /// Android独有
  bool? isFocus;

  /// BMFPolyline构造方法
  BMFPolyline({
    required this.coordinates,
    required this.indexs,
    this.width: 5,
    this.colors: const [],
    this.textures: const [],
    this.dottedLine: true,
    this.lineDashType: BMFLineDashType.LineDashTypeNone,
    this.lineCapType: BMFLineCapType.LineCapButt,
    this.lineJoinType: BMFLineJoinType.LineJoinBevel,
    this.isThined: true,
    this.clickable: true,
    this.isKeepScale: false,
    this.isFocus: true,
    int zIndex: 0,
    bool visible: true,
  })  : assert(coordinates != null),
        assert(indexs != null),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFPolyline
  BMFPolyline.fromMap(Map map)
      : assert(map['coordinates'] != null),
        assert(map['indexs'] != null),
        super.fromMap(map) {
    if (map['coordinates'] != null) {
      coordinates = <BMFCoordinate>[];
      map['coordinates'].forEach((v) {
        coordinates?.add(BMFCoordinate.fromMap(v as Map));
      });
    }

    if (map['indexs'] != null) {
      indexs = <int>[];
      map['indexs'].forEach((v) {
        indexs?.add(v as int);
      });
    }

    if (map['colors'] != null) {
      colors = <Color>[];
      map['colors'].forEach((v) {
        colors?.add(ColorUtil.hexToColor(v as String));
      });
    }

    if (map['textures'] != null) {
      textures = <String>[];
      map['textures'].forEach((v) {
        textures?.add(v as String);
      });
    }

    width = map['width'] as int;
    dottedLine = map['dottedLine'] as bool;
    lineDashType = BMFLineDashType.values[map['lineDashType'] as int];
    lineCapType = BMFLineCapType.values[map['lineCapType'] as int];
    lineJoinType = BMFLineJoinType.values[map['lineJoinType'] as int];
    isThined = map['isThined'] as bool;
    clickable = map['clickable'] as bool;
    isKeepScale = map['isKeepScale'] as bool;
    isFocus = map['isFocus'] as bool;
  }

  @override
  fromMap(Map map) {
    return BMFPolyline.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'coordinates': this.coordinates?.map((coord) => coord?.toMap())?.toList(),
      'indexs': this.indexs?.map((index) => index)?.toList(),
      'width': this.width,
      'colors':
          this.colors?.map((color) => color?.value.toRadixString(16))?.toList(),
      'textures': this.textures,
      'dottedLine': this.dottedLine,
      'lineDashType': this.lineDashType?.index,
      'lineCapType': this.lineCapType?.index,
      'lineJoinType': this.lineJoinType?.index,
      'isThined': this.isThined,
      'clickable': this.clickable,
      'isKeepScale': this.isKeepScale,
      'isFocus': this.isFocus,
      'zIndex': this.zIndex,
      'visible': this.visible
    };
  }

  /// 更新经纬度数组
  ///
  /// List<[BMFCoordinate]> coordinates polyline经纬度数组
  ///
  /// indexs iO独有参数，分段索引(多纹理，多颜色折线请赋值),
  ///        iOS在多颜色或者多纹理渲染的情况下，更新经纬度数组的同时，必须更新indexs
  Future<bool> updateCoordinates(List<BMFCoordinate>? coordinates,
      {List<int>? indexs}) async {
    if (null == coordinates) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'coordinates',
      'value': coordinates.map((coordinate) => coordinate.toMap()).toList(),
      'indexs': indexs?.map((index) => index).toList()
    });

    if (ret) {
      this.coordinates = coordinates;
    }

    return ret;
  }

  /// 更新线宽
  Future<bool> updateWidth(int width) async {
    if (width < 0) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel,
            {'id': this.Id, 'member': 'width', 'value': width});

    if (ret) {
      this.width = width;
    }

    return ret;
  }

  /// 更新索引
  ///
  /// Android在以colors渲染的情况下，单独更新索引是无效的，应该使用updateColors接口
  Future<bool> updateIndexs(List<int>? indexs) async {
    if (null == indexs) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'indexs',
      'value': indexs.map((index) => index).toList()
    });

    if (ret) {
      this.indexs = indexs;
    }

    return ret;
  }

  /// 更新colors
  ///
  /// android更新colors的时候,必须带上indexs
  Future<bool> updateColors(List<Color>? colors, {List<int>? indexs}) async {
    if (null == colors) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'colors',
      'value': colors.map((color) => color.value.toRadixString(16)).toList(),
      'indexs': indexs?.map((index) => index).toList()
    });

    if (ret) {
      this.colors = colors;

      if (null != indexs) {
        this.indexs = indexs;
      }
    }

    return ret;
  }

  /// 更新纹理textures (ios暂不支持)
  Future<bool> updateTextures(List<String>? textures) async {
    if (null == textures) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'textures',
      'value': textures.map((e) => e).toList()
    });

    if (ret) {
      this.textures = textures;
    }

    return ret;
  }

  /// 更新是否设置虚线
  ///
  /// Android独有
  Future<bool> updateDottedLine(bool dottedLine) async {
    if (this.dottedLine == dottedLine) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel,
            {'id': this.Id, 'member': 'dottedLine', 'value': dottedLine});

    if (ret) {
      this.dottedLine = dottedLine;
    }

    return ret;
  }

  /// 更新折线绘制样式
  ///
  /// [BMFLineDashType] lineDashType  折线类型
  Future<bool> updateLineDashType(BMFLineDashType lineDashType) async {
    if (this.lineDashType == lineDashType) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'lineDashType',
      'value': lineDashType.index
    });

    if (ret) {
      this.lineDashType = lineDashType;
    }

    return ret;
  }

  /// 更新折线头尾处理方式
  ///
  /// [BMFLineCapType] lineCapType 折线头尾类型
  ///
  /// Android平台要想生效，必须设置dottedLine属性为false
  Future<bool> updateLineCapType(BMFLineCapType lineCapType) async {
    if (this.lineCapType == lineCapType) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'lineCapType',
      'value': lineCapType.index
    });

    if (ret) {
      this.lineCapType = lineCapType;
    }

    return ret;
  }

  /// 更新折线拐角处理方式
  ///
  /// [BMFLineJoinType] lineJoinType 折线拐角处理方式
  ///
  /// Android平台要想生效，必须设置dottedLine属性为false
  Future<bool> updateLineJoinType(BMFLineJoinType lineJoinType) async {
    if (this.lineJoinType == lineJoinType) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel, {
      'id': this.Id,
      'member': 'lineJoinType',
      'value': lineJoinType.index
    });

    if (ret) {
      this.lineJoinType = lineJoinType;
    }

    return ret;
  }

  /// 更新polyLine是否可点击
  ///
  /// Android独有
  Future<bool> updateClickable(bool clickable) async {
    if (this.clickable == clickable) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel,
            {'id': this.Id, 'member': 'clickable', 'value': clickable});

    if (ret) {
      this.clickable = clickable;
    }

    return ret;
  }

  /// 更新纹理宽、高是否保持原比例渲染
  ///
  /// Android独有
  Future<bool> updateIsKeepScale(bool isKeepScale) async {
    if (this.isKeepScale == isKeepScale) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel,
            {'id': this.Id, 'member': 'isKeepScale', 'value': isKeepScale});

    if (ret) {
      this.isKeepScale = isKeepScale;
    }

    return ret;
  }

  /// 更新是否可以被选中，获得焦点
  ///
  /// Android独有
  Future<bool> updateIsFocus(bool isFocus) async {
    if (this.isFocus == isFocus) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel,
            {'id': this.Id, 'member': 'isFocus', 'value': isFocus});

    if (ret) {
      this.isFocus = isFocus;
    }

    return ret;
  }

  /// 更新polyline是否显示
  ///
  /// Android独有
  Future<bool> updateVisible(bool visible) async {
    if (this.visible == visible) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel,
            {'id': this.Id, 'member': 'visible', 'value': visible});

    if (ret) {
      this.visible = visible;
    }

    return ret;
  }

  /// 更新z轴方向上的堆叠顺序
  ///
  /// Android独有
  Future<bool> updateZIndex(int zIndex) async {
    if (this.zIndex == zIndex) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel,
            {'id': this.Id, 'member': 'zIndex', 'value': zIndex});

    if (ret) {
      this.zIndex = zIndex;
    }

    return ret;
  }

  /// 更新polyline是否抽稀
  Future<bool> updateThined(bool isThined) async {
    if (this.isThined == isThined) {
      return true;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updatePolylineMember(this.methodChannel,
            {'id': this.Id, 'member': 'isThined', 'value': isThined});

    if (ret) {
      this.isThined = isThined;
    }

    return ret;
  }
}
