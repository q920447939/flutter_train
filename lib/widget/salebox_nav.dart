import 'package:flutter/material.dart';
import 'package:flutter_train/model/sales_box_model.dart';
import 'package:flutter_train/widget/webview.dart';

import '../model/common_model.dart';

//底部导航
class SaleBoxNav extends StatelessWidget {
  final SalesBoxModel? salesBox;

  const SaleBoxNav({super.key, required this.salesBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 267,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (null == salesBox) {
      return Container();
    }
    List<Widget> widgetList = [];
    print('====salesBoxModel' + salesBox.toString());
    return _loadItem1(context);
  }

  Widget _loadItem1(BuildContext context) {
    List<Widget> widgetList1 = [];
    widgetList1.add(_buildItems1(context, salesBox!.bigCard1, true));
    widgetList1.add(_buildItems1(context, salesBox!.bigCard2, false));

    List<Widget> widgetList2 = [];
    widgetList2.add(_buildItems2(context, salesBox!.smallCard1, true));
    widgetList2.add(_buildItems2(context, salesBox!.smallCard2, false));

    List<Widget> widgetList3 = [];
    widgetList3.add(_buildItems2(context, salesBox!.smallCard3, true));
    widgetList3.add(_buildItems2(context, salesBox!.smallCard4, false));

    return Column(
      children: [
        Container(
            height: 44,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    salesBox!.icon,
                    height: 15,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                    margin: EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                          colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return WebViewPage(
                              hideAppBar: false,
                              title: '更多活动',
                              url: salesBox!.moreUrl,
                              statusBarColor: Color(0xffff3e53));
                        }));
                      },
                      child: Text(
                        '获取更多福利 >',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  )
                ])),
        Row(
          children: widgetList1,
        ),
        Row(
          children: widgetList2,
        ),
        Row(
          children: widgetList3,
        )
      ],
    );
  }

  Widget _buildItems1(
      BuildContext context, CommonModel commonModel, bool isLeft) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItem1(context, commonModel, isLeft),
      ],
    );
  }

  Widget _buildItem1(BuildContext context, CommonModel common, bool isLeft) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return WebViewPage(
              hideAppBar: false,
              title: common.title,
              url: common.url,
              statusBarColor: Color(int.parse('0xff' + common.statusBarColor)));
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            border: isLeft
                ? Border(
                    right: BorderSide(width: 0.8, color: Color(0xfff2f2f2)))
                : null),
        child: Image.network(
          fit: BoxFit.fill, // 图像充满整个容器
          common.icon,
          height: 88,
          //获取当前屏幕宽度
          width: (MediaQuery.of(context).size.width / 2) - 15,
        ),
      ),
    );
  }

  Widget _buildItems2(
      BuildContext context, CommonModel commonModel, bool isLeft) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItem2(context, commonModel, isLeft),
      ],
    );
  }

  Widget _buildItem2(BuildContext context, CommonModel common, bool isLeft) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return WebViewPage(
              hideAppBar: false,
              title: common.title,
              url: common.url,
              statusBarColor: Color(int.parse('0xff' + common.statusBarColor)));
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            border: isLeft
                ? Border(
                    right: BorderSide(width: 0.8, color: Color(0xfff2f2f2)))
                : null),
        child: Image.network(
          fit: BoxFit.fill, // 图像充满整个容器
          common.icon,
          height: 55,
          //获取当前屏幕宽度
          width: (MediaQuery.of(context).size.width / 2) - 15,
        ),
      ),
    );
  }
}
