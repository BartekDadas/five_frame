import 'dart:convert';
import 'dart:io';
import 'package:five_frame/src/model/paths.dart';
import 'package:g_json/g_json.dart';

class JsonLoader {

  JsonLoader({
    List<Map>? base,
    List<File?>? filesList,
  }) {
    instance(base, filesList);
  }

  final int pagesLength = 15;
  final int startPage = 0;
  late List<Map<dynamic, dynamic>> contentBase;
  late List<File?> files;


  void instance(List<Map>? base, List<File?>? filesList) {
    contentBase = base ?? List<Map>.empty(growable: true);
    files = filesList ?? List<File?>.filled(4, null,growable: true);
  }

  Future pageBumper(List<int> indexList, {int? index}) async {
    List<Map> listContents = await getListContents();
    await accessToPageReader(listContents, indexList, index: index);
  }


  Future accessToPageReader(List<Map<dynamic, dynamic>> contents, List<int> indexList, {int? index}) async {
    if(indexList.length > 10) {
      var content = await pageReader(contents, indexList);
      fillContentBase(content);
    } else {
      surplus(index!, length: indexList.length);
      await pageReader(contents, indexList).then((value) {
        fillContentBase(value, index: index);
      });
    }
  }

  Future<List<Map>> pageReader(List<Map> contents, List<int> indexList) async {
    List<Map> pages = List<Map>.empty(growable: true);
    for(int i = 0; i < indexList.length; i++)  {
        JSON jsonPage = await contentJson(indexList[i], contents);
        pages.add(Map.of(jsonPage.mapObject!));
    }
    return pages;
  }

  Future<JSON> contentJson(int index, List<Map> contentList) async {
    JSON jsonMap = JSON(preList());
    for(var i = 0; i< contentList.length; i++) {
      switch(i) {
        case 0: //AppBar
          jsonMap[Paths.appBarPath] = contentList[i][Paths.appB][index];
          break;
        case 1: //Body
          jsonMap[Paths.bodyPath] = contentList[1][Paths.bb][index];
          break;
        case 2: // BottomNavigationBar
          jsonMap[Paths.bNBPath] = contentList[i][Paths.bot][index];
          break;
        case 3: // FloatingActionButton
          if(contentList[i][Paths.float][index].isNotEmpty) {
            expandMap(jsonMap, Paths.floatButton);
            jsonMap[Paths.floatButtonPath] = contentList[i][Paths.float][index];
          }
          break;
        case 4: //Drawer
          if(contentList[i][Paths.drawer][index].isNotEmpty) {
            expandMap(jsonMap, Paths.drawer);
            jsonMap[Paths.drawerPath] = contentList[i][Paths.drawer][index];
          }
          break;
        case 5: //BottomSheet
          if(contentList[i][Paths.sheet][index].isNotEmpty) {
            expandMap(jsonMap, Paths.sheet);
            jsonMap[Paths.sheetPath] = contentList[i][Paths.sheet][index];
          }
        case 6: //PersistentFooterButton
          if(contentList[i][Paths.footerButtons][index].isNotEmpty) {
            expandMap(jsonMap, Paths.floatButton);
            jsonMap[Paths.footerButtonsPath] = contentList[i][Paths.footerButtons][index];
          }
      }
    }
    return jsonMap;
  }

  void expandMap(JSON json, String name) {
    json.mapObject![Paths.args].addAll({name: null});
  }

  Future<List<Map>> getListContents() async {
    List<Map> contents = [];
    for(int i = 0; i < 3; i++) {
      contents.add(await listContent(i));
    }
    return contents;
  }

  Future<Map> listContent(int i) async  {
    Map map = {};
    try {
      if (files[i] != null) {
        map = await jsonDecode(await files[i]!.readAsString());
      }
      return map;
    } catch(_) {
      return map;
    }
  }


  Map preList() {
    return {
      "type" : "scaffold",
      "args" : {
        "appBar" : null,
        "body" : null,
        "bottomNavigationBar" : null
      }
    };
  }

  void surplus(int index, {int? length}) {
    if(index == 0) {
      minusL(length: length);
    } else {
      minusF(length: length);
    }
  }

  void minusF({int? length}) {
    if(length == 10) {
      removeFirst(reduce: 4);
    } else {
      removeFirst();
    }
  }

  void minusL({int? length}) {
    if(length == 10) {
      removeLast(reduce: 4);
    } else {
      removeLast();
    }
  }

  void fillContentBase( List<Map<dynamic, dynamic>> content, {int? index}) {
    if(index== 0 || index == null) {
      contentBase.insertAll(startPage, content);
    } else {
      contentBase.addAll(content);
    }
  }


  void removeFirst({int? reduce}) {
    contentBase.removeRange(0, reduce ??= 5);
  }

  void removeLast({int? reduce}) {
    contentBase.removeRange(contentBase.length - (reduce ??= 5), contentBase.length);
  }

}