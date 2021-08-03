import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate, ColorUtil;
import 'package:flutter_baidu_mapapi_map/src/private/mapdispatcher/bmf_map_dispatcher_factory.dart';

import 'bmf_overlay.dart';

/// 文本
///
/// Android独有
class BMFText extends BMFOverlay {
  /// 文本
  String? text;

  /// text经纬度
  BMFCoordinate? position;

  /// 背景色
  Color? bgColor;

  /// 字体颜色
  Color? fontColor;

  /// 字体大小
  int? fontSize;

  /// typeface
  BMFTypeFace? typeFace;

  /// 文字覆盖物水平对齐方式 ALIGN_LEFT | ALIGN_RIGHT | ALIGN_CENTER_HORIZONTAL
  int? alignX;

  /// 文字覆盖物垂直对齐方式  ALIGN_TOP | ALIGN_BOTTOM | ALIGN_CENTER_VERTICAL
  int? alignY;

  /// 旋转角度
  double? rotate;

  /// BMFText构造方法
  BMFText({
    required this.text,
    required this.position,
    this.bgColor,
    this.fontColor: Colors.blue,
    this.fontSize: 12,
    this.typeFace,
    this.alignY: BMFVerticalAlign.ALIGN_CENTER_VERTICAL,
    this.alignX: BMFHorizontalAlign.ALIGN_CENTER_HORIZONTAL,
    this.rotate: 0,
    int zIndex: 0,
    bool visible: true,
  })  : assert(text != null),
        assert(position != null),
        super(zIndex: zIndex, visible: visible);

  /// map => BMFText
  BMFText.fromMap(Map map)
      : assert(map['text'] != null),
        assert(map['position'] != null),
        super.fromMap(map) {
    text = map['text'];
    position =
        map['position'] == null ? null : BMFCoordinate.fromMap(map['position']);
    bgColor = ColorUtil.hexToColor(map['bgColor']);
    fontColor = ColorUtil.hexToColor(map['fontColor']);
    fontSize = map['fontSize'];
    typeFace =
        map['typeFace'] == null ? null : BMFTypeFace.fromMap(map['typeFace']);
    alignX = map['alignX'];
    alignY = map['alignY'];
    rotate = map['rotate'];
  }

