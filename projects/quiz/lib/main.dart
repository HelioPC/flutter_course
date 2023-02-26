import 'package:flutter/material.dart';
import 'package:quiz/widgets/quiz.dart';
import 'package:quiz/widgets/result.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  var _selectedQuestion = 0;
  var _total = 0;

  final List<Map<String, Object>> questions = const [
    {
      'text': 'What is yours favourite color ?',
      'answers': [
        {'text': 'Black', 'value': 5},
        {'text': 'White', 'value': 1},
        {'text': 'Red', 'value': 0},
        {'text': 'Blue', 'value': 3},
      ],
    },
    {
      'text': 'What is yours favourite animal ?',
      'answers': [
        {'text': 'Dog', 'value': 4},
        {'text': 'Lion', 'value': 1},
        {'text': 'Panther', 'value': 3},
        {'text': 'Tiger', 'value': 2},
      ],
    },
    {
      'text': 'What is yours favourite programming language ?',
      'answers': [
        {'text': 'Python', 'value': 5},
        {'text': 'C', 'value': 4},
        {'text': 'Rust', 'value': 3},
        {'text': 'SQL', 'value': 2},
      ],
    },
    {
      'text': 'What is yours favourite framework',
      'answers': [
        {'text': 'Adonis JS', 'value': 4},
        {'text': 'Laravel', 'value': 1},
        {'text': 'Flutter', 'value': 4},
        {'text': 'React', 'value': 5},
      ],
    }
  ];

  void _responder(int value) {
    setState(() {
      _selectedQuestion++;
      _total += value;
    });

    // print('Respondido: $_selectedQuestion');
  }

  void _reset() {
    setState(() {
      _selectedQuestion = 0;
      _total = 0;
    });
  }

  bool get hasSelectedQuestion {
    return _selectedQuestion < questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 6,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Quiz 2023'),
        ),
        body: hasSelectedQuestion
            ? Padding(
                padding: const EdgeInsets.all(18.0),
                child: Quiz(
                  questions: questions,
                  selectedQuestion: _selectedQuestion,
                  responder: _responder,
                ),
              )
            : Result(
                score: _total,
                reset: _reset,
              ),
      ),
    );
  }
}
