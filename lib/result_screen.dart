import 'package:flutter/material.dart';
import 'model/quiz.dart';
import 'util/url_generator.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final String category;

  ResultScreen({this.score, this.total, this.category});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(255, 227, 136, 0.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 158.0, 0, 8.0),
              child: Hero(
                tag: 'Main',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text("SCORE",
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(66, 181, 164, 1)
                    ),
                  ),
                ),
              ),
            ),
            Hero(
                tag: 'img'+heroTags[q.category],
                child: RadialProgress(
                  score: widget.score, total: widget.total, goalCompleted: (widget.score/widget.total),
                )
            ),
//            Container(
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height/3,
//              child: Stack(
//                children: [
//                  Center(
//                    child: Container(
//                      width: MediaQuery.of(context).size.height/3,
//                      height: MediaQuery.of(context).size.height/3,
//                      child: TweenAnimationBuilder<double>(
//                        tween: Tween<double>(begin: 0.0, end: widget.score/widget.total),
//                        duration: const Duration(milliseconds: 1000),
//                        builder: (context, value, _) => CircularProgressIndicator(
//                          value: value, strokeWidth: 10.0,
//                          color: Color.fromRGBO(66, 181, 164, 1),
//                          backgroundColor: Color.fromRGBO(66, 181, 164, 0.2),
//                        ),
//                      ),
//                    ),
//                  ),
//                  Center(
//                    child: Text('${widget.score.toString()}/${widget.total.toString()}',
//                    style: TextStyle(
//                      fontSize: 72,
//                      fontWeight: FontWeight.w900,
//                      color: Color.fromRGBO(66, 181, 164, 1),
//                    ),),
//                  ),
//                ],
//              )
//            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 8.0),
              child: Hero(
                tag: 'txt'+heroTags[q.category],
                child: Text("in ${widget.category}",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(66, 181, 164, 1)
                  ),),
              ),
            ),
            Hero(
              tag: 'HintAndNext',
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(66, 181, 164, 1)),
                ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/3,
                      child: Text("Try another Quiz"))
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadialProgress extends StatefulWidget {
  final int score;
  final int total;
  final double goalCompleted;

  RadialProgress({this.score, this.total, this.goalCompleted});

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 200.0,
        width: 200.0,
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: AnimatedOpacity(
          opacity: progressDegrees > 30 ? 1.0 : 0.0,
          duration: fadeInDuration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text('${widget.score.toString()}/${widget.total.toString()}',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(66, 181, 164, 1),
                    ),),
            ],
          ),
        ),
      ),
      painter: RadialPainter(progressDegrees),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
          colors: [Color.fromRGBO(66, 181, 164, 1), Colors.tealAccent, Color.fromRGBO(66, 181, 164, 1)])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}