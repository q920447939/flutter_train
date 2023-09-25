import 'package:flutter/material.dart';
import 'package:flutter_train/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;
  final String name;

  const GridNav(
      {super.key, required this.gridNavModel, this.name = 'xiaoming'});

  @override
  Widget build(BuildContext context) {
    return Text(this.name);
  }
}
