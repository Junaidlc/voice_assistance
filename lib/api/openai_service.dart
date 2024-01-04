import 'dart:convert';

import 'package:voice_assistance/secret.dart';
import 'packag e:http/http.dart' as http;

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey'
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [{
              'role':'user',
              'content':'Does this massage want to ganarate AI picture, image, art or anything similar? $prompt .Simply answer with a yes or no,',
            }]
          }
        )
      );
      print(res.body);
      if(res.statusCode == 200) {
        print('yay');
      }
    } catch (e) {
      e.toString();
    }
    return "AI";
  } 

  Future<String> chatGPTAPI(String prompt) async {
    return "ChatGPT";
  }

  Future<String> dallEAPI(String prompt) async {
    return "DallE";
  }
}
