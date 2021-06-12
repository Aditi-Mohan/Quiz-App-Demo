import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'result_screen.dart';
import 'util/url_generator.dart';
import 'quiz_start_screen.dart';

void main() {
  runApp(MyApp());
}

//TODO: Splash screen

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(66, 181, 164, 0.4), Color.fromRGBO(66, 181, 164, 0.8)],
              stops: [0.1, 0.9]
            )
        ),
        child: Column(
          children: [
            Hero(
              tag: 'Main',
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  height:  MediaQuery.of(context).size.height/3,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        top: (MediaQuery.of(context).size.height/3)-100,
                        left: 10.0,
                        child: Text("Let's Play", style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w900, color: Color.fromRGBO(66, 181, 164, 1), shadows: [
                          Shadow(color: Colors.white, blurRadius: 5.0, offset: Offset(1, 1))
                        ]),),
                      ),
                      Positioned(
                        top: (MediaQuery.of(context).size.height/3)-40,
                        left: 10.0,
                        child: Text("Choose a category to start playing...", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Color.fromRGBO(66, 181, 164, 1), shadows: [
                          Shadow(color: Colors.white, blurRadius: 5.0, offset: Offset(1, 1))
                        ]),),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              height:  2*(MediaQuery.of(context).size.height/3),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    top: 75,
                    left: 35,
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),),
                      child: Container(
                          width: (MediaQuery.of(context).size.width/2)-50,
                          height: (MediaQuery.of(context).size.width/2)-50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Hero(
                                  tag: 'txt0',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text("SPORTS",
                                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14.0, color: Color.fromRGBO(66, 181, 164, 1),
                                        shadows: [
                                          Shadow(color: Colors.white, blurRadius: 3.0, offset: Offset(1, 1))
                                        ]
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 35,
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),),
                      child: Container(
                          width: (MediaQuery.of(context).size.width/2)-50,
                          height: (MediaQuery.of(context).size.width/2)-50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Hero(
                                  tag: 'txt1',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text("GEOGRAPHY",
                                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14.0, color: Color.fromRGBO(66, 181, 164, 1),
                                          shadows: [
                                            Shadow(color: Colors.white, blurRadius: 3.0, offset: Offset(1, 1))
                                          ]
                                      ),),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75+((MediaQuery.of(context).size.width/2)-50)+50,
                    left: 35,
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),),
                      child: Container(
                          width: (MediaQuery.of(context).size.width/2)-50,
                          height: (MediaQuery.of(context).size.width/2)-50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Hero(
                                  tag: 'txt3',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text("HISTORY",
                                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14.0, color: Color.fromRGBO(66, 181, 164, 1),
                                        shadows: [
                                          Shadow(color: Colors.white, blurRadius: 3.0, offset: Offset(1, 1))
                                        ]
                                    ),),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75+((MediaQuery.of(context).size.width/2)-50)+75,
                    right: 35,
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),),
                      child: Container(
                          width: (MediaQuery.of(context).size.width/2)-50,
                          height: (MediaQuery.of(context).size.width/2)-50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Hero(
                                  tag: 'txt2',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text("MATHS",
                                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14.0, color: Color.fromRGBO(66, 181, 164, 1),
                                          shadows: [
                                            Shadow(color: Colors.white, blurRadius: 3.0, offset: Offset(1, 1))
                                          ]
                                      ),),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 35,
                    child: Container(
                      width: (MediaQuery.of(context).size.width/2)-50,
                      height: (MediaQuery.of(context).size.width/2)-50,
                      child: Image(image: AssetImage('assets/shadow.png'),),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 15,
                    child: Hero(
                      tag: 'img'+heroTags["SPORTS"],
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizStartScreen(category: "SPORTS",)));
                        },
                        child: Container(
                            width: (MediaQuery.of(context).size.width/2)-50,
                            height: (MediaQuery.of(context).size.width/2)-50,
                          child: Image(image: AssetImage('assets/sports.png'),),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140+((MediaQuery.of(context).size.width/2)-50)+50,
                    right: 65,
                    child: Container(
                      width: (MediaQuery.of(context).size.width/3),
                      height: (MediaQuery.of(context).size.width/2)-50,
                      child: Image(image: AssetImage('assets/shadow.png'),),
                    ),
                  ),
                  Positioned(
                    top: 75+((MediaQuery.of(context).size.width/2)-50)+50,
                    right: 15,
                    child: Hero(
                      tag: 'img2',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizStartScreen(category: "MATHS",)));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width/2)-50,
                          height: (MediaQuery.of(context).size.width/2)-50,
                          child: Image(image: AssetImage('assets/maths.png'),),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    right: 25,
                    child: Container(
                      width: (MediaQuery.of(context).size.width/3),
                      height: (MediaQuery.of(context).size.width/2)-50,
                      child: Image(image: AssetImage('assets/shadow.png'),),
                    ),
                  ),
                  Positioned(
                    top: 65,
                    right: 15,
                    child: Hero(
                      tag: 'img1',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizStartScreen(category: "GEOGRAPHY",)));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width/2)-50,
                          height: (MediaQuery.of(context).size.width/2)-50,
                          child: Image(image: AssetImage('assets/earth.png'),),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110+((MediaQuery.of(context).size.width/2)-50)+50,
                    left: 35,
                    child: Container(
                      width: (MediaQuery.of(context).size.width/2)-50,
                      height: (MediaQuery.of(context).size.width/2)-50,
                      child: Image(image: AssetImage('assets/shadow.png'),),
                    ),
                  ),
                  Positioned(
                    top: 50+((MediaQuery.of(context).size.width/2)-50)+50,
                    left: 25,
                    child: Hero(
                      tag: 'img3',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizStartScreen(category: "HISTORY",)));
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResultScreen(score: 7, total: 10, category: "HISTORY")));
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width/2)-50,
                          height: (MediaQuery.of(context).size.width/2)-50,
                          child: Image(image: AssetImage('assets/history.png'),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
