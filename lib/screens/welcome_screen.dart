import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quiz/screens/quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0C),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FadeInDown(
              from: 100,
              child: Image.asset("assets/images/welcome.png"),
            ),
            FadeInLeft(
              from: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Welcome to this Quiz app, your new best friend for the next upcoming days!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            FadeInUp(
              from: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QuizPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 80),
                    side: BorderSide(
                      color: Colors.black38,
                      width: 5,
                    )),
                child: Text(
                  "Start Quiz",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
