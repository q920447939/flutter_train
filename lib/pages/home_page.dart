import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_train/dao/home_dao.dart';
import 'package:flutter_train/model/home_model.dart';

import '../model/common_model.dart';
import '../widget/local_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://img2.woyaogexing.com/2023/09/21/8f92f263d2250741f40635e4f083b15a.png',
    'http://img2.woyaogexing.com/2023/09/21/b6360547deff023b77895eba53f261fc.jpg',
    'http://img2.woyaogexing.com/2023/09/21/8f92f263d2250741f40635e4f083b15a.png'
  ];
  double opacity = 0;
  double MAX_APPBAR_OPACITY = 100;
  String resultString = "";
  List<CommonModel> localNavList = [];

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  void _loadData() async {
    HomeModel? homeModel = await HomeDao.fetch();
    setState(() {
      localNavList = homeModel!.localNavList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        //MediaQuery.removePadding  移除padding
        body: Stack(children: [
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              //NotificationListener 监听滚动
              child: NotificationListener(
                onNotification: (notification) {
                  //当滚动时调用 ,如果没有滚动则不触发 ,并且只监听第一个元素的滚动，也就是ListView
                  if (notification is ScrollUpdateNotification &&
                      notification.depth == 0) {
                    _onScroll(notification.metrics.pixels);
                  }
                  return true;
                },
                child: ListView(
                  children: [
                    Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: const SwiperPagination(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: LocalNav(
                        localNavList: localNavList,
                      ),
                    )
                  ],
                ),
              )),
          Opacity(
              opacity: opacity,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                )),
              ))
        ]));
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
