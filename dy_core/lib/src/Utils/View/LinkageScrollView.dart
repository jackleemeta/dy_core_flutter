import '../Headers/Constant.dart';
import '../../Base/DYState.dart';
import '../../Base/DYStatefulWidget.dart';
import 'package:flutter/material.dart';

import 'DYSliverPersistentHeaderDlegate.dart';
import 'ToolViews.dart';

const double _kGridHorizonalInset = 15;
const double _kGridHorizonalGap = 30;
const double _kGridVerticalGap = 20;
const double _kGridItemWidth = 50;
const double _kGridItemHeight = 30;

const double _kHorizonalHeaderWidth = 55;
const double _kVerticalHeaderHeight = 43;
const double _kVerticalHeaderWidth =
    _kGridHorizonalInset * 2 + _kGridItemWidth * 7 + _kGridHorizonalGap * 6;

/// 横纵向滚动视图
class LinkageScrollView extends DYStatefulWidget {
  final List<Widget> nestedHeaders; // 拼到共有headerList
  final timeItems; // 几点
  final dayItems; // 周几
  final contentCount; // 内容区域个数
  final IndexedWidgetBuilder builder; // 内容

  LinkageScrollView({
    Key key,
    this.nestedHeaders,
    this.timeItems,
    this.dayItems,
    this.contentCount,
    this.builder,
  })  : assert(nestedHeaders != null),
        assert(timeItems != null),
        assert(dayItems != null),
        assert(contentCount != null),
        assert(builder != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkageScrollViewState(
      nestedHeaders: this.nestedHeaders,
      timeItems: this.timeItems,
      dayItems: this.dayItems,
      contentCount: this.contentCount,
      builder: this.builder);
}

/// State
class _LinkageScrollViewState extends DYState<LinkageScrollView> {
  ScrollController _headingController = ScrollController();
  ScrollController _bodyController = ScrollController();
  int _dragingType = -1; // 0 手动拖动heading / 1 手动拖动body

  LinkageContentGridView _bindTimeGridView;

  final List<Widget> nestedHeaders; // 拼到共有headerList
  final timeItems; // 几点
  final dayItems; // 周几
  final contentCount; // 内容区域个数
  final IndexedWidgetBuilder builder; // 内容

  _LinkageScrollViewState(
      {this.nestedHeaders,
      this.timeItems,
      this.dayItems,
      this.contentCount,
      this.builder});

  @override
  void initState() {
    super.initState();
    _bindTimeGridView =
        LinkageContentGridView(itemCount: contentCount, builder: builder);
    _initListener(); //添加监听
  }

  @override
  void reload([fn]) {
    _bindTimeGridView.reload();
  }

  @override
  void setState(fn) {
    _bindTimeGridView.reload();
  }

  @override
  Widget shouldBuild(BuildContext context) {
    return _nestedScrollView;
  }

  @override
  void dispose() {
    _headingController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _initListener() {
    _headingController.addListener(() {
      if (_dragingType == 0) {
        // 正在拖动Heading
        _bodyController.jumpTo(_headingController.offset);
      }
    });

    _bodyController.addListener(() {
      if (_dragingType == 1) {
        // 正在拖动body
        _headingController.jumpTo(_bodyController.offset);
      }
    });
  }

  // NestedScrollView
  NestedScrollView get _nestedScrollView {
    return NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (_, bool innerBoxIsScrolled) {
          return _headerSliverBuilder();
        },
        body: body);
  }

  ///
  ///----------------------------垂直头部-----------------------------
  ///

  ///日期 垂直头部 - 垂直固定头部群
  List<Widget> _headerSliverBuilder() {
    // 日期 固定Header
    final header2 = SliverPersistentHeader(
        delegate: DYSliverPersistentHeaderDlegate(
            inputWidget: _verticalHeaderScrollView,
            minEx: _kVerticalHeaderHeight,
            maxEx: _kVerticalHeaderHeight),
        pinned: true);
    List<Widget> aList = [];
    aList.addAll(nestedHeaders);
    aList.add(header2);
    return aList;
  }

  ///日期 垂直头部 - 横向滚动视图
  Listener get _verticalHeaderScrollView {
    return Listener(
      child: Container(
          child: GestureDetector(
              // onVerticalDragStart: (_) {},
              child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        controller: _headingController,
        scrollDirection: Axis.horizontal,
        slivers: headerSliverlist,
      ))),
      onPointerMove: (movePointEvent) {
        _dragingType = 0;
      },
    );
  }

