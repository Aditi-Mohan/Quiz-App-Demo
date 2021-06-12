import 'question.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class Quiz {
  List<Question> questions;
  String category;
  int total;
  int score = 0;

  bool processResponse(Map<String, dynamic> res, String category) {
    this.category = category;
    List<Question> qs = [];
    res['results'].forEach((value) {
      String qes = value['question'].toString();
      //print(qes);
      List<dynamic> ops = value['incorrect_answers'];
      List<Option> options = [];
      Random random = new Random();
      int correctAnswer = random.nextInt(4);
      for(int i=0; i < correctAnswer; i++) {
        options.add(Option(option: ops[i], index: i));
        //print(i);
      }
      options.add(Option(option: value['correct_answer'], index: correctAnswer));
      for(int i=0; i < 4-(correctAnswer+1); i++) {
          options.add(Option(option: ops[i+correctAnswer], index: i+correctAnswer+1));
          //print('${i+correctAnswer} mapped to ${i+correctAnswer+1}');
      }
      qs.add(Question(question: qes, correctAnswer: correctAnswer, options: options, difficulty: value['difficulty']));
    });
    //print(qs.length);
    questions = qs;
    total = questions.length;
    return true;
  }
}

Quiz q = Quiz();