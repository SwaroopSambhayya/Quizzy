class QuestionData {
  String? question;
  String? correctAnswer;
  List<String>? options;

  QuestionData({this.question, this.correctAnswer, this.options});

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    final question = json['question'] as String? ?? "";
    final correctAnswer = json['correct_answer'] as String? ?? "";
    final incorrectAnswers = json['incorrect_answers'] as List? ?? [];
    final List<String> options = [...incorrectAnswers, correctAnswer];
    options.shuffle();
    return QuestionData(
      question: question,
      correctAnswer: correctAnswer,
      options: options,
    );
  }
}
