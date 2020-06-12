import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class XFile{

  Future<String> localPath() async{
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> localFile() async{
    final path = await localPath();
    return new File('${path}/data.txt');
  }

  Future<Object> readFile() async{
    try {
      final file = await localFile();
      String data = await file.readAsStringSync();
      print(data);
      return data;
    } catch (e) {
      
    }
  }

  Future<File> write(List transaction) async{
    final file = await localFile();
    try {
      String data = utf8.decode(transaction);
      return file.writeAsString(data, mode: FileMode.append);
    } catch (e) {
    }
  }

}