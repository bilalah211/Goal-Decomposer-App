import 'dart:convert';

import 'package:goal_decomposer/core/utils/app_urls.dart';
import 'package:goal_decomposer/core/utils/constants.dart';
import 'package:http/http.dart' as http;

class OpenRouterAIServices {
  Future<List<String>> generateGoalAi(String title, String description) async {
    final response = await http.post(
      Uri.parse(AppUrl.openRouterAiEndPoint),
      headers: {
        "Authorization": "Bearer ${AppConstants.apiKey}",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "google/gemini-2.0-flash-001",
        "messages": [
          {
            "role": "system",
            "content":
                "Goal: $title\nDescription: $description\nRemember: No numbers, no bullets, just plain text steps.",
          },
          {
            "role": "user",
            "content":
                "Break this goal into clear actionable steps.\nGoal: $title\nDescription: $description\nReturn only bullet list.",
          },
        ],
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String text = data['choices'][0]['message']['content'];
      List<String> tasks = text
          .split('\n')
          .map((e) => e.replaceAll(RegExp(r'^\d+\.|-|\*'), '').trim())
          .where((e) => e.isNotEmpty)
          .toList();

      return tasks;
    } else {
      throw Exception("AI Error: ${response.body}");
    }
  }
}
