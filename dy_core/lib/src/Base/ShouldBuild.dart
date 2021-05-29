import 'package:flutter/widgets.dart';

typedef ShouldBuildFunction<T> = bool Function(T oldSubstance, T newSubstance);

class ShouldBuild<T> extends StatefulWidget {
  final T substance; //参照物
  final ShouldBuildFunction<T> shouldBuild;
  final WidgetBuilder builder;
  ShouldBuild({this.substance, this.shouldBuild, @required this.builder})
      : assert(() {
          if (shouldBuild == null) {
            throw FlutterError.fromParts(<DiagnosticsNode>[
              ErrorSummary('ShouldBuild builder: builder must be not null')
            ]);
          }
          return true;
        }());
  @override
  _ShouldBuildState createState() => _ShouldBuildState<T>();
}

class _ShouldBuildState<T> extends State<ShouldBuild> {
  @override
  ShouldBuild<T> get widget => super.widget;

  Widget oldWidget;
  T oldSubstance;

  bool _isInit = true;

  @override
  Widget build(BuildContext context) {
    final newSubstance = widget.substance;

    if (_isInit ||
        (widget.shouldBuild == null
            ? true
            : widget.shouldBuild(oldSubstance, newSubstance))) {
      _isInit = false;
      oldSubstance = newSubstance;
      oldWidget = widget.builder(context);
    }
    return oldWidget;
  }
}
