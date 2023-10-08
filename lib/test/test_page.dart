import 'package:flutter/material.dart';
import 'package:flutter_train/test/flutter_staggered_grid_view_page.dart';

import 'expansion_city_name_page.dart';
import 'grid_view_city_name_page.dart';
import 'list_view_city_name_horizontal_page.dart';
import 'list_view_city_name_refresh_page.dart';
import 'list_view_city_name_vertical_page.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ListViewCityNameVerticalPage();
              }));
            },
            child: Text('基于listview垂直方向滚动')),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ListViewCityNameHorizontalPage();
              }));
            },
            child: Text('基于listview水平方向滚动')),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ExpansionCityPage();
              }));
            },
            child: Text('可收缩的下拉框')),
        _buildElevatedButton((_) => GirdViewCityNamePage(), '基于GridVeiw实现网格布局'),
        _buildElevatedButton(
            (_) => ListViewCityNameRefreshPage(
                  APPBAR_NAME: '基于listView垂直方向上拉加载和下拉刷新',
                ),
            '基于listView垂直方向上拉加载和下拉刷新'),
        _buildElevatedButton(
            (_) => FlutterStaggeredGridViewPage(
                  APPBAR_NAME: '在 Flutter 中使用交错网格视图创建瀑布流布局',
                ),
            '在 Flutter 中使用交错网格视图创建瀑布流布局')
      ],
    );
  }

  _buildElevatedButton(
      Widget Function(BuildContext) pageBuilder, String appbarName) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return pageBuilder(context);
          }));
        },
        child: Text(appbarName));
  }
}
