import 'package:flutter/widgets.dart';

/// ScrollView的固定头部代理组件
class DYSliverPersistentHeaderDlegate extends SliverPersistentHeaderDelegate {
  final Widget inputWidget;

  final double minEx;
  final double maxEx;

  DYSliverPersistentHeaderDlegate(
      {this.inputWidget, this.minEx = 100, this.maxEx = 100})
      : super();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return inputWidget;
  }

  @override
  double get minExtent => minEx;

  @override
  double get maxExtent => maxEx;

  @override
  bool shouldRebuild(DYSliverPersistentHeaderDlegate oldDelegate) {
    return maxEx != oldDelegate.maxEx ||
        minEx != oldDelegate.minEx ||
        inputWidget != oldDelegate.inputWidget;
  }
}
