import 'package:flutter_train/model/common_model.dart';

class GridNavModel {
  GridNavItemModel hotel;
  GridNavItemModel flight;
  GridNavItemModel travel;

  GridNavModel(
      {required this.hotel, required this.flight, required this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
      hotel: GridNavItemModel.fromJson(json['hotel']),
      flight: GridNavItemModel.fromJson(json['flight']),
      travel: GridNavItemModel.fromJson(json['travel']),
    );
  }
}

class GridNavItemModel {
  String startColor;
  String endColor;
  CommonModel mainItem;
  CommonModel item1;
  CommonModel item2;
  CommonModel item3;
  CommonModel item4;

  GridNavItemModel(
      {required this.startColor,
      required this.endColor,
      required this.mainItem,
      required this.item1,
      required this.item2,
      required this.item3,
      required this.item4});

  factory GridNavItemModel.fromJson(Map<String, dynamic> json) {
    return GridNavItemModel(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
    );
  }
}
