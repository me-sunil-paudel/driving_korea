import 'dart:convert';
import 'package:driving_korea/models/question_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionIndex = 0;
  int correctAnswers = 0;
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    String jsonString =
        await rootBundle.loadString('assets/data/question1_data.json');
    List<dynamic> jsonList = json.decode(jsonString);
    questions = jsonList
        .map((json) => Question(
              question: json['question'],
              answers: List<String>.from(json['answers']),
              correctAnswer: json['correctAnswer'],
            ))
        .toList();
    setState(() {});
  }

  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer == questions[questionIndex].correctAnswer) {
      setState(() {
        correctAnswers++;
        showToast("Correct!", Colors.green);
      });
      //playCorrectSound();
    } else {
      showToast("Incorrect", Colors.red);
      //playIncorrectSound();
    }

    // Check if there are more questions
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      // Navigate to the quiz result page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultScreen(
              correctAnswers: correctAnswers, totalQuestions: questions.length),
        ),
      );
    }
  }

  void showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: color,
      textColor: Colors.redAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid)),
                      child: Text(
                          'Question ${questionIndex + 1}/${questions.length}')),
                  const SizedBox(height: 16),
                  Text(questions[questionIndex].question,
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 16),
                  ...questions[questionIndex]
                      .answers
                      .map((answer) => ElevatedButton(
                            onPressed: () => checkAnswer(answer),
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(400, 60))),
                            child: Text(answer),
                          ))
                      .toList(),
                ],
              ),
            ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const QuizResultScreen(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You got $correctAnswers out of $totalQuestions correct!'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}
