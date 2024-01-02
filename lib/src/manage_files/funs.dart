


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';
import 'package:json_path/json_path.dart';


void putNewValue({required Map map, required String target, required String value}) {
  JSON json = JSON(map);
  JsonPath path = JsonPath(r'$..'+ target);
  List targetPath = shapeToList(path.read(json).firstWhere((element) => element.path.contains(target)).path);
  json[targetPath] = value;
}

List shapeToList(String it) {
  try {
    List<Object> replaceList = [];
    if (it != "") {
      List<String> list = it.split("[");
      for (var element in list) {
        var nElement = element.replaceAll(RegExp('[^A-Za-z0-9]'), "");
        if (nElement.contains(RegExp(r'^[0-9]+$'))) {
          replaceList.add(int.parse(nElement));
        } else {
          replaceList.add(nElement);
        }
      }
      replaceList.remove(replaceList.first);
      print(replaceList);
      print("/////////");
      replaceList = replaceList.toSet().toList();
      print(replaceList);
    }
    return replaceList;
  } catch(_) {
    return [];
  }
}