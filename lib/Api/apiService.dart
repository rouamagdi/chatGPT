import 'dart:convert';

import 'package:http/http.dart' as http;

String api = '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';

class ApiService {
  String baseUrl = "https://api.openai.com/v1/completions";
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $api',
  };

  sendQuestion(String message) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": message,
          "max_tokens": 100,
          "temperature": 0,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0
        }));
    if (res.statusCode == 200) {
      print("successfull");
      var data = jsonDecode(res.body);
      print(res.body);
      var answer = data["choices"][0]["text"];
      return answer;
    } else {
      print("not Successfull");
    }
  }
}
