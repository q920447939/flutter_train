import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_train/dao/travel_item_dao.dart';
import 'package:flutter_train/model/travel_item_model.dart';

import '../widget/webview.dart';

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

  List<TravelItem> filterItemList(List<TravelItem> inputList) {
    List<TravelItem> resultList = [];
    for (var element in inputList) {
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
          scrollDirection: Axis.horizontal, //水平方向
          crossAxisCount: 2, // 几列
          mainAxisSpacing: 3, // 间距
          crossAxisSpacing: 3,
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
    return GestureDetector(
      onTap: () {
        /*Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return WebViewPage(
                hideAppBar: false,
                title: travelItem.article!.articleTitle!,
                url: travelItem.article!.articleTitle!,
                statusBarColor: Colors.white);
          },
        ));*/
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            children: [_itemCard()],
          ),
        ),
      ),
    );
  }

  _itemCard() {
    return Stack(
      children: [
        FittedBox(
          child: Image.network(
            travelItem.article!.images?[0].dynamicUrl ?? "",
          ),
        ),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      _position(travelItem),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
              ]),
            ))
      ],
    );
  }

  String _position(TravelItem travelItem) {
    if (null == travelItem.article!.pois! ||
        travelItem.article!.pois!.length <= 0) {
      return "";
    }
    return travelItem.article!.pois![0].poiName ?? "未知";
  }
}
