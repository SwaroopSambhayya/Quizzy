import 'dart:async';
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
  late Timer _timer;
  int _questionIndex = 0;
  int _selectedAnswerIndex = -1;
  bool showAnswer = false;
  int _secondsRemaining = 60;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    questionsData = ApiClient.fetchQuestionsData(widget.category);
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0 && _questionIndex < 9) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        showCompletedDialog("TIME UP!!");
      }
    });
  }

  void nextQuestion() async {
    if (_questionIndex < 9) {
      setState(() {
        _selectedAnswerIndex = -1;
        showAnswer = false;
        _questionIndex++;
      });
    } else {
      showCompletedDialog("COMPELTED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Icon(
            Icons.timer_outlined,
            size: 26,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _secondsRemaining.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () => showConfirmDialog(),
        child: FutureBuilder<List<QuestionData>>(
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
                                    ? Colors.green
                                    : _selectedAnswerIndex == index
                                        ? Colors.red
                                        : null
                                : null,
                            foregroundColor: showAnswer
                                ? (option == correctAnswer ||
                                        _selectedAnswerIndex == index)
                                    ? Colors.white
                                    : Colors.black
                                : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: const BorderSide(
                                width: 0.5, color: Colors.grey),
                          ),
                          onPressed: () {
                            setState(() {
                              showAnswer = true;
                              _selectedAnswerIndex = index;
                            });
                            if (option == correctAnswer) {
                              correctAnswers++;
                            }
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
      ),
    );
  }

  showCompletedDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          content: Text(
            "You answered $correctAnswers / 10 !!",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('leaderboard'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed.
    super.dispose();
  }

  Future<bool> showConfirmDialog() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('CONFIRM'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('YES')),
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('NO')),
          ],
        );
      },
    );
  }
}
