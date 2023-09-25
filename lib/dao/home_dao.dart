import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/home_model.dart';

const HOME_URL = "https://www.geekailab.com/io/flutter_app/json/home_page.json";

class HomeDao {
  static Future<HomeModel?> fetch() async {
    final response = await http.get(Uri.parse(HOME_URL));
    if (response.statusCode == 200) {
      Utf8Decoder utf8Decoder = Utf8Decoder();
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      print('Error getting IP address:\nHttp status ${response.statusCode}');
    }
    return null;
  }
}