  @override
  fromMap(Map map) {
    return BMFText.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      'id': this.Id,
      'text': this.text,
      'position': this.position?.toMap(),
      "bgColor": this.bgColor?.value?.toRadixString(16),
      "fontColor": this.fontColor?.value?.toRadixString(16),
      "fontSize": this.fontSize,
      "typeFace": this.typeFace?.toMap(),
      "alignX": this.alignX,
      "alignY": this.alignY,
      "rotate": this.rotate,
      "zIndex": this.zIndex,
      'visible': this.visible,
    };
  }

  /// 更新Text文本
  ///
  /// text 文本
  Future<bool> updateText(String text) async {
    if (null == text) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateTextMember(this.methodChannel,
            {'id': this.Id, 'member': 'text', 'value': text});

    if (ret) {
      this.text = text;
    }

    return ret;
  }

  /// 更新Text经纬度
  ///
  /// [BMFCoordinate] position 圆心点经纬度
  Future<bool> updatePosition(BMFCoordinate? position) async {
    if (null == position) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateTextMember(this.methodChannel,
            {'id': this.Id, 'member': 'position', 'value': position.toMap()});

    if (ret) {
      this.position = position;
    }

    return ret;
  }

  /// 更新Text背景颜色
  ///
  /// [Color] color 背景颜色
  Future<bool> updateBgColor(Color? bgColor) async {
    if (null == bgColor) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateTextMember(this.methodChannel, {
      'id': this.Id,
      'member': 'bgColor',
      'value': bgColor.value.toRadixString(16)
    });

    if (ret) {
      this.bgColor = bgColor;
    }

    return ret;
  }

  /// 更新Text字体颜色
  ///
  /// [Color] fontColor 字体颜色
  Future<bool> updateFontColor(Color? fontColor) async {
    if (null == fontColor) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateTextMember(this.methodChannel, {
      'id': this.Id,
      'member': 'fontColor',
      'value': fontColor.value.toRadixString(16)
    });

    if (ret) {
      this.fontColor = fontColor;
    }

    return ret;
  }

  /// 更新Text typeFace
  ///
  /// [BMFTypeFace] typeFace
  Future<bool> updateTypeFace(BMFTypeFace? typeFace) async {
    if (null == typeFace) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateTextMember(this.methodChannel,
            {'id': this.Id, 'member': 'typeFace', 'value': typeFace.toMap()});

    if (ret) {
      this.typeFace = typeFace;
    }

    return ret;
  }

  /// 更新Text 字体大小
  ///
  /// fontSize
  Future<bool> updateFontSize(int fontSize) async {
    if (fontSize < -1) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateTextMember(this.methodChannel,
            {'id': this.Id, 'member': 'fontSize', 'value': fontSize});

    if (ret) {
      this.fontSize = fontSize;
    }

    return ret;
  }

  /// 更新Text 文字覆盖对齐方式
  ///
  /// alignX 文字覆盖物水平对齐方式 ALIGN_LEFT | ALIGN_RIGHT | ALIGN_CENTER_HORIZONTAL
  /// alignY 文字覆盖物水平对齐方式 ALIGN_LEFT | ALIGN_RIGHT | ALIGN_CENTER_HORIZONTAL
  Future<bool> updateAlign(int alignX, int alignY) async {
    if (alignX != BMFHorizontalAlign.ALIGN_CENTER_HORIZONTAL &&
        alignX != BMFHorizontalAlign.ALIGN_LEFT &&
        alignX != BMFHorizontalAlign.ALIGN_RIGHT) {
      return false;
    }

    if (alignY != BMFVerticalAlign.ALIGN_BOTTOM &&
        alignY != BMFVerticalAlign.ALIGN_CENTER_VERTICAL &&
        alignY != BMFVerticalAlign.ALIGN_TOP) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateTextMember(this.methodChannel, {
      'id': this.Id,
      'member': 'align',
      'alignX': alignX,
      'alignY': alignY
    });

    if (ret) {
      this.alignX = alignX;
      this.alignY = alignY;
    }

    return ret;
  }

  /// 更新Text 旋转角度
  ///
  /// rotate 旋转角度
  Future<bool> updateRotate(double rotate) async {
    if (rotate < -1) {
      return false;
    }

    bool ret = await BMFMapDispatcherFactory.instance.overlayDispatcher
        .updateTextMember(this.methodChannel,
            {'id': this.Id, 'member': 'rotate', 'value': rotate});

    if (ret) {
      this.rotate = rotate;
    }

    return ret;
  }
}

/// Text水平方向上围绕position的对齐方式
class BMFHorizontalAlign {
  /// 文字覆盖物水平对齐方式:左对齐
  static const int ALIGN_LEFT = 1;

  /// 文字覆盖物水平对齐方式:右对齐
  static const int ALIGN_RIGHT = 2;

  /// 文字覆盖物水平对齐方式:水平居中对齐
  static const int ALIGN_CENTER_HORIZONTAL = 4;
}

/// Text垂直方向上围绕position的对齐方式
class BMFVerticalAlign {
  /// 文字覆盖物垂直对齐方式:上对齐
  static const int ALIGN_TOP = 8;

  /// 文字覆盖物垂直对齐方式:下对齐
  static const int ALIGN_BOTTOM = 16;

  /// 文字覆盖物垂直对齐方式:居中对齐
  static const int ALIGN_CENTER_VERTICAL = 32;
}

enum BMFTextStyle {
  NORMAL,
  BOLD,
  ITALIC,
  BOLD_ITALIC,
}

class BMFFamilyName {
  static const String sDefault = "";
  static const String sSansSerif = "sans-serif";
  static const String sSerif = "serif";
  static const String sMonospace = "monospace";
}

/// typeFace
class BMFTypeFace implements BMFModel {
  String? familyName;
  BMFTextStyle? textStype;

  BMFTypeFace({
    required this.familyName,
    required this.textStype,
  })  : assert(familyName != null),
        assert(textStype != null);

  @override
  BMFTypeFace.fromMap(Map map)
      : assert(map != null,
            'Construct a BMFTypeFace，The parameter map cannot be null'),
        assert(map['familyName'] != null),
        assert(map['textStype'] != null) {
    if (map != null) {
      familyName = map['familyName'];
      textStype = BMFTextStyle.values[map['textStype'] as int];
    }
  }

  @override
  dynamic fromMap(Map map) {
    return BMFTypeFace.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {"familyName": this.familyName, "textStype": this.textStype?.index};
  }
}
