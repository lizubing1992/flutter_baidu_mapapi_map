import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/function_item.widget.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/Draw/map_drawarcline_page.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/Draw/map_drawcircle_page.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/Draw/map_drawdot_page.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/Draw/map_drawground_page.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/Draw/map_drawmaker_page.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/Draw/map_drawpolygon_page.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/Draw/map_drawpolyline_page.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/Draw/map_drawtext_page.dart';
import 'package:flutter_baidu_mapapi_map_example/DemoPages/utils.dart';

/// 在地图绘制入口
class MapDrawPage extends StatelessWidget {
  const MapDrawPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BMFAppBar(
          title: '在地图上绘制',
          isBack: false,
        ),
        body: Container(
            child: ListView(children: <Widget>[
          FunctionItem(
            label: 'marker示例',
            sublabel: 'marker绘制及事件响应',
            target: DrawMarkerPage(),
          ),
          FunctionItem(
            label: 'polyline示例',
            sublabel: 'polyline绘制及事件响应',
            target: DrawPolylinePage(),
          ),
          FunctionItem(
            label: 'arcline示例',
            sublabel: '弧线绘制',
            target: DrawArclinePage(),
          ),
          FunctionItem(
            label: 'polygon示例',
            sublabel: '多边形绘制',
            target: DrawPolygonPage(),
          ),
          FunctionItem(
            label: 'circle示例',
            sublabel: '圆形绘制',
            target: DrawCirclePage(),
          ),
          generatePlatformizationItem(
              Platform.isAndroid, 'dot示例', '圆点绘制', DrawDotPage()),
          FunctionItem(
              label: 'ground示例', sublabel: '图片覆盖物绘制', target: DrawGroundPage()),
          generatePlatformizationItem(
              Platform.isAndroid, 'text示例', '文本绘制', DrawTextPage()),
        ])));
  }
}
