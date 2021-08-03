import 'package:flutter/cupertino.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFModel, BMFCoordinate;

/// infoWindow
class BMFInfoWindow extends BMFModel {
  /// infoWindow唯一id
  String? _id;

  /// infowWindow图片名
  String? image;

  /// infoWindow显示位置
  BMFCoordinate? coordinate;

  /// infoWindow y轴方向偏移
  double? yOffset;

  /// 是否以bitmap形式添加
  bool? isAddWithBitmap;

  /// BMFInfoWindow构造方法
  BMFInfoWindow({
    required this.image,
    required this.coordinate,
    this.yOffset,
    this.isAddWithBitmap,
  })  : assert(image != null),
        assert(coordinate != null) {
    this._id = this.hashCode.toString();
  }

  /// map => BMFInfoWindow
  BMFInfoWindow.fromMap(Map map)
      : assert(map != null,
            'Construct a BMFInfoWindow，The parameter map cannot be null') {
    _id = map['id'];
    image = map['image'];
    coordinate = map['coordinate'] == null
        ? null
        : BMFCoordinate.fromMap(map['coordinate']);
    yOffset = map['yOffset'];
    isAddWithBitmap = map['isAddWithBitmapDescriptor'];
  }

  /// infoWindow唯一id
  String? get Id => _id;

  @override
  fromMap(Map map) {
    return BMFInfoWindow.fromMap(map);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      "id": this.Id,
      'image': this.image,
      'coordinate': this.coordinate?.toMap(),
      'yOffset': this.yOffset,
      'isAddWithBitmapDescriptor': this.isAddWithBitmap
    };
  }
}
