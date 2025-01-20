
class QuizData {
  final String title;
  final String topic;
  final int duration;
  final double negativeMarks;
  final double correctMarks;
  final List<Question> questions;

  QuizData({
    required this.title,
    required this.topic,
    required this.duration,
    required this.negativeMarks,
    required this.correctMarks,
    required this.questions,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      title: json['title'],
      topic: json['topic'],
      duration: json['duration'],
      negativeMarks: double.parse(json['negative_marks']),
      correctMarks: double.parse(json['correct_answer_marks']),
      questions:
          (json['questions'] as List).map((q) => Question.fromJson(q)).toList(),
    );
  }
}

class Question {
  final String description;
  final List<Option> options;
  // final String correctAnswer;
  final String solution;

  Question({
    required this.description,
    required this.options,
    // required this.correctAnswer,
    required this.solution,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      description: json['description'],
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
      solution: json['detailed_solution'],
    );
  }
}

class Option {
  final int id;
  final String description;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'],
      isCorrect: json['is_correct'] ?? false,
    );
  }
}
