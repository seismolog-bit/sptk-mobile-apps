import 'package:http/http.dart' as http;
import 'dart:convert';

class Request {
  static const String baseUrl = 'https://www.sekolahpendidik.com/wp-json/wp/v2/';

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
}