import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opalcodex_task/bloc/quiz_bloc.dart';
import 'package:opalcodex_task/models/question_model.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: BlocBuilder<QuizBloc, List<Question>>(
        builder: (context, questions) {
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];

              return Card(
                child: Column(
                  children: [
                    Text(
                      question.questionText,
                      style: const TextStyle(fontSize: 18),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: question.answers.length,
                      itemBuilder: (context, answerIndex) {
                        final answer = question.answers[answerIndex];

                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Set border radius
                          ),
                          title: Text(answer),
                          onTap: () {
                            BlocProvider.of<QuizBloc>(context).selectAnswer(
                              index,
                              answer,
                            );
                          },
                          tileColor: question.selectedAnswer == answer
                              ? Colors.green
                              : null,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
