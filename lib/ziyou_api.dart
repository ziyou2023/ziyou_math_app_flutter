import 'dart:convert';

import 'package:http/http.dart' as http;


class ZiYouAPI {

  final String url = "https://api.emath.math.ncu.edu.tw/problem/serial/";
  // ProblemID: 版本+年級+學期+章節+難易度
  // todo: 後三碼的意義
  final String problemId = "312043001";
  final Map<String, String> header = {
    "Authorization": "5UDGLP+gy9zaD2VwlLI7jjaxZ4+QIxSpOUXKgSD3KHR5wz4i7BktKFIlfAP2",
    "Accept": "application/json"
  };

  Future<void> getProblem() async {
    try {
      var response = await http.get(
          Uri.parse('https://api.emath.math.ncu.edu.tw/problem/serial/111011001/10'),
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

