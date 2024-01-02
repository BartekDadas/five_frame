import 'dart:convert';
import 'package:five_frame/src/model/paths.dart';
import 'package:flutter/material.dart';
import 'package:g_json/g_json.dart';
import 'funs.dart';
import 'package:material_icons_named/material_icons_named.dart';


class ModifyJson {
  static void changeColor({required Map map, required String target, required Color color}) {
    putNewValue(map: map, target: target, value: '#${color.value.toRadixString(16)}');
  }

  static void changeIcon({required Map map, required String target, required IconData iconData}) {
    putNewValue(map: map, target: target, value: materialIcons.entries.firstWhere((element) => element.value == iconData).key);
  }



}