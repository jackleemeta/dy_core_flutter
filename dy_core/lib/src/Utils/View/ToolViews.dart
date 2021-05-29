import '../Headers/Constant.dart';
import '../Headers/GlobalHeaders.dart';
import '../Headers/DYPopBournObject.dart';
import '../../FlutterCenter/FlutterMethodsSupreme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:message_center/message_center.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const double kBottomButtonHeight = 40;

/// 默认加载界面
const defaultLoading = Center(
  child: CircularProgressIndicator(),
);

/// 通用导航栏
CupertinoNavigationBar commonNavigationBar(BuildContext context, String title,
    {DYPopBournObject bournObject,
    bool isFirstRoute = false,
    Widget trailing,
    Border border,
    Color backgroundColor = Colors.white,
    Brightness brightness = Brightness.light, //状态栏字体颜色 light为深色  dark为白色
    Image leadingImage}) {
  return CupertinoNavigationBar(
    middle: Text(title),
    padding: EdgeInsetsDirectional.only(start: 2, end: 2),
    backgroundColor: backgroundColor,
    brightness: brightness,
    border: border ??
        Border(
          bottom: BorderSide(
            color: Color(0x4D000000),
            width: 0.0, // One physical pixel.
            style: BorderStyle.solid,
          ),
        ),
    trailing: trailing,
    leading: isFirstRoute
        ? null
        : GestureDetector(
            onTap: () {
              bool isInitialRoute = ModalRoute.of(context).isFirst;
              if (isInitialRoute) {
                clearNavigatorKey();
                MessageCenter.call(FlutterMethodsSupreme.kPopToNative);
              } else {
                Navigator.pop(context, bournObject);
              }
            },
            child: Container(
                width: 44,
                height: 44,
                child: leadingImage ??
                    Image(
                        image: AssetImage("images/core_navi_back.png",
                            package: "dy_core")))),
  );
}

/// 底部按钮
initBottomButton(bool isHeavyColor, String title, Function() func) {
  return Expanded(
      child: MaterialButton(
    height: kBottomButtonHeight,
    color: isHeavyColor
        ? Color.fromRGBO(250, 75, 125, 1)
        : Color.fromRGBO(255, 108, 152, 1),
    child: Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
    onPressed: () {
      func();
    },
  ));
}

/// 通用header
Widget generateHeaderWidget(RefreshStatus mode) {
  Widget body;
  final style = TextStyle(fontSize: 14, color: Color.fromRGBO(90, 90, 90, 1));
  switch (mode) {
    case RefreshStatus.idle:
      body = Text("下拉刷新", style: style);
      break;

    case RefreshStatus.canRefresh:
      body = Text("松开加载更多", style: style);
      break;
    case RefreshStatus.refreshing:
      body = CupertinoActivityIndicator();
      break;
    case RefreshStatus.completed:
      body = Text("加载成功", style: style);
      break;
    case RefreshStatus.failed:
      body = Text("加载失败", style: style);
      break;
    default:
      break;
  }
  return Container(
    height: 55.0,
    child: Center(child: body),
  );
}

Widget generateFooterWidget(LoadStatus mode) {
  Widget body;
  final style = TextStyle(fontSize: 14, color: Color.fromRGBO(90, 90, 90, 1));
  switch (mode) {
    case LoadStatus.idle:
      body = Text("上拉加载", style: style);
      break;
    case LoadStatus.loading:
      body = CupertinoActivityIndicator();
      break;
    case LoadStatus.canLoading:
      body = Text("松开加载更多", style: style);
      break;
    case LoadStatus.failed:
      body = Text("加载失败，上拉重试", style: style);
      break;
    default:
      body = Text("没有更多数据了", style: style);
      break;
  }

  return Container(
    height: 55.0,
    child: Center(child: body),
  );
}

Widget get emptyView {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image(image: AssetImage("images/core_no_data.png", package: "dy_core")),
      SizedBox(height: 6),
      Text("没有数据",
          style: TextStyle(
              fontSize: 14,
              color: DY153ThemeColor,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none))
    ],
  ));
}
