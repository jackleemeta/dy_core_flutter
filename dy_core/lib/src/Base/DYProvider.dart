
import 'package:flutter/widgets.dart';

class DYProvider extends InheritedWidget {

  final dynamic object;
  final Widget child;
  final Function(dynamic) callBack;

  DYProvider({this.object, this.child, this.callBack}) : super(child: child);
  
  static DYProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: DYProvider);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
