import 'package:flutter/material.dart';
import 'package:flutter_train/pages/home_page.dart';
import 'package:flutter_train/pages/my_page.dart';
import 'package:flutter_train/pages/search_page.dart';
import 'package:flutter_train/pages/travel_page.dart';

import '../test/test_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _pageController = PageController(initialPage: 0);
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blueAccent;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
          TestPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.home,
              color: _activeColor,
            ),
            label: '首页',
            tooltip: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.search,
              color: _activeColor,
            ),
            label: '搜索',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.camera_alt,
              color: _activeColor,
            ),
            label: '旅拍',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.account_circle,
              color: _activeColor,
            ),
            label: '我的',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.apple,
              color: _defaultColor,
            ),
            activeIcon: Icon(
              Icons.apple,
              color: _activeColor,
            ),
            label: '学习',
          ),
        ],
      ),
    );
  }
}
