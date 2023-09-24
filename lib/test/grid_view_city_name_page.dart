import 'package:flutter/material.dart';

class GirdViewCityNamePage extends StatefulWidget {
  const GirdViewCityNamePage({super.key});

  @override
  State<GirdViewCityNamePage> createState() => _GirdViewCityNamePageState();
}

class _GirdViewCityNamePageState extends State<GirdViewCityNamePage> {
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

  String APPBAR_TITLE = '基于GridVeiw实现网格布局';

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
          body: GridView.count(
            crossAxisCount: 2,
            children: _buildList(),
          )),
    );
  }

  List<Widget> _buildList() {
    return CITYNAME.map((e) => _item(e)).toList();
  }

  Widget _item(e) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        e,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
