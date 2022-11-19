import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_quiz2/controllers/quiz_controller.dart';
import 'package:simple_quiz2/utility/card_details.dart';
import 'package:simple_quiz2/widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KprimaryScafoldColor,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: GetBuilder<NewQuizController>(
                  init: Get.put(NewQuizController()),
                  builder: (controller) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'مستواك هو ',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: KprimarySupTextColor,
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        '$score',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: KprimarySupTextColor,
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          onPressed: () => controller.startAgain(),
                          text: 'البدء مجددا'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
