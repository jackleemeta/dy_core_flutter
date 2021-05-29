import 'package:flutter/widgets.dart';

import 'DYState.dart';

//单个widget刷新功能，需要继承
abstract class DYStatefulWidget extends StatefulWidget {
  DYStatefulWidget({Key key})
      : super(key: key is GlobalKey ? key : GlobalKey());

  void reload() {
    if (key is! GlobalKey) {
      return;
    }
    final aKey = key as GlobalKey;
    final aState = aKey.currentState;
    if (aState is DYState) {
      aState.reload();
    } else {
      aState.setState(() {});
    }
  }
}
