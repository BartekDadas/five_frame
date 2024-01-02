import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../repository/data_repository.dart';
import '../model/names.dart';

class SetupJson {
  List<File> files = [];
  final Names names = Names();

  Future<List<File>> rollListFiles() async  {
    for(int i = 0; i < names.fileNames.length; i++) {
      File file = await fileFactory(i);
      files.add(file);
    }
    return files;
  }

  Future<File> fileFactory(int i) async {
    File file = await filePath(names.fileNames[i]);
    await isMade(file);
    file = await hasData(file, i);
    return file;
  }

  Future isMade(File file) async {
    if(!file.existsSync()) {
      await file.create();
    }
  }

  Future<File> hasData(File file, int i) async  {
    if(!file.readAsStringSync().isNotEmpty) {
      file = await fillFile(file, i);
    }
    return file;
  }

  Future<File> fillFile(File file, i) async {
    var content = await DataRepository().fileData(names.fileNames[i]);
    await file.writeAsString(content.body);
    return file;
  }


  Future<File> filePath(String name) async {
    var path = await _localPath;
    File file = File("$path/$name.json");
    return file;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

}