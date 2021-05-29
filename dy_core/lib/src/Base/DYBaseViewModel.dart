
import 'package:dy_networking/dy_networking.dart';

class DYBaseViewModel extends Object {

  bool hasMore = true;

  bool isFirst = true;
  
  List<DYBaseRequest> requests = [];

  void cancelRequest() {
    requests?.forEach((request) {
      request?.cancel();
    });
    requests.clear();
  }
}
