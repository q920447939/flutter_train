import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/travel_tab_model.dart';

const HOME_URL =
    "https://www.geekailab.com/io/flutter_app/json/travel_page.json";

///旅拍类别结构
class TravelTabDao {
  static Future<TravelTabModel?> fetch() async {
    final response = await http.get(Uri.parse(HOME_URL));
    if (response.statusCode == 200) {
      Utf8Decoder utf8Decoder = Utf8Decoder();
      try {
        var result = json.decode(utf8Decoder.convert(response.bodyBytes));
        return TravelTabModel.fromJson(result);
      } catch (error) {
        print('TravelTabDao , Error decoding JSON:\n$error');
        return null;
      }
    } else {
      print(
          'TravelTabDao , Error getting IP address:\nHttp status ${response.statusCode}');
    }
    return null;
  }
}
