import 'package:flutter/material.dart';

class ListViewCityNameRefreshPage extends StatefulWidget {
  final String APPBAR_NAME;
  const ListViewCityNameRefreshPage({required this.APPBAR_NAME});

  @override
  State<ListViewCityNameRefreshPage> createState() =>
      _ListViewCityNameRefreshPageState(APPBAR_NAME);
}

class _ListViewCityNameRefreshPageState
    extends State<ListViewCityNameRefreshPage> {
  List CITYNAME = [
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

  String APPBAR_TITLE;

  _ListViewCityNameRefreshPageState(String appBarName)
      : APPBAR_TITLE = appBarName;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <
          10) {
        //滚动到底部了
        _loadData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
          body: RefreshIndicator(
            onRefresh: () async {
              this._doRefresh();
            },
            child: ListView(
              controller: scrollController,
              children: _buildListView(),
            ),
          )),
    );
  }

  List<Widget> _buildListView() {
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

  Future<Null> _doRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      final more = CITYNAME.length;
      for (var i = 0; i < more; i++) {
        CITYNAME[i] = CITYNAME[i] + '...加载更多';
      }
    });
  }

  void _loadData() async {
    await Future.delayed(Duration(milliseconds: 200));

    setState(() {
      List<String> tmpList = [];
      for (int i = 0; i < 10; i++) {
        tmpList.add("上拉刷新数据=>" + i.toString());
      }
      CITYNAME.addAll(tmpList);
    });
  }
}
