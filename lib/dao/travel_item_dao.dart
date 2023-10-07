import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/travel_item_model.dart';

const HOME_URL =
    "http://192.168.1.144:18088/io/flutter_app/json/travel_page.json";

var Params = {
  "groupChannelCode": "",
  "pageIndex": 0,
  "pageSize": 0,
};

///旅拍详细
class TravelItemDao {
  static Future<TravelItemModel?> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    final response = await http.get(Uri.parse(url +
        "?groupChannelCode=" +
        groupChannelCode +
        "&pageIndex=" +
        pageIndex.toString() +
        "&pageSize=" +
        pageSize.toString()));
    if (response.statusCode == 200) {
      Utf8Decoder utf8Decoder = Utf8Decoder();
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      print(
          'TravelItemDao , Error getting IP address:\t Http status ${response.statusCode}');
    }
    return null;
  }
}
