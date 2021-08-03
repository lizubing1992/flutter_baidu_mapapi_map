import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_baidu_mapapi_map_example/constants.dart';

/// marker绘制示例
class DrawMarkerPage extends StatefulWidget {
  DrawMarkerPage({
    Key? key,
  }) : super(key: key);

  @override
  _DrawMarkerPageState createState() => _DrawMarkerPageState();
}

class DragState {
  ///开始拖拽
  static const String sDragStart = "dragStart";

  /// 正在拖拽
  static const String sDragging = "dragging";

  ///拖拽完成
  static const String sDragEnd = "dragEnd";
}

class _DrawMarkerPageState extends BMFBaseMapState<DrawMarkerPage> {
  // static const TAG = "_DrawMarkerPageState";

  /// 地图controller
  BMFMarker? _marker;
  BMFMarker? _marker0;
  BMFMarker? _marker1;
  List<BMFMarker>? _markers;
  String? _markerID;
  String? _action;
  String? _state;
  bool? _show;
  BMFCoordinate? _coordinates;

  final BMFCoordinate _startPos = BMFCoordinate(39.928617, 116.30329);
  final BMFCoordinate _endPos = BMFCoordinate(39.928617, 116.50329);

  bool _addState = false;
  String _btnText = "删除";

  // Timer _timer;

  bool enable = true;
  bool dragable = true;

  bool startState = true;

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    if (!_addState) {
      addMarkers();
    }

    /// 地图marker选中回调
    myMapController?.setMaptDidSelectMarkerCallback(
        callback: (BMFMarker marker) {
      print('mapDidSelectMarker-- marker = ${marker.toMap()}');

      setState(() {
        _markerID = marker.Id;
        _action = "选中";
      });
    });

    /// 地图marker取消选中回调
    myMapController?.setMapDidDeselectMarkerCallback(
        callback: (BMFMarker marker) {
      print('MapDidDeselectMarker-- marker = ${marker.toMap()}');

      setState(() {
        _markerID = marker.Id;
        _action = "取消选中";
      });
    });

    /// 地图marker点击回调
    myMapController?.setMapClickedMarkerCallback(callback: (BMFMarker marker) {
      print('MapClickedMarker-- marker = ${marker.toMap()}');
      setState(() {
        _markerID = marker.Id;
        _action = "点击";
      });
    });

    /// 拖拽marker点击回调
    myMapController?.setMapDragMarkerCallback(callback: (BMFMarker marker,
        BMFMarkerDragState newState, BMFMarkerDragState oldState) {
      print(
          'MapDragMarker-- marker = ${marker.toMap()}\n newState = ${newState.toString()}\n oldState = ${oldState.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
          appBar: generateAppBar(),
          body: Stack(children: <Widget>[
            generateMap(),
            generateControlBar(),
          ])),
    );
  }

  /// 添加大头针
  void addMarker() {
    BMFMarker marker = BMFMarker(
        position: BMFCoordinate(39.928617, 116.40329),
        title: 'flutterMaker',
        subtitle: 'test',
        identifier: 'flutter_marker',
        icon: 'resoures/icon_end.png');
    // bool result;
    myMapController?.addMarker(marker);
    _marker = marker;
  }

  BMFAppBar generateAppBar() {
    return BMFAppBar(
        title: 'marker示例',
        onBack: () {
          Navigator.pop(context);
        });
  }

  Container generateMarkerInfo() {
    Text text;
    if (null == _markerID || _markerID!.isEmpty) {
      text = Text('');
    } else if (_action != "拖拽") {
      text = Text('当前marker id:$_markerID, 操作类型: $_action');
    } else if (_state != DragState.sDragging && null != _coordinates) {
      double? latitude = _coordinates?.latitude;
      double? longtitude = _coordinates?.longitude;
      text = Text(
          '当前marker id:$_markerID, 操作类型:$_action 状态:$_state x:$latitude y:$longtitude');
    } else {
      text = Text('当前marker id:$_markerID, 操作类型:$_action 状态:$_state');
    }

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 400,
      height: 40,
      child: text,
    );
  }

  /// 创建地图
  @override
  Container generateMap() {
    return Container(
      height: screenSize?.height,
      width: screenSize?.width,
      child: BMFMapWidget(
        onBMFMapCreated: (controller) {
          onBMFMapCreated(controller);
        },
        mapOptions: initMapOptions(),
      ),
    );
  }

  @override
  Widget generateControlBar() {
    return Container(
      width: screenSize?.width,
      height: 60,
      color: Color(int.parse(Constants.controlBarColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              color: Color(int.parse(Constants.btnColor)),
              textColor: Colors.white,
              child: Text(
                _btnText,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                onBtnPress();
              }),
        ],
      ),
    );
  }

  void onBtnPress() {
    if (_addState) {
      addMarkers();
    } else {
      removeMarkers();
    }

    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }

  /// 创建更新属性栏
  Row generateUpdateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(child: Text('更新位置'), onPressed: () {}),
        Switch(
            value: _show!,
            activeColor: Colors.green,
            onChanged: (bool value) {
              setState(() {
                _show = value;
              });
            }),
        Text('锁定屏幕位置'),
      ],
    );
  }

  /// 删除大头针
  void removeMarker() {
    myMapController?.removeMarker(_marker!);
  }

  /// 批量添加大头针
  void addMarkers() {
    if (_markers == null || _markers!.isEmpty) {
      BMFLog.d('dragable:$dragable', tag: '_DrawMarkerPageState');

      _marker0 = BMFMarker(
          position: BMFCoordinate(39.928617, 116.40329),
          title: '第一个',
          subtitle: 'test',
          identifier: 'flutter_marker',
          icon: 'resoures/icon_ugc_start.png',
          enabled: enable,
          draggable: dragable);

      _marker1 = BMFMarker(
          position: _startPos,
          title: '第二个',
          subtitle: 'test',
          identifier: 'flutter_marker',
          icon: 'resoures/icon_binding_point.png',
          enabled: enable,
          draggable: dragable);

      _markers = [];
      _markers?.add(_marker0!);
      // _markers.add(_marker1);
      myMapController?.addMarkers(_markers!);

      // _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      //   if (startState) {
      // _marker0?.updateIcon("resoures/icon_ugc_start.png");
      //     _marker1?.updatePosition(_startPos);
      //     startState = !startState;
      //   } else {
      //     _marker0?.updateIcon("resoures/icon_ugc_end.png");
      //     _marker1?.updatePosition(_endPos);
      //     startState = !startState;
      //   }
      // });
    }
  }

  /// 批量删除大头针
  void removeMarkers() {
    // _timer.cancel();
    // _timer = null;
    myMapController?.removeMarkers(_markers!);
    _markers?.clear();
    _marker0 = null;
    _marker1 = null;
  }
}
