class Question {
  final String questionText;
  final List<String> answers;
  String? selectedAnswer;

  Question(
      {required this.questionText, required this.answers, this.selectedAnswer});
}
