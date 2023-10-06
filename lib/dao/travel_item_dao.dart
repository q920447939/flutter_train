import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/travel_item_model.dart';

const HOME_URL = "https://www.geekailab.com/io/flutter_app/json/home_page.json";

var Params = {
  "groupChannelCode": "",
  "pageIndex": 0,
  "pageSize": 0,
};

///旅拍详细
class TravelItemDao {
  static Future<TravelItemModel?> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    Params['groupChannelCode'] = groupChannelCode;
    Params['pageIndex'] = pageIndex;
    Params['pageSize'] = pageSize;
    final response = await http.post(Uri.parse(url), body: jsonEncode(Params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8Decoder = Utf8Decoder();
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      return TravelItemModel.fromJson(result);
    } else {
      print(
          'TravelItemDao , Error getting IP address:\nHttp status ${response.statusCode}');
    }
    return null;
  }
}
