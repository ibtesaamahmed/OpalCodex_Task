import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opalcodex_task/models/question_model.dart';

class QuizBloc extends Cubit<List<Question>> {
  QuizBloc() : super([]);

  void loadQuestions(List<Question> questions) {
    emit(questions);
  }

  void selectAnswer(int questionIndex, String answer) {
    final updatedQuestions = List<Question>.from(state);
    updatedQuestions[questionIndex].selectedAnswer = answer;
    emit(updatedQuestions);
  }
}
