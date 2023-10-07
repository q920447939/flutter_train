import 'package:flutter/material.dart';
import 'package:flutter_train/dao/travel_tab_dao.dart';
import 'package:flutter_train/model/travel_tab_model.dart';
import 'package:flutter_train/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<TravelTab>? _tabs = [];
  late TravelTabModel _travelTabModel;

  _TravelPageState();

  @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel? model) => {
          setState(() {
            _tabs = model!.tabs;
            _travelTabModel = model;

            //修复tab label 空白问题
            _tabController =
                TabController(length: model!.tabs!.length, vsync: this);
          })
        });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 30),
          child: TabBar(
            controller: _tabController,
            isScrollable: true, //左右滑动
            labelColor: Colors.black,
            labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                insets: EdgeInsets.only(bottom: 10)), //指示器
            tabs: _tabs!.map((TravelTab tab) {
              return Tab(
                // 这里可以设置Tab的文本或图标等属性
                text: tab.labelName, // 示例：使用TravelTab对象中的label属性作为Tab的文本
              );
            }).toList(),
          ),
        ),
        Flexible(
            child: TabBarView(
                controller: _tabController,
                children: _tabs!.map((TravelTab tab) {
                  return TravelTabPage(
                    travelUrl: _travelTabModel.url ?? '',
                    groupChannelCode: tab.groupChannelCode,
                  );
                }).toList()))
      ],
    );
  }
}
