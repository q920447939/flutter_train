import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget widget;
  final bool isLoading;
  final bool cover;
  const LoadingContainer({
    Key? key,
    required this.widget,
    required this.isLoading,
    this.cover = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!cover) {
      if (isLoading) {
        return _buildWidget(context);
      } else {
        return widget;
      }
    } else {
      if (isLoading) {
        return Stack(
          children: [widget, _buildWidget(context)],
        );
      } else {
        return widget;
      }
    }
  }

  Widget _buildWidget(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
