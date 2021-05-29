import 'package:flutter/widgets.dart';
import 'DYSupremeState.dart';
import 'ShouldBuild.dart';

/// ！！！解决rebuild问题 ！！！
/// 相关issue：https://github.com/flutter/flutter/issues/11655?tdsourcetag=s_pcqq_aiomsg
/// 所有State类请继承 DYState
/// 请勿中直接继承 State
/// 请重载 Widget shouldBuild(BuildContext context)
/// 勿重载 Widget build(BuildContext context);

abstract class DYState<T extends StatefulWidget> extends DYSupremeState<T> {
  bool _isShouldBuild = false;

  @override
  Widget build(BuildContext context) {
    bool aBool = useSubstance();
    return ShouldBuild<T>(
        substance: aBool ? substance() : null,
        shouldBuild: (oldSubstance, newSubstance) =>
            aBool ? oldSubstance != newSubstance : _isShouldBuild,
        builder: (BuildContext context) {
          _isShouldBuild = false;
          return shouldBuild(context);
        });
  }

  Widget shouldBuild(BuildContext context);

  bool useSubstance() => false;

  T substance() => null;

  void reload([VoidCallback fn]) {
    if (!mounted) return;
    setState(() {
      _isShouldBuild = true;
      if (fn != null) {
        fn();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancelRequest();
  }

  void cancelRequest() {}
}
