import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opalcodex_task/bloc/quiz_bloc.dart';
import 'package:opalcodex_task/models/question_model.dart';
import 'package:opalcodex_task/screens/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: _loadQuestionsFromJson(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Question> questions = snapshot.data ?? [];
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 108, 108, 108),
                foregroundColor: Colors.white,
                centerTitle: true,
              ),
            ),
            home: BlocProvider(
              create: (_) => QuizBloc()..loadQuestions(questions),
              child: const QuizScreen(),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<Question>> _loadQuestionsFromJson(BuildContext context) async {
    final String data =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    final List<dynamic> jsonList = json.decode(data);

    return jsonList
        .map((json) => Question(
              questionText: json['questionText'],
              answers: List<String>.from(json['answers']),
            ))
        .toList();
  }
}
