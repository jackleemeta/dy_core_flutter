import '../FlutterCenter/FlutterMethodsSupreme.dart';
import '../Utils/Headers/DYPopBournObject.dart';
import 'package:message_center/message_center.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_page_tracker/flutter_page_tracker.dart';

abstract class DYSupremeState<T extends StatefulWidget> extends State<T>
    with PageTrackerAware, TrackerPageMixin, _DYTrackerStateMixin {
  Function(DYPopBournObject) supremeCallBack;

  bool reloadWhenPageAppear = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didPageView() {
    super.didPageView();
    _inOut(ModalRoute.of(context).settings?.name, true);
  }

  @override
  void didPageExit() {
    super.didPageExit();
    _inOut(ModalRoute.of(context).settings?.name, false);
  }
}

mixin _DYTrackerStateMixin {
  void _inOut(String route, bool isIn) {
    if (route == null) {
      route = "unknown";
    }
    final message = Message();
    final map = {"route": route, "isIn": isIn};
    message.custom = map;
    MessageCenter.call(FlutterMethodsSupreme.kInAndOutView, message);
  }
}
