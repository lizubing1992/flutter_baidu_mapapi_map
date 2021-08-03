import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_baidu_mapapi_map_example/constants.dart';

/// polyline折线绘制示例
class DrawPolylinePage extends StatefulWidget {
  DrawPolylinePage({Key? key}) : super(key: key);

  @override
  _DrawPolylinePageState createState() => _DrawPolylinePageState();
}

class _DrawPolylinePageState extends BMFBaseMapState<DrawPolylinePage> {
  BMFPolyline? _texturesPolyline;
  BMFPolyline? _colorsPolyline;

  bool _addState = false;
  String _btnText = "删除";

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    if (!_addState) {
      addPolyline();
    }

    /// 地图点击覆盖物回调，目前只支持polyline
    /// polyline 只返回了id
    myMapController?.setMapOnClickedOverlayCallback(
        callback: (BMFPolyline polyline) {
      print('地图点击覆盖物回调，只支持polyline=${polyline.toMap()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
            title: 'polyline示例',
            onBack: () {
              Navigator.pop(context);
            }),
        body: Stack(children: <Widget>[generateMap(), generateControlBar()]),
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
      addPolyline();
    } else {
      removePolyline();
    }

    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }

  void addPolyline() {
    addTexturesPolyline();
    addColorsPolyline();
  }

  /// 添加纹理渲染polyline
  void addTexturesPolyline() {
    List<BMFCoordinate?> coordinates = List.generate(5, (index) => null);
    coordinates[0] = BMFCoordinate(39.965, 116.304);
    coordinates[1] = BMFCoordinate(39.925, 116.354);
    coordinates[2] = BMFCoordinate(39.955, 116.394);
    coordinates[3] = BMFCoordinate(39.905, 116.454);
    coordinates[4] = BMFCoordinate(39.965, 116.504);

    List<int> indexs = [0, 1, 2, 3];

    List<String> textures = List.generate(4, (index) => "");
    textures[0] = 'resoures/traffic_texture_smooth.png';
    textures[1] = 'resoures/traffic_texture_slow.png';
    textures[2] = 'resoures/traffic_texture_unknown.png';
    textures[3] = 'resoures/traffic_texture_smooth.png';

    _texturesPolyline = BMFPolyline(
      coordinates: coordinates,
      indexs: indexs,
      textures: textures,
      width: 16,
      lineCapType: BMFLineCapType.LineCapButt,
      lineJoinType: BMFLineJoinType.LineJoinRound,
    );
    myMapController?.addPolyline(_texturesPolyline!);
  }

  /// 添加颜色渲染polyline
  void addColorsPolyline() {
    List<BMFCoordinate?> coordinates = List.generate(5, (index) => null);
    coordinates[0] = BMFCoordinate(39.865, 116.304);
    coordinates[1] = BMFCoordinate(39.825, 116.354);
    coordinates[2] = BMFCoordinate(39.855, 116.394);
    coordinates[3] = BMFCoordinate(39.805, 116.454);
    coordinates[4] = BMFCoordinate(39.865, 116.504);

    List<int> indexs = [2, 3, 2, 3];

    List<Color?> colors = List.generate(4, (index) => null);
    colors[0] = Colors.blue;
    colors[1] = Colors.orange;
    colors[2] = Colors.red;
    colors[3] = Colors.green;

    _colorsPolyline = BMFPolyline(
        coordinates: coordinates,
        indexs: indexs,
        colors: colors,
        width: 16,
        lineDashType: BMFLineDashType.LineDashTypeSquare,
        lineCapType: BMFLineCapType.LineCapButt,
        lineJoinType: BMFLineJoinType.LineJoinRound);
    myMapController?.addPolyline(_colorsPolyline!);
  }

  /// 删除polyline
  void removePolyline() {
    myMapController?.removeOverlay("${_texturesPolyline?.Id}");
    myMapController?.removeOverlay("${_colorsPolyline?.Id}");
  }
}
