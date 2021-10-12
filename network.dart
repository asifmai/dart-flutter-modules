import 'package:http/http.dart' as http;
import 'dart:convert';

enum RequestMethod { GET, POST, PATCH, DELETE, PUT }

Future<dynamic> apiRequest({
  required String url,
  required RequestMethod method,
  dynamic body,
}) async {
  try {
    http.Response response;
    final Uri uri = Uri.parse(url);

    switch (method) {
      case RequestMethod.GET:
        response = await http.get(uri);
        break;
      case RequestMethod.POST:
        response = await http.post(uri, body: jsonEncode(body));
        break;
      case RequestMethod.PATCH:
        response = await http.patch(uri, body: jsonEncode(body));
        break;
      case RequestMethod.PUT:
        response = await http.put(uri, body: jsonEncode(body));
        break;
      case RequestMethod.DELETE:
        response = await http.delete(uri);
        break;
      default:
        response = await http.get(uri);
    }
    final jsonData = jsonDecode(response.body);
    return Future.value(jsonData);
  } catch (e) {
    throw (e);
  }
}
