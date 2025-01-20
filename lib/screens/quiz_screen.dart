import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import '../model/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /// Monitor current index of qusetions
  int currentQuestionIndex = 0;

  /// TO get selected answer from user
  String? selectedAnswer;
  /// Feature to show Detaile
  bool showResult = false;
  /// To get score
  int score = 0;

  late Future<QuizData> cacheFuture;

  /// Fetch data when this widget initialized
  Future<QuizData> fetchQuizData() async {
    Dio dio = Dio();
    final url = 'https://api.jsonserve.com/Uw5CrX';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return QuizData.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch quiz data');
    }
  }

  void submitAnswer(Question question) {}

  void nextQuestion(QuizData quizData, Question question) {
    setState(() {
      if (currentQuestionIndex < quizData.questions.length - 1) {
        setState(() {
          final correctOption =
              question.options.firstWhere((opt) => opt.isCorrect);
          if (selectedAnswer == correctOption.description) {
            score += quizData.correctMarks.round();
          } else {
            score -= quizData.negativeMarks.round();
          }
        });
        currentQuestionIndex++;
        selectedAnswer = null;
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Quiz Completed!',
          text: 'Your final score is: $score',
          confirmBtnText: 'Restart',
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
            setState(() {
              currentQuestionIndex = 0;
              score = 0;
              selectedAnswer = null;
              showResult = false;
            });
          },
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cacheFuture = fetchQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
      appBar: AppBar(
        title: SafeArea(
          child: const Text('Quiz App'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<QuizData>(
          future: cacheFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/error.png",
                    width: 80,
                    fit: BoxFit.fitWidth,
                  ),
                  Text(
                    "Something Went Wrong, Try again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ));
            } else {
              final quizData = snapshot.data!;
              final question = quizData.questions[currentQuestionIndex];

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInLeft(
                      from: 50,
                      child: Text(
                        quizData.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInLeft(
                      from: 80,
                      child: Text(
                        question.description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...question.options.map((option) {
                      return FadeInDown(
                        from: 25,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RadioMenuButton(
                            value: option.description,
                            groupValue: selectedAnswer,
                            onChanged: (value) {
                              setState(() {
                                showResult = false;
                                selectedAnswer = value;
                              });
                            },
                            style: ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 25),
                              ),
                              elevation: WidgetStatePropertyAll(4),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  option.description,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    if (currentQuestionIndex < quizData.questions.length - 1)
                      FadeInUp(
                        from: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                              backgroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 80),
                              side: BorderSide(
                                color: Colors.black38,
                                width: 5,
                              )),
                          onPressed: () => nextQuestion(quizData, question),
                          child: const Text(
                            'Next Question',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    if (currentQuestionIndex == quizData.questions.length - 1)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            backgroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 80),
                            side: BorderSide(
                              color: Colors.black38,
                              width: 5,
                            )),
                        onPressed: () => nextQuestion(quizData, question),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
