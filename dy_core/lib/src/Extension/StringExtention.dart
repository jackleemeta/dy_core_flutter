import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

extension StringExtension on String {
  static bool isEmpty(String str) {
    if (str == null) {
      return true;
    }
    if (str.length <= 0) {
      return true;
    }

    return false;
  }

  String get md5String {
    var content = new Utf8Encoder().convert(this);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
