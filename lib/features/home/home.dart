import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz/shared/const.dart';
import 'package:quiz/shared/model/question_data.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final int category;
  const Home({Key? key, this.category = defaultCategory}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<QuestionData>> questionsData;
  int _questionIndex = 0;

  @override
  void initState() {
    super.initState();
    questionsData = fetchQuestionsData();
  }

  Future<List<QuestionData>> fetchQuestionsData() async {
    final response =
        await http.get(Uri.parse('$baseUrl&category=${widget.category}'));
    if (response.statusCode == 200) {
      final result = jsonDecode(utf8.decode(response.bodyBytes));
      final data = result['results'] as List;
      final questionsData =
          data.map((json) => QuestionData.fromJson(json)).toList();
      return questionsData;
    } else {
      throw Exception('Failed to load quiz data');
    }
  }

  void nextQuestion() {
    if (_questionIndex < 9) {
      setState(() {
        _questionIndex++;
      });
    } else {
      // TODO: Navigate to quiz end/ leaderboard screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<QuestionData>>(
        future: questionsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final questionsData = snapshot.data!;
            final questionData = questionsData[_questionIndex];
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Card(
                    child: Text(questionData.question!),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: questionData.options!.length,
                    itemBuilder: (context, index) {
                      return Text(questionData.options![index]);
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
