class Question {
  final String question;
  final int correctAnswer;
  final String difficulty;
  List<Option> options;

  Question({this.question, this.correctAnswer, this.options, this.difficulty});

  bool isAnswerCorrect(int i) {
    return i == correctAnswer;
  }
}

class Option {
  final String option;
  int index;

  Option({this.option, this.index});
}