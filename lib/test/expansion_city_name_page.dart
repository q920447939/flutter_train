import 'package:flutter/material.dart';

class ExpansionCityPage extends StatefulWidget {
  const ExpansionCityPage({super.key});

  @override
  State<ExpansionCityPage> createState() => _ExpansionCityPageState();
}

class _ExpansionCityPageState extends State<ExpansionCityPage> {
  static const Map CITYNAME_MAP = {
    '湖北省': ['武汉', '十堰', '襄阳'],
    '湖南省': ['长沙', '衡阳', '张家界', '益阳'],
  };

  String APPBAR_TITLE = '可收缩的下拉框';

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
          body: ListView(
            children: _buildListView(),
          )),
    );
  }

  List<Widget> _buildListView() {
    List<Widget> resultList = [];

    for (var key in CITYNAME_MAP.keys) {
      resultList.add(_itemExpansion(key, CITYNAME_MAP[key]));
    }
    return resultList;
  }

  Widget _itemExpansion(String parentName, List<String> subNameList) {
    return ExpansionTile(
      title: Text(
        parentName,
        style: const TextStyle(color: Colors.black54, fontSize: 20),
      ),
      children: subNameList.map((e) => _buildSubItem(e)).toList(),
    );
  }

  Widget _buildSubItem(String subName) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(color: Colors.lightBlueAccent),
        child: Text(subName),
      ),
    );
  }
}
