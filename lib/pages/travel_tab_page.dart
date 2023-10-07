import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_train/dao/travel_item_dao.dart';
import 'package:flutter_train/model/travel_item_model.dart';

const int PAGE_SIZE = 10;
const URL = "";

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;
  const TravelTabPage(
      {super.key, this.travelUrl = URL, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with TickerProviderStateMixin {
  late List<TravelItem> _travelItemList = [];
  int pageIndex = 1;

  @override
  void initState() {
    _loadData();

    super.initState();
  }

  void _loadData() {
    TravelItemDao.fetch(
            widget.travelUrl, widget.groupChannelCode, pageIndex, PAGE_SIZE)
        .then((travelItemModel) => {
              setState(() {
                List<TravelItem> _travelItemTmpList =
                    filterItemList(travelItemModel!.resultList);
                if (_travelItemTmpList.length > 0) {
                  _travelItemList.addAll(_travelItemTmpList);
                }
              })
            });
  }

  List<TravelItem> filterItemList(List<TravelItem>? resultList) {
    List<TravelItem> resultList = [];
    for (var element in resultList) {
      if (null != element.article) {
        resultList.add(element);
      }
    }
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.count(
          crossAxisCount: 2, // 几列
          mainAxisSpacing: 20, // 间距
          crossAxisSpacing: 10,
          itemCount: _travelItemList.length,
          shrinkWrap: true, // 是否收缩
          physics: const NeverScrollableScrollPhysics(), // 禁止左右滑动
          itemBuilder: (context, index) {
            return TravelItemCard(
                index: index, travelItem: _travelItemList[index]);
          }),
    );
  }
}

class TravelItemCard extends StatelessWidget {
  int index;
  TravelItem travelItem;

  TravelItemCard({required this.index, required this.travelItem});

  @override
  Widget build(BuildContext context) {
    return Text(travelItem.article!.author!.nickName!);
  }
}
