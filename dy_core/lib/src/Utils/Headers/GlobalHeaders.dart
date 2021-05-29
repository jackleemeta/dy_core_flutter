import 'package:flutter/widgets.dart';
import 'package:platform/platform.dart';

/// [设置调试模式]

GlobalKey<NavigatorState> _navigatorKey;

GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

void newNavigatorKey() => _navigatorKey = GlobalKey<NavigatorState>();

void clearNavigatorKey() => _navigatorKey = null;

const platfom = LocalPlatform();
