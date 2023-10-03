import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_train/dao/home_dao.dart';
import 'package:flutter_train/model/home_model.dart';
import 'package:flutter_train/widget/loading_container.dart';
import 'package:flutter_train/widget/salebox_nav.dart';
import 'package:flutter_train/widget/sub_nav.dart';

import '../model/common_model.dart';
import '../model/grid_nav_model.dart';
import '../model/sales_box_model.dart';
import '../widget/grid_nav.dart';
import '../widget/local_nav.dart';
import '../widget/webview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double opacity = 0;
  double MAX_APPBAR_OPACITY = 100;
  String resultString = "";
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel? gridNav;
  List<CommonModel> subNavList = [];
  SalesBoxModel? salesBox;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  Future<void> _loadData() async {
    HomeModel? homeModel = await HomeDao.fetch();
    setState(() {
      bannerList = homeModel!.bannerList!;
      localNavList = homeModel!.localNavList;
      gridNav = homeModel!.gridNav;
      print("subNavList.length===111+" + subNavList.length.toString());
      subNavList = homeModel.subNavList;
      print("subNavList.length===+" + subNavList.length.toString());
      salesBox = homeModel.salesBox;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      //MediaQuery.removePadding  移除padding
      body: LoadingContainer(
        isLoading: _isLoading,
        widget: Stack(children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            //NotificationListener 监听滚动
            child: RefreshIndicator(
                onRefresh: () => _loadData(),
                child: NotificationListener(
                  onNotification: (notification) {
                    //当滚动时调用 ,如果没有滚动则不触发 ,并且只监听第一个元素的滚动，也就是ListView
                    if (notification is ScrollUpdateNotification &&
                        notification.depth == 0) {
                      _onScroll(notification.metrics.pixels);
                    }
                    return true;
                  },
                  child: _buildListView(),
                )),
          ),
          _buildAppBar()
        ]),
      ),
    );
  }

  ListView _buildListView() {
    return ListView(
      children: [
        _buildBanner(),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            localNavList: localNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(
            gridNavModel: gridNav,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(
            subNavList: subNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SaleBoxNav(
            salesBox: salesBox,
          ),
        ),
      ],
    );
  }

  Container _buildBanner() {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel common = bannerList[index];
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return WebViewPage(
                    hideAppBar: false,
                    title: common.title,
                    url: common.url,
                    statusBarColor:
                        Color(int.parse('0xff' + common.statusBarColor)));
              }));
            },
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: const SwiperPagination(),
      ),
    );
  }

  Opacity _buildAppBar() {
    return Opacity(
        opacity: opacity,
        child: Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页'),
          )),
        ));
  }

  void _onScroll(double offset) {
    double tmpOffset = offset / MAX_APPBAR_OPACITY;
    double setOffset = 0;
    if (tmpOffset < 0) {
      setOffset = 0;
    } else if (tmpOffset > 1) {
      setOffset = 1;
    }
    setState(() {
      this.opacity = setOffset;
    });
    print(this.opacity);
  }
}
