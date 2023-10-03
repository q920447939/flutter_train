import 'package:flutter/material.dart';
import 'package:flutter_train/model/common_model.dart';
import 'package:flutter_train/model/grid_nav_model.dart';
import 'package:flutter_train/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;
  const GridNav({super.key, required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    //边上的圆角,用BorderRadius 无效
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _buildItems(context),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    List<Widget> resultList = [];
    if (null == gridNavModel) return resultList;

    if (null != gridNavModel?.hotel) {
      resultList.add(_buildItem(context, gridNavModel!.hotel, true));
    }
    if (null != gridNavModel?.flight) {
      resultList.add(_buildItem(context, gridNavModel!.flight, false));
    }
    if (null != gridNavModel?.hotel) {
      resultList.add(_buildItem(context, gridNavModel!.hotel, false));
    }
    return resultList;
  }

  Widget _buildItem(
      BuildContext context, GridNavItemModel gridNavItemModel, bool isFirst) {
    List<Widget> list = [];
    list.add(_mainItem(context, gridNavItemModel.mainItem));
    list.add(
        _doubleItem(context, gridNavItemModel.item1, gridNavItemModel.item2));
    list.add(
        _doubleItem(context, gridNavItemModel.item3, gridNavItemModel.item4));

    List<Widget> resul = [];
    for (var widget in list) {
      resul.add(Expanded(
        flex: 1,
        child: widget,
      ));
    }
    Color start = Color(int.parse('0xff${gridNavItemModel.startColor}'));
    Color end = Color(int.parse('0xff${gridNavItemModel.endColor}'));
    return Container(
      height: 88,
      margin: isFirst ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          //渐变
          gradient: LinearGradient(colors: [start, end])),
      child: Row(
        children: resul,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel common) {
    return _wrapGesture(
      context,
      common,
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.network(
            common.icon,
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            margin: const EdgeInsets.only(top: 11),
            child: Text(
              common.title,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false)),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel item, bool isFirst) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: borderSide,
                bottom: isFirst ? borderSide : BorderSide.none)),
        child: _wrapGesture(
          context,
          item,
          Center(
              child: Text(
            item.title,
            style: TextStyle(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }

  _wrapGesture(BuildContext context, CommonModel common, Widget widget) {
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
      child: widget,
    );
  }
}
