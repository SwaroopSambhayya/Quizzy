import 'package:flutter/material.dart';
import 'package:quiz/repo/api_client.dart';
import 'package:quiz/shared/const.dart';
import 'package:quiz/shared/model/question_data.dart';
import 'package:quiz/shared/widgets/question_widget.dart';

class Home extends StatefulWidget {
  final int category;
  const Home({Key? key, this.category = defaultCategory}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<QuestionData>> questionsData;
  int _questionIndex = 0;
  int _selectedAnswerIndex = -1;
  bool showAnswer = false;

  @override
  void initState() {
    super.initState();
    questionsData = ApiClient.fetchQuestionsData(widget.category);
  }

  void nextQuestion() async {
    if (_questionIndex < 9) {
      setState(() {
        _selectedAnswerIndex = -1;
        showAnswer = false;
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
            final question = questionData.question!;
            final correctAnswer = questionData.correctAnswer!;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  QuestionWidget(
                    question: question,
                    questionIndex: _questionIndex,
                  ),
                  const SizedBox(height: 32),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: questionData.options!.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemBuilder: (context, index) {
                      final option = questionData.options![index];
                      return OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: showAnswer
                                ? option == correctAnswer
                                    ? Colors.greenAccent
                                    : _selectedAnswerIndex == index
                                        ? Colors.redAccent
                                        : null
                                : null,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          setState(() {
                            showAnswer = true;
                            _selectedAnswerIndex = index;
                          });
                          Future.delayed(
                            const Duration(milliseconds: 1500),
                            () => nextQuestion(),
                          );
                        },
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      );
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
