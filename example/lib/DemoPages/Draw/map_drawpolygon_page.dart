import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/map_base_page_state.dart';
import 'package:flutter_baidu_mapapi_map_example/constants.dart';

/// polygon多边形绘制示例
class DrawPolygonPage extends StatefulWidget {
  DrawPolygonPage({Key? key}) : super(key: key);

  @override
  _DrawPolygonPageState createState() => _DrawPolygonPageState();
}

class _DrawPolygonPageState extends BMFBaseMapState<DrawPolygonPage> {
  BMFPolygon? _polygon0;
  BMFPolygon? _polygon1;
  BMFPolygon? _polygon2;

  bool _addState = false;
  String _btnText = "删除";

  /// 创建完成回调
  @override
  void onBMFMapCreated(BMFMapController controller) {
    super.onBMFMapCreated(controller);

    if (!_addState) {
      addPolygon();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'polygon示例',
          onBack: () {
            Navigator.pop(context);
          },
        ),
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
      addPolygon();
    } else {
      removePolygon();
    }

    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }

  void addPolygon() {
    addPolygon0();
    addPolygon1();
    addPolygon2();
  }

  void addPolygon0() {
    List<BMFCoordinate?> coordinates = List.generate(5, (index) => null);
    coordinates[0] = BMFCoordinate(39.965, 116.304);
    coordinates[1] = BMFCoordinate(39.865, 116.304);
    coordinates[2] = BMFCoordinate(39.865, 116.404);
    coordinates[3] = BMFCoordinate(39.905, 116.354);
    coordinates[4] = BMFCoordinate(39.965, 116.404);

    // 圆形镂空
    BMFHollowShape hollowShapeCircle = BMFHollowShape.circle(
        center: BMFCoordinate(39.945, 116.324), radius: 800);
    // 多边形镂空
    List<BMFCoordinate?> hollowPolygonCoords = List.generate(3, (index) => null);
    hollowPolygonCoords[0] = BMFCoordinate(39.945, 116.354);
    hollowPolygonCoords[1] = BMFCoordinate(39.915, 116.354);
    hollowPolygonCoords[2] = BMFCoordinate(39.915, 116.304);

    BMFHollowShape hollowShapePolygon =
        BMFHollowShape.polygon(coordinates: hollowPolygonCoords);

    _polygon0 = BMFPolygon(
        coordinates: coordinates,
        strokeColor: Colors.blue,
        width: 4,
        fillColor: Colors.brown,
        hollowShapes: [hollowShapeCircle, hollowShapePolygon]);
    myMapController?.addPolygon(_polygon0!);
  }

  void addPolygon1() {
    List<BMFCoordinate?> coordinates = List.generate(5, (index) => null);
    coordinates[0] = BMFCoordinate(39.945, 116.500);
    coordinates[1] = BMFCoordinate(39.865, 116.500);
    coordinates[2] = BMFCoordinate(39.865, 116.600);
    coordinates[3] = BMFCoordinate(39.945, 116.600);
    coordinates[4] = BMFCoordinate(39.975, 116.550);
    _polygon1 = BMFPolygon(
        coordinates: coordinates,
        strokeColor: Colors.blueGrey,
        width: 10,
        fillColor: Colors.red);
    myMapController?.addPolygon(_polygon1!);
  }

  void addPolygon2() {
    List<BMFCoordinate?> coordinates = List.generate(6, (index) => null);
    coordinates[0] = BMFCoordinate(39.765, 116.304);
    coordinates[1] = BMFCoordinate(39.665, 116.304);
    coordinates[2] = BMFCoordinate(39.665, 116.404);
    coordinates[3] = BMFCoordinate(39.685, 116.424);
    coordinates[4] = BMFCoordinate(39.745, 116.424);
    coordinates[5] = BMFCoordinate(39.765, 116.404);
    _polygon2 = BMFPolygon(
        coordinates: coordinates,
        strokeColor: Colors.orange,
        width: 6,
        fillColor: Colors.lightGreen);
    myMapController?.addPolygon(_polygon2!);
  }

  void removePolygon() {
    myMapController?.removeOverlay("${_polygon0?.Id}");
    myMapController?.removeOverlay("${_polygon1?.Id}");
    myMapController?.removeOverlay("${_polygon2?.Id}");
  }
}

/// 设置地图参数
BMFMapOptions initMapOptions() {
  BMFMapOptions mapOptions = BMFMapOptions(
      mapType: BMFMapType.Standard,
      zoomLevel: 12,
      center: BMFCoordinate(39.865, 116.404));
  return mapOptions;
}
