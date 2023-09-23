import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewCityNameHorizontalPage extends StatefulWidget {
  const ListViewCityNameHorizontalPage({super.key});

  @override
  State<ListViewCityNameHorizontalPage> createState() =>
      _ListViewCityNameHorizontalPageState();
}

class _ListViewCityNameHorizontalPageState
    extends State<ListViewCityNameHorizontalPage> {
  static const List CITYNAME = [
    '石家庄市',
    '唐山市',
    '秦皇岛市',
    '邯郸市',
    '邢台市',
    '保定市',
    '张家口市',
    '承德市',
    '沧州市',
    '廊坊市',
    '衡水市',
    '太原市',
    '大同市',
  ];

  String APPBAR_TITLE = '基于listView水平方向滚动城市名称';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APPBAR_TITLE,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(APPBAR_TITLE),
        ),
        body: Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildListView(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildListView() {
    return CITYNAME.map((e) => _item(e)).toList();
  }

  Widget _item(e) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        e,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
