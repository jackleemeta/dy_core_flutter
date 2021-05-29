import 'package:pull_to_refresh/pull_to_refresh.dart';

extension RefreshControllerExtension on RefreshController {
  /// 配置 Header 和 Footer
  void dyConfigHeaderFooter(bool isSuccess, bool hasMore) {
    if (isSuccess) {
      refreshCompleted();
      if (hasMore)
        loadComplete();
      else
        loadNoData();
    } else {
      refreshFailed();
      loadFailed();
    }
  }

  /// 配置Footer
  void dyConfigFooter(bool isSuccess, bool hasMore) {
    if (isSuccess) {
      if (hasMore)
        loadComplete();
      else
        loadNoData();
    } else {
      loadFailed();
    }
  }
}