  ///日期 垂直头部 - 横向滚动视图 - Slivers
  List<Widget> get headerSliverlist {
    //横向 左 空白header
    final emptyHeader = SliverPersistentHeader(
        delegate: DYSliverPersistentHeaderDlegate(
            minEx: _kHorizonalHeaderWidth,
            maxEx: _kHorizonalHeaderWidth,
            inputWidget: GestureDetector(
              child: Container(
                color: Colors.white,
              ),
              onHorizontalDragStart: (_) {},
            )),
        pinned: true);

    Widget adapter = SliverToBoxAdapter(
        child: Container(
      decoration: DYBottomLine,
      width: _kVerticalHeaderWidth,
      child: _verticalHeaderScrollWidget,
    ));

    return [emptyHeader, adapter];
  }

  /// 日期 垂直头部 - 横向滚动视图 - Slivers - ListView
  Widget get _verticalHeaderScrollWidget {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
          top: 0,
          left: _kGridHorizonalInset,
          bottom: 0,
          right: _kGridHorizonalInset,
        ),
        itemCount: dayItems.length,
        itemBuilder: (_, int index) {
          final String item = dayItems[index];
          return Padding(
            padding: EdgeInsets.only(
                right: index == dayItems.length - 1 ? 0 : _kGridHorizonalGap),
            child: Container(
              alignment: Alignment.center,
              height: _kVerticalHeaderHeight,
              width: _kGridItemWidth,
              child: Text(item,
                  style: TextStyle(
                      fontSize: 14,
                      color: DY102ThemeColor,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none)),
            ),
          );
        });
  }

  ///
  ///----------------------------身体-----------------------------
  ///

  ///时间 滚动视图
  Widget get body {
    return Listener(
        onPointerMove: (movePointEvent) {
          _dragingType = 1;
        },
        child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            controller: _bodyController,
            scrollDirection: Axis.horizontal,
            slivers: bodySliverlist()));
  }

  /// 时��� 身体 - 滚动����图 - Slivers
  List<Widget> bodySliverlist() {
    final header = SliverPersistentHeader(
        delegate: DYSliverPersistentHeaderDlegate(
            minEx: _kHorizonalHeaderWidth,
            maxEx: _kHorizonalHeaderWidth,
            inputWidget: bodyHeaderSliver),
        pinned: true);
    final adapter = SliverToBoxAdapter(
      child: Container(width: _kVerticalHeaderWidth, child: _bindTimeGridView),
    );
    return [header, adapter];
  }

  /// 时间 身体 - 滚动视图 - Slivers - 水平头部（Container）
  Widget get bodyHeaderSliver {
    return Container(
        decoration: DYRightLine, child: _horizonalHeaderScrollWidget);
  }

  /// 时间 身�� - 滚动视图 - Slivers - 水平头部 - ListView
  Widget get _horizonalHeaderScrollWidget {
    return ListView.builder(
        padding: EdgeInsets.only(
          top: 10,
          bottom:
              MediaQuery.of(context).padding.bottom + kBottomButtonHeight + 15,
        ),
        itemCount: timeItems.length,
        itemBuilder: (_, int index) {
          final String item = timeItems[index];
          return Padding(
            padding: EdgeInsets.only(
                bottom: index == timeItems.length - 1 ? 0 : _kGridVerticalGap),
            child: Container(
              alignment: Alignment.center,
              height: _kGridItemHeight,
              width: _kHorizonalHeaderWidth,
              child: Text(item,
                  style: TextStyle(
                      fontSize: 12,
                      color: DY102ThemeColor,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none)),
            ),
          );
        });
  }
}

/// 时间盘view
class LinkageContentGridView extends DYStatefulWidget {
  final int itemCount;

  final IndexedWidgetBuilder builder;

  LinkageContentGridView({Key key, this.itemCount, this.builder})
      : super(key: key);

  @override
  _LinkageContentGridViewState createState() =>
      _LinkageContentGridViewState(itemCount, builder);
}

/// State
class _LinkageContentGridViewState extends DYState<LinkageContentGridView> {
  final int itemCount;

  final IndexedWidgetBuilder builder;

  _LinkageContentGridViewState(this.itemCount, this.builder);

  GridView get _timeGridView {
    return GridView.builder(
        padding: EdgeInsets.only(
            top: 10,
            left: _kGridHorizonalInset,
            bottom: MediaQuery.of(context).padding.bottom +
                kBottomButtonHeight +
                15,
            right: _kGridHorizonalInset),
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: _kGridItemWidth,
            childAspectRatio: 5 / 3,
            mainAxisSpacing: _kGridVerticalGap,
            crossAxisSpacing: _kGridHorizonalGap),
        itemBuilder: builder);
  }

  @override
  Widget shouldBuild(BuildContext context) {
    return _timeGridView;
  }
}
