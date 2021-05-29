import 'package:flutter/widgets.dart';

import 'DYStatefulWidget.dart';

class DYRefreshableView extends DYStatefulWidget {
  final Widget Function(BuildContext cntext) builder;

  DYRefreshableView({Key key, @required this.builder})
      : assert(builder != null),
        super(key: key);
  
  @override
  State<StatefulWidget> createState() {
    return _DYRefreshableViewState(builder);
  }
}

class _DYRefreshableViewState extends State<DYRefreshableView> {
  final Widget Function(BuildContext cntext) builder;
  _DYRefreshableViewState(this.builder);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
