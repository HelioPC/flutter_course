import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int selectedQuestion;
  final void Function(int) responder;

  const Quiz({
    super.key,
    required this.questions,
    required this.selectedQuestion,
    required this.responder,
  });

  bool get hasSelectedQuestion {
    return selectedQuestion < questions.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> answers = hasSelectedQuestion
        ? questions[selectedQuestion].cast()['answers']
        : [];
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Question(
          question: questions[selectedQuestion]['text'].toString(),
        ),
        ...answers.map((t) {
          return Answer(
            answer: t['text'] as String,
            onPressed: () => responder(int.parse(t['value'].toString())),
          );
        }).toList(),
      ],
    );
  }
}
