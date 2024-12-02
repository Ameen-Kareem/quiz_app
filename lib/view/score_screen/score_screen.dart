import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_4/view/options_screen/options_screen.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen(
      {super.key, required this.correctAns, required this.totalQus});
  final int correctAns;
  final int totalQus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      right: 10, left: 10, bottom: index == 1 ? 30 : 0),
                  child: Icon(
                    Icons.star,
                    size: index == 1 ? 100 : 60,
                    color: getColor(index),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Congratulations",
              style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Score",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "$correctAns / $totalQus",
              style: TextStyle(
                  color: Colors.yellow[700],
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                _retryButton(correctAns, context),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      Share.share(
                          "Check out my score on the quiz app\n $correctAns / $totalQus");
                    },
                    child: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 30,
                    ))
              ],
            ),
          ],
        ));
  }

  getColor(int ind) {
    switch (ind) {
      case 0:
        if (((correctAns / totalQus) * 100) >= 30) {
          return Colors.yellow;
        } else {
          return Colors.grey;
        }
      case 1:
        if (((correctAns / totalQus) * 100) >= 60) {
          return Colors.yellow;
        } else {
          return Colors.grey;
        }
      case 2:
        if (((correctAns / totalQus) * 100) >= 90) {
          return Colors.yellow;
        } else {
          return Colors.grey;
        }
    }
  }
}

Widget _retryButton(int correctAns, BuildContext context) {
  return InkWell(
    onTap: () {
      print("correct Answer $correctAns");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OptionsScreen()));
    },
    child: Container(
      margin: EdgeInsets.all(15),
      height: 60,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 17,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.refresh_outlined,
                color: Colors.white,
              )),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Retry",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),
          )
        ],
      ),
    ),
  );
}
