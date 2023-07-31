import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  final List<Map<String, dynamic>> mcq = [
    {
      "question": "What is the capital of France?",
      "options": ["London", "Paris", "Berlin", "Madrid"],
      "correctAnswerIndex": 1
    },
    {
      "question": "Which planet is known as the 'Red Planet'?",
      "options": ["Venus", "Mars", "Jupiter", "Neptune"],
      "correctAnswerIndex": 1
    },
    {
      "question": "What is the chemical symbol for water?",
      "options": ["H2O", "CO2", "O2", "NaCl"],
      "correctAnswerIndex": 0
    }
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: ListView.builder(
        itemCount: mcq.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mcq[index]["question"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: (mcq[index]["options"] as List<String>).map((option) {
                      return RadioListTile<int>(
                        title: Text(option),
                        value: (mcq[index]["options"] as List<String>).indexOf(option),
                        groupValue: -1,
                        onChanged: (_) {},
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}