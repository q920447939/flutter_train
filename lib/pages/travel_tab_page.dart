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
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
    if (_travelItemList.isEmpty || _travelItemList.length <= 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        body: MasonryGridView.count(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      // the number of columns
      crossAxisCount: 2,
      // vertical gap between two items
      mainAxisSpacing: 2,
      // horizontal gap between two items
      crossAxisSpacing: 2,
      itemCount: _travelItemList.length,
      shrinkWrap: true, // 是否收缩
      physics: const NeverScrollableScrollPhysics(), // 禁止左右滑动
      itemBuilder: (context, index) {
        return Card(
          child:
              TravelItemCard(index: index, travelItem: _travelItemList[index]),
        );
      },
    ));
  }

  //防止页面数据回收，但是加载数据太多会占用太多的内存
  @override
  bool get wantKeepAlive => true;
}

class TravelItemCard extends StatelessWidget {
  int index;
  TravelItem travelItem;

  TravelItemCard({required this.index, required this.travelItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: travelItem.height,
      child: GestureDetector(
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
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemCard(),
              Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    travelItem.article?.articleTitle ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  )),
              _bottomInfo(travelItem)
            ],
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
            bottom: 5,
            left: 5,
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
    if (travelItem.article!.pois!.length <= 0) {
      return "";
    }
    return travelItem.article!.pois![0].poiName ?? "未知";
  }

  _bottomInfo(TravelItem travelItem) {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  travelItem.article!.images?[0].dynamicUrl ?? "",
                  width: 24,
                  height: 24,
                  //宽高设置 裁切的两倍才能裁切出一个圆形
                ),
              )
            ],
          ),
          Container(
            width: 90,
            padding: EdgeInsets.fromLTRB(0, 0, 2, 2),
            child: Text(
              travelItem.article!.author!.nickName ?? "",
              style: TextStyle(fontSize: 10, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                size: 12,
                color: Colors.grey,
              ),
              Padding(padding: EdgeInsets.only(left: 4)),
              Text(
                "111",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
