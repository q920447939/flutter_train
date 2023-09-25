import 'package:flutter_train/model/config_model.dart';
import 'package:flutter_train/model/sales_box_model.dart';

import 'common_model.dart';
import 'grid_nav_model.dart';

class HomeModel {
  ConfigModel? config;
  List<CommonModel>? bannerList;
  List<CommonModel> localNavList;
  GridNavModel? gridNav;
  List<CommonModel>? subNavList;
  SalesBoxModel? salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      required this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    var localNavListJson = json['localNavList'] as List;
    var subNavListListJson = json['subNavList'] as List;
    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerListJson.map((e) => CommonModel.fromJson(e)).toList(),
      localNavList:
          localNavListJson.map((e) => CommonModel.fromJson(e)).toList(),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      subNavList:
          subNavListListJson.map((e) => CommonModel.fromJson(e)).toList(),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }

  List<CommonModel> _jsonToCommonModelList(
      Map<String, dynamic> json, String key) {
    var listJson = json[key] as List;
    return listJson.map((e) => CommonModel.fromJson(e)).toList();
  }
}
