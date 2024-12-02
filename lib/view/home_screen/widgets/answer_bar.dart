import 'package:flutter/material.dart';
import 'package:test_4/dummy_db.dart';

class AnswerBar extends StatelessWidget {
  AnswerBar(
      {super.key,
      required this.ind,
      required this.quesNum,
      this.selected,
      required this.category});

  final int ind;
  final int quesNum;
  final int? selected;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: getColor(ind)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${DummyDb.Questions[category][quesNum]["options"][ind]}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            Icon(Icons.circle_outlined, color: Colors.white)
          ],
        ),
      ),
    );
  }

  Color getColor(int index) {
    if (ind == selected) {
      if (selected == DummyDb.Questions[category][quesNum]["answerIndex"]) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      if (selected != null &&
          ind == DummyDb.Questions[category][quesNum]["answerIndex"]) {
        return Colors.green;
      } else {
        return Colors.white;
      }
    }
  }
}
