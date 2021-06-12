import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/result_screen.dart';

import 'model/quiz.dart';
import 'util/url_generator.dart';

class QuestionScreen extends StatefulWidget {
  final int index;

  QuestionScreen(this.index);
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<Color> tileColors;
  List<Color> tileTextColors;
  bool answered = false;
  bool hintUsed = false;

  @override
  void initState() {
    super.initState();
    tileColors = List.filled(q.questions[widget.index].options.length, Colors.white, growable: false);
    tileTextColors = List.filled(q.questions[widget.index].options.length, Color.fromRGBO(66, 181, 164, 1), growable: false);
  }

  @override
  Widget build(BuildContext context) {
    print(q.category);

    void onAnswer(int index) {
      if (!answered) {
        bool res = q.questions[widget.index].isAnswerCorrect(index);
        print(res);
        if(res) {
          setState(() {
            tileColors[index] = Color.fromRGBO(66, 181, 164, 1);
            tileTextColors[index] = Colors.white;
          });
          print(tileColors[index]);
          print(q.score);
          q.score += 1;
        }
        else {
          setState(() {
            tileColors[index] = Color.fromRGBO(233, 79, 79, 1);
            tileTextColors[index] = Colors.white;
            tileColors[q.questions[widget.index].correctAnswer] = Color.fromRGBO(66, 181, 164, 1);
            tileTextColors[q.questions[widget.index].correctAnswer] = Colors.white;
          });
        }
        setState(() {
          answered = true;
        });
      }
    }

    void getHint(int index) {
      setState(() {
        tileColors[index] = Colors.blueGrey.withOpacity(0.5);
        tileTextColors[index] = Colors.white;
        hintUsed = true;
      });
    }

    return WillPopScope(
      onWillPop: () {
        return showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("You will loose your progress if you exit. Do you want to exit the Quiz?"),
                actions: [
                  ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(66, 181, 164, 1)),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop(false);
                      }, child: Text("CANCEL")
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(66, 181, 164, 1)),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop(true);
                      }, child: Text("EXIT")
                  ),
                ],
              );
            }
        );
      },
      child: Scaffold(
        //backgroundColor: Color.fromRGBO(66, 181, 164, 1),
        body: Column(
          children: [
            Container(
              color: Color.fromRGBO(66, 181, 164, 0.3),
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 25,
                    left: 10,
                    child: Card(
                      color: Color.fromRGBO(255, 227, 136, 1),
                      child: Hero(
                        tag: 'Q',
                        transitionOnUserGestures: true,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            height: (MediaQuery.of(context).size.height/2)-(100.0),
                            width: MediaQuery.of(context).size.width-30.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(q.questions[widget.index].question
                                      .replaceAll("&#039;", "'")
                                      .replaceAll("&quot;", "\"")
                                      .replaceAll("&pi;", "π")
                                      .replaceAll("&iacute;", "í")
                                      .replaceAll("&oacute;", "ó")
                                      .replaceAll("&lrm;", "")
                                      .replaceAll("&ouml;", "ö"),
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w600,
                                  ),
                                    textAlign: TextAlign.center,
                                    maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: (MediaQuery.of(context).size.width/2)-((45.0+8.0+8.0)/2),
                    bottom: (MediaQuery.of(context).size.height/2)-(100.0)+((18.0+4.0+4.0)/2),
                    child: Card(
                      child: Container(
                        width: 45.0+8.0+8.0,
                        height: 18.0+4.0+4.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                          child: Center(
                            child: Text('${(widget.index+1).toString()}/${q.total.toString()}',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.teal
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Color.fromRGBO(66, 181, 164, 0.3),
              height: MediaQuery.of(context).size.height/2-(75),
              width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                      ),
                    itemCount: q.questions[widget.index].options.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          onAnswer(index);
                        },
                        child: Hero(
                          tag: 'tile'+index.toString(),
                          child: Card(
                            color: tileColors[index],
                            child: Center(
                                child: Text(q.questions[widget.index].options[index].option
                                    .replaceAll("&#039;", "'")
                                    .replaceAll("&quot;", "\"")
                                    .replaceAll("&pi;", "π")
                                    .replaceAll("&iacute;", "í")
                                    .replaceAll("&oacute;", "ó")
                                    .replaceAll("&lrm;", "")
                                    .replaceAll("&ouml;", "ö"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: tileTextColors[index],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0
                                  ),
                                )
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                )
              ),
            Container(
              color: Color.fromRGBO(66, 181, 164, 0.3),
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 75,
                    width: 200,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4.0, 8.0, 0, 0),
                          child: Hero(
                            tag: 'img'+heroTags[q.category],
                            child: Container(
                              width: 50,
                                child: Image(image: AssetImage(imagePath[q.category]))
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4.0, 18.0, 0, 8.0),
                          child: Hero(
                            tag: 'txt'+heroTags[q.category],
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(q.category,
                              style: TextStyle(
                                  color: Color.fromRGBO(66, 181, 164, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                shadows: [
                                  Shadow(
                                    color: Colors.white,
                                    blurRadius: 3.0,
                                    offset: Offset(1, 1)
                                  )
                                ]
                              ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if(!answered) {
                        return Hero(
                          tag: 'HintAndNext',
                          child: GestureDetector(
                            onTap: () {
                              Random rand = new Random();
                              int index = rand.nextInt(q.questions[widget.index].options.length);
                              while(index == q.questions[widget.index].correctAnswer)
                                index = rand.nextInt(q.questions[widget.index].options.length);
                              getHint(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 8.0),
                              child: Container(
                                height: 65,
                                child: Builder(
                                  builder: (context) {
                                    if(hintUsed)
                                      return ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueGrey),
                                        ),
                                          child: Container(
                                            height: 65,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(widget.index+1 == q.questions.length ? "FINSIH" : "Next"),
                                                Icon(widget.index+1 == q.questions.length ? Icons.check : Icons.play_arrow)
                                              ],
                                            ),
                                          ),
                                        onPressed: () {},
                                      );
                                    else
                                      return Image(image: AssetImage('assets/hint.png'), );
                                  },
                                )
                              ),
                            ),
                          ),
                        );
                      }
                      else {
                        return Hero(
                          tag: 'HintAndNext',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black54),
                                backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(255, 227, 136, 1)),
                              ),
                                onPressed: () {
                                  if(widget.index+1 == q.questions.length)
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResultScreen(score: q.score, total: q.total, category: q.category)));
                                  else
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => QuestionScreen(widget.index+1)));
                                },
                                child: Container(
                                  height: 65,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(widget.index+1 == q.questions.length ? "FINSIH" : "Next"),
                                      Icon(widget.index+1 == q.questions.length ? Icons.check : Icons.play_arrow)
                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
