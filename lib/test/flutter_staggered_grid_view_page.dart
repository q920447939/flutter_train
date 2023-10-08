// main.dart
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FlutterStaggeredGridViewPage extends StatefulWidget {
  const FlutterStaggeredGridViewPage({Key? key, required String APPBAR_NAME})
      : super(key: key);

  @override
  _FlutterStaggeredGridViewPage createState() =>
      _FlutterStaggeredGridViewPage();
}

class _FlutterStaggeredGridViewPage
    extends State<FlutterStaggeredGridViewPage> {
  // Generate a list of dummy items
  final List<Map<String, dynamic>> _items = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Item $index",
            "height": Random().nextInt(150) + 50.5
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('nust技术'),
        ),
        // implement the massonry layout
        body: MasonryGridView.count(
          itemCount: _items.length,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          // the number of columns
          crossAxisCount: 2,
          // vertical gap between two items
          mainAxisSpacing: 2,
          // horizontal gap between two items
          crossAxisSpacing: 2,
          itemBuilder: (context, index) {
            // display each item with a card
            return Card(
              // Give each item a random background color
              color: Color.fromARGB(
                  Random().nextInt(256),
                  Random().nextInt(256),
                  Random().nextInt(256),
                  Random().nextInt(256)),
              key: ValueKey(_items[index]['id']),
              child: SizedBox(
                height: _items[index]['height'],
                child: Center(
                  child: Text(_items[index]['title']),
                ),
              ),
            );
          },
        ));
  }
}
