import 'package:flutter/material.dart';

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
    for (var e in localNavList) {
      widgetList.add(_loadItem(context, e));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgetList,
    );
  }

  Widget _loadItem(BuildContext context, CommonModel commonModel) {
    return GestureDetector(
      onTap: () {},
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
