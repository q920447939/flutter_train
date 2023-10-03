import 'package:flutter/material.dart';
import 'package:flutter_train/widget/webview.dart';

import '../model/common_model.dart';

//活动
class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({super.key, required this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
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
    List<Widget> widgetList = [];
    print('====subNavList' + subNavList.length.toString());

    for (var e in subNavList) {
      widgetList.add(_loadItem(context, e));
    }
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widgetList.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgetList.sublist(separate, widgetList.length),
          ),
        )
      ],
    );
  }

  Widget _loadItem(BuildContext context, CommonModel commonModel) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return WebViewPage(
                  hideAppBar: false,
                  title: commonModel.title,
                  url: commonModel.url, // 修正 URL
                  statusBarColor:
                      Color(int.parse('0xff' + commonModel.statusBarColor)));
            }));
          },
          child: Column(
            children: [
              Image.network(
                commonModel.icon,
                width: 10,
                height: 18,
              ),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  commonModel.title,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
