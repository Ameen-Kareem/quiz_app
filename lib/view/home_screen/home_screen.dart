import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:test_4/dummy_db.dart';
import 'package:test_4/view/home_screen/widgets/answer_bar.dart';
import 'package:test_4/view/score_screen/score_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.restart, required this.category});
  bool? restart = false;
  String category;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    totalQus = DummyDb.Questions[widget.category].length - 1;
  }

  int totalQus = 0;
  int quesNum = 0;
  int? selected;
  int count = 0;
  bool timeOver = false;
  CountDownController _countDownController = CountDownController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 40,
        actions: [
          Text(
            "${quesNum + 1} / ${totalQus + 1}",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            Expanded(
              child: Stack(children: [
                _questionArea(quesNum, widget.category, selected, totalQus),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: CircularCountDownTimer(
                    duration: 5,
                    initialDuration: 0,
                    controller: _countDownController,
                    height: 70,
                    width: 70,
                    ringColor: Colors.black,
                    ringGradient: null,
                    fillColor: Colors.white,
                    fillGradient: null,
                    backgroundColor: Colors.transparent,
                    backgroundGradient: null,
                    strokeWidth: 10.0,
                    strokeCap: StrokeCap.round,
                    textStyle: TextStyle(
                        fontSize: 33.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    textFormat: CountdownTextFormat.S,
                    isReverse: true,
                    isReverseAnimation: false,
                    isTimerTextShown: true,
                    autoStart: true,
                    onComplete: () {
                      if (quesNum <= totalQus) {
                        selected = null;
                        quesNum++;
                        _countDownController.reset();
                        _countDownController.start();
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScoreScreen(
                                totalQus: totalQus,
                                correctAns: count,
                              ),
                            ));
                      }
                      setState(() {});
                    },
                    timeFormatterFunction:
                        (defaultFormatterFunction, duration) {
                      if (duration.inSeconds == 0) {
                        return 0;
                      } else {
                        return Function.apply(
                            defaultFormatterFunction, [duration]);
                      }
                    },
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),

            //Answer Options

            Column(
              children: List.generate(
                4,
                (index) => InkWell(
                  onTap: () {
                    if (selected == null) {
                      selected = index;
                      _countDownController.pause();
                      if (selected ==
                          DummyDb.Questions[widget.category][quesNum]
                              ["answerIndex"]) {
                        count++;
                      }
                    }

                    setState(() {});
                  },
                  child: AnswerBar(
                    category: widget.category,
                    selected: selected,
                    ind: index,
                    quesNum: quesNum,
                  ),
                ),
              ),
            ),

            //Next Question
            if (selected != null)
              InkWell(
                onTap: () {
                  if (quesNum < totalQus) {
                    selected = null;
                    _countDownController.reset();
                    _countDownController.start();
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScoreScreen(
                            totalQus: totalQus + 1,
                            correctAns: count,
                          ),
                        ));
                  }
                  setState(() {});
                },
                child: _nextButton(),
              )
          ],
        ),
      ),
    );
  }
}

Widget _questionArea(
    int quesNum, String _category, int? selected, int totalQus) {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.all(20),
        width: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade800),
        child: Stack(
          children: [
            LinearProgressBar(
              maxSteps: totalQus,
              progressType: LinearProgressBar.progressTypeLinear,
              currentStep: quesNum,
              progressColor: Colors.white,
              backgroundColor: Colors.black,
              borderRadius: BorderRadius.circular(10), //  NEW
            ),
            Center(
              child: Text(
                "${DummyDb.Questions[_category][quesNum]["ques"]}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      if (selected == DummyDb.Questions[_category][quesNum]["answerIndex"])
        Lottie.asset("assets/animations/lottie/rightAnswer.json"),
    ],
  );
}

Widget _nextButton() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.green,
      borderRadius: BorderRadius.circular(10),
    ),
    width: double.infinity,
    height: 50,
    alignment: Alignment.center,
    child: Text(
      "Next",
      style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
