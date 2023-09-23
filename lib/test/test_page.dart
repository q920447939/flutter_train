import 'package:flutter/material.dart';

import 'list_view_city_name_vertical_page.dart';
import 'list_view_city_name_horizontal_page.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ListViewCityNameVerticalPage();
              }));
            },
            child: Text('基于listview垂直方向滚动')),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ListViewCityNameHorizontalPage();
              }));
            },
            child: Text('基于listview水平方向滚动')),
      ],
    );
  }
}
