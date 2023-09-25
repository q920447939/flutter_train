import 'package:flutter_train/model/common_model.dart';

class GridNavModel {
  GridNavItemModel? hotel;
  GridNavItemModel? flight;
  GridNavItemModel? travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
      hotel: GridNavItemModel.fromJson(json['hotel']),
      flight: GridNavItemModel.fromJson(json['flight']),
      travel: GridNavItemModel.fromJson(json['travel']),
    );
  }
}

class GridNavItemModel {
  String? startColor;
  String? endColor;
  CommonModel? mainItem;
  CommonModel? item1;
  CommonModel? item2;
  CommonModel? item3;
  CommonModel? item4;

  GridNavItemModel(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});

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
