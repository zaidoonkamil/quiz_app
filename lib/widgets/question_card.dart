import 'package:flutter/material.dart';
import 'package:simple_quiz2/models/question_model.dart';
import 'package:simple_quiz2/utility/card_details.dart';

class QuestionCard extends StatelessWidget {

  final QuestionModel questionModel;
  final String? selectedDif;
  const QuestionCard({
    Key? key,
    required this.questionModel,
    this.selectedDif,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionModel.question,
          style: const TextStyle(color: KprimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width:MediaQuery.of(context).size.width ,
          height: MediaQuery.of(context).size.height*0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:  Colors.black26,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
       // ... List.generate(
       //    questionModel.options.length,
       //        (index) =>
       //        Column(
       //          children: [
       //            AnswerOption(
       //                questionId: questionModel.id,
       //                text: questionModel.options[index],
       //                index: index,
       //                onPressed: () =>
       //                    Get.find<QuizController>()
       //                        .checkAnswer(questionModel, index)),
       //            const SizedBox(
       //              height: 15,
       //            ),
       //          ],
       //        ),
       //  ),
      ],
    );
  }
}
