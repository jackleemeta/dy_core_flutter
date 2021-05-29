import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// 读数据
dynamic readJSON(String inPath) {
  try {
    final File file = localFile(inPath);
    final str = file.readAsStringSync();
    return jsonDecode(str);
  } catch (error) {
    debugPrint("readJSON error = $error");
  }
  return null;
}

/// 写数据
writeJSON(dynamic data, String inPath) {
  try {
    final File file = localFile(inPath);
    return file.writeAsStringSync(jsonEncode(data));
  } catch (error) {
    debugPrint("writeJSON error = $error");
  }
}

/// 读数据
String readJSONString(String inPath) {
  try {
    final File file = localFile(inPath);
    final str = file.readAsStringSync();
    return str;
  } catch (error) {
    debugPrint("readJSONString error = $error");
  }
  return null;
}

/// 写数据
writeJSONString(String data, String inPath) {
  try {
    final File file = localFile(inPath);
    return file.writeAsStringSync(data);
  } catch (error) {
    debugPrint("writeJSONString error = $error");
  }
}

/// 创建目录
tryCreateCustomDirectory(String path, {bool recursive = false}) async {
  var file = Directory(path);
  try {
    bool exists = await file.exists();
    if (!exists) {
      await file.create(recursive: recursive);
    }
  } catch (error) {
    debugPrint("tryCreateCustomDirectory error = $error");
  }
}

/// 获取[文档目录]
Future<String> get localDocumentPath async {
  String aPath;
  try {
    final aDir = await getApplicationDocumentsDirectory();
    aPath = aDir.path;

    debugPrint('文档目录: ' + aPath);
  } catch (error) {
    debugPrint("localDocumentPath error = $error");
  }
  return aPath;
}

/// 获取[临时目录]
Future<String> get localTemporaryPath async {
  String aPath;
  try {
    final aDir = await getTemporaryDirectory();
    aPath = aDir.path;

    debugPrint('临时目录: ' + aPath);
  } catch (error) {
    debugPrint("localTemporaryPath error = $error");
  }
  return aPath;
}

/// 获取[外部存储目录]
///
/// No iOS
Future<String> get localExternalStorageDirectory async {
  String aPath;
  try {
    final aDir = await getExternalStorageDirectory();
    aPath = aDir.path;

    debugPrint('外部存储目录: ' + aPath);
  } catch (error) {
    debugPrint("localExternalStorageDirectory error = $error");
  }
  return aPath;
}

/// 创建[File对象]
localFile(path) => File('$path');
