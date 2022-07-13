import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String url;

  NetworkHelper(this.url);

  Future getData() async {
    try {
      Uri uri = Uri.parse(url);
      var httpResult = await http.get(uri);
      if (httpResult.statusCode != 200) {
        throw http.ClientException(
            "${httpResult.statusCode.toString()}:${httpResult.body}");
      }
      var body = httpResult.body;
      return jsonDecode(body);
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
