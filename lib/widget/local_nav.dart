import 'package:flutter/material.dart';
import 'package:flutter_train/widget/webview.dart';

import '../model/common_model.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({super.key, required this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    List<Widget> widgetList = [];
    print('====localNavList' + localNavList.length.toString());

    for (var e in localNavList) {
      widgetList.add(_loadItem(context, e));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgetList,
    );
  }

  Widget _loadItem(BuildContext context, CommonModel commonModel) {
    print("commonModel.title=" + commonModel.title);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return WebViewPage(
            hideAppBar: false,
            title: commonModel.title,
            url: commonModel.url, // 修正 URL
            statusBarColor:
                Color(int.parse('0xff' + commonModel.statusBarColor)),
          );
        }));
      },
      child: Column(
        children: [
          Image.network(
            commonModel.icon,
            width: 20,
            height: 20,
          ),
          Text(
            commonModel.title,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
