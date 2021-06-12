import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'question_screen.dart';
import 'util/url_generator.dart';
import 'model/quiz.dart';

class QuizStartScreen extends StatefulWidget {
  final String category;

  QuizStartScreen({this.category});

  @override
  _QuizStartScreenState createState() => _QuizStartScreenState();
}

class _QuizStartScreenState extends State<QuizStartScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  AnimationController _controller;
  bool loaded = false;
  bool processed = false;

  String get timerString {
    Duration duration = _controller.duration * _controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void getQuestions() async {
    var response = await http.get(Uri.parse(categoryMap[widget.category]));
    loaded = response.statusCode == 200 && response.body.isNotEmpty;
//    print(response.body);
//    print(jsonDecode(response.body).runtimeType);
    Map<String, dynamic> res = jsonDecode(response.body);
    //print(res);
    if(loaded)
      processed = q.processResponse(res, widget.category);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    getQuestions();
    _controller.reverse(from: 1.0);
    _controller.animateTo(0.0, duration: Duration(seconds: 5));
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.dispose();
        if(loaded && processed) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => QuestionScreen(0)));
        }
        else {
          showDialog(context: context, builder: (context) {
            return AlertDialog(title: Text("Couldn't Load Question"),
              actions: [ElevatedButton(child: Text("Back"), onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              })
              ],);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.black54,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * _controller.value,
                  color: Color.fromRGBO(66, 181, 164, 1),
                ),
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width/2) - 80.0,
                top: (MediaQuery.of(context).size.height/2) - 36.0,
                child: Text(timerString,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 72.0, color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
