import 'package:http/http.dart' as http;

class DataRepository {

  Future<http.Response> fileData(String name) async {
    var response = await http.get(Uri.parse("https://bartekdadas.github.io/models/$name.json"));
    if(response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Data file wasn't accessed");
    }
  }

}