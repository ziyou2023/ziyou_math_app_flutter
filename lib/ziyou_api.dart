import 'dart:convert';

import 'package:http/http.dart' as http;


class ZiYouAPI {
  final String url = "https://api.emath.math.ncu.edu.tw/problem/serial/";
  final Map<String, String> header = {
    "Authorization": "5UDGLP+gy9zaD2VwlLI7jjaxZ4+QIxSpOUXKgSD3KHR5wz4i7BktKFIlfAP2",
    "Accept": "application/json"
  };

  Future<void> getProblem() async {
    try {
      var response = await http.get(
          Uri.parse("https://api.emath.math.ncu.edu.tw/problem/random/range/1/1/1/1/1"),
          headers: header
      );
      if (response.body.isNotEmpty) {
        print(jsonDecode(response.body)["problem"]);
      } else {
        print("response.body is empty!!");
      }
    } catch (e) {
      print(e);
    }
  }
}

