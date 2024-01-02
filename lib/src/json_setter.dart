import 'dart:io';

import 'package:five_frame/src/pages_control.dart';

import 'json_load.dart';
import 'init_files/json_setup.dart';
import 'package:pages_elements/pages_elements.dart';


class JsonSetter {
  late JsonLoader jsonView = JsonLoader();
  PagesControlPanel controlPanel = PagesControlPanel();
  SetupJson setupJson = SetupJson();


  set filesSet(List<File> nFiles) {
    jsonView.files = nFiles;
  }


  Future<List<Map>> instance(bool isInitialized, {int? index}) async {
    if(isInitialized) {
      await jsonView.pageBumper(controlPanel.indexList);
    } else {
      ElementPages? parts = controlPanel.rearengePageCounter(index!);
      if(parts != null) {
        await jsonView.pageBumper(parts.indexes, index: zeroOrNot(index));
      }
    }
    return jsonView.contentBase;
  }

  // List<int> emergencyCase(int index) {
  //   jsonView.contentBase.clear();
  //   ElementPages parts = controlPanel.rearengePageCounter(index);
  //   return parts.indexes;
  // }


  int valueOfIndex(int index) {
    return controlPanel.indexList[index];
  }


  Future<List<File>> startRoll() async {
    return await setupJson.rollListFiles();
  }

  int zeroOrNot(int? addAt) {
    if(addAt == 0 || addAt == null) {
      return 0;
    }
    else {
      return controlPanel.indexList.last + 1;
    }
  }


  //
  // void removeListElements(int index) {
  //   if(controller.currentPage > index) {
  //     controlPanel.removeLast();
  //     jsonView.removeLast();
  //   } else {
  //     controlPanel.removeFirst();
  //     jsonView.removeFirst();
  //   }
  // }


}