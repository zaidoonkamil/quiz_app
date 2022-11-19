import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:simple_quiz2/controllers/score_fire.dart';
import 'package:simple_quiz2/controllers/quiz_controller.dart';
import 'package:simple_quiz2/models/questionModel.dart';
import 'package:simple_quiz2/utility/card_details.dart';
import 'package:simple_quiz2/widgets/answer_tile.dart';
import 'package:simple_quiz2/widgets/close_button.dart';

import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
    required this.questions,
    required this.nameIndex,
    required this.score,
  }) : super(key: key);
  final List<questionModel> questions;
  final String nameIndex;
  final int score;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  int _score = 0;

  int _currentIndex = 0;

  String _selectedAnswer = '';

  @override
  void initState() {
    if (widget.score != null) {
      _score = widget.score;
    }
    if (_score == lengthQuestionsArt) {
      if(_score ==1) {
        _score = _score - 1;
      }else{
        _score = _score ;
      }
    }
    _currentIndex =_score;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentIndex];
    return Scaffold(
      backgroundColor: KprimaryScafoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.04,
                bottom: 10,
                right: 16,
                left: 16
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomCloseButton(),
                    Text(
                      'السؤال : $_score',
                      style: TextStyle(
                        color: KprimaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.09,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  currentQuestion.question,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: KprimarySupTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                      border: Border.all(color: KprimaryScafoldColor)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      currentQuestion.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 280,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: currentQuestion.answers.length,
                          itemBuilder: (context, index) {
                            final answer = currentQuestion.answers[index];
                            return AnswerTile(
                              isSelected: answer == _selectedAnswer,
                              answer: answer,
                              correctAnswer: currentQuestion.correctAnswer,
                              onTap: () {
                                setState(() {
                                  _selectedAnswer = answer;
                                });
                                if (answer == currentQuestion.correctAnswer) {
                                  lengthQuestionsArt = (lengthQuestionsArt! - 1);
                                  if (_score != lengthQuestionsArt) {
                                    _score++;
                                    ScoreFire().addScore(
                                      _score,
                                      widget.nameIndex,
                                    );
                                  } else {
                                    _score++;
                                  }
                                }
                                if (answer == currentQuestion.correctAnswer) {
                                  Future.delayed(
                                      const Duration(milliseconds: 100), () {
                                    if (_currentIndex ==
                                        widget.questions.length - 1) {
                                      Get.to(ResultScreen(score: _score));

                                      return;
                                    }
                                    setState(() {
                                      _currentIndex++;
                                      _selectedAnswer = '';
                                    });
                                  });
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'خطأ',
                                    text: 'لقد خطأت في الاجابة الرجاء المحاولة مرة اخرى',
                                  );
                                  Future.delayed(
                                      const Duration(milliseconds: 200), () {
                                    setState(() {
                                      _currentIndex;
                                      _selectedAnswer = '';
                                    });
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
