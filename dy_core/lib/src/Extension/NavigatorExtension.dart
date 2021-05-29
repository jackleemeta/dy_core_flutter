import 'package:dy_core/dy_core.dart';

import '../Utils/Headers/GlobalHeaders.dart';
import 'package:flutter/widgets.dart';
import 'package:message_center/message_center.dart';

extension NavigatorExtension on Navigator {
  static void myAddPush(BuildContext context, String route, dynamic args) {
    if (route == null || route.length == 0) return;
    if (navigatorKey == null) {
      _handleToNativeToPush(route, args);
    } else {
      if (!FlutterRoutesSupreme.all.contains(route)) {
        _handleToNativeToPush(route, args);
      } else {
        if (context == null) {
          navigatorKey.currentState?.pushNamed(route, arguments: args);
        } else {
          Navigator.pushNamed(context, route, arguments: args);
        }
      }
    }
  }

  static void _handleToNativeToPush(String route, dynamic args) {
    final message = Message();
    message.custom = {"route": route, "isInitial": true, "args": args};
    MessageCenter.call(FlutterMethodsSupreme.kRunRoute, message);
  }
}
