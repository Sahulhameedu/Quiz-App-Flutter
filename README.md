# Quiz App

A simple quiz application built using Flutter (version 3.27.1) and the `dio` package for fetching quiz data from a REST API. The app allows users to answer multiple-choice questions, calculates their score, and displays a result at the end using the `quickalert` package.

## Features
- Fetches quiz data from a REST API.
- Displays questions and multiple-choice answers.
- Validates answers and calculates scores.
- Provides feedback for each question (Correct/Incorrect).
- Shows a completion dialog with the final score.

## Requirements
- Flutter SDK: `3.27.1`
- Dart: `>=2.19.0 <4.0.0`

## Dependencies
Below are the dependencies used in the project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.3.1
  quickalert: ^2.1.0
```

## Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```bash
   cd quiz_app
   ```

3. Get the required dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Usage

### App Structure
- `QuizPage`: The main screen that handles the quiz flow.
- `QuizData`: A model to parse quiz data from the API.
- `Question`: A model to handle individual questions.
- `Option`: A model for multiple-choice options.

### Fetching Quiz Data
The app fetches quiz data from the API endpoint:
```dart
final url = 'https://api.jsonserve.com/Uw5CrX';
final response = await dio.get(url);
```

### Showing Completion Dialog
The `quickalert` package is used to display the result at the end of the quiz:
```dart
QuickAlert.show(
  context: context,
  type: QuickAlertType.success,
  title: 'Quiz Completed!',
  text: 'Your final score is: \$score',
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
```

### Screenshots
Add screenshots of your app here (e.g., main screen, question page, completion dialog).

## Code Highlights

### Submitting an Answer
```dart
void submitAnswer(Question question) {
  setState(() {
    final correctOption = question.options.firstWhere((opt) => opt.isCorrect);
    if (selectedAnswer == correctOption.description) {
      score += 4;
    } else {
      score += -1;
    }
    showResult = true;
  });
}
```

### Navigation to the Next Question
```dart
void nextQuestion(QuizData quizData) {
  setState(() {
    if (currentQuestionIndex < quizData.questions.length - 1) {
      currentQuestionIndex++;
      selectedAnswer = null;
      showResult = false;
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Quiz Completed!',
        text: 'Your final score is: \$score',
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
```

![Image](https://github.com/user-attachments/assets/cd21fe50-c292-476d-a5f3-da4e9dd0ca0c)

![Image](https://github.com/user-attachments/assets/131f86b5-8415-42b5-adb9-e34c4f304cc2)

![Image](https://github.com/user-attachments/assets/fd0ffb38-f00a-49e5-a7b0-859f5ffac59b)

## License
This project is open-source and available under the [MIT License](LICENSE).

---
Happy coding!
