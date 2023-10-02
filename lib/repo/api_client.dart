import 'dart:convert';
import 'package:quiz/shared/const.dart';
import 'package:quiz/shared/model/question_data.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static Future<List<QuestionData>> fetchQuestionsData(int category) async {
    final response = await http.get(Uri.parse('$baseUrl&category=$category'));
    if (response.statusCode == 200) {
      final result = jsonDecode(utf8.decode(response.bodyBytes));
      final data = result['results'] as List;
      final questionsData =
          data.map((json) => QuestionData.fromJson(json)).toList();
      // Often the api returns the same first question. Shuffling for better debugging
      questionsData.shuffle();
      return questionsData;
    } else {
      throw Exception('Failed to load quiz data');
    }
  }
}
