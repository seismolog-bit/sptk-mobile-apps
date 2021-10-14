import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  static const String baseUrl = 'https://www.sekolahpendidik.com/wp-json/wp/v2/';
  static const String gitRaw = 'https://raw.githubusercontent.com/seismolog-bit/sptk-assets/master/data/';

  static Future<dynamic> get({required String action}) async {
    Map<String, String> params = {'Accept': 'application/json'};
    var response = await http.get(Uri.parse(baseUrl + action), headers: params);

    try {
      var resjson = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }

      return resjson;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> getGitRaw({required String action}) async {
    Map<String, String> params = {'Accept': 'application/json'};
    var response = await http.get(Uri.parse(gitRaw + action), headers: params);

    try {
      print(response.request);
      var resjson = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }

      return resjson;
    } catch (e) {
      return null;
    }
  }
}