import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_quiz2/controllers/quiz_controller.dart';
import 'package:simple_quiz2/utility/card_details.dart';

class CustomHeartTrier extends StatelessWidget {
   CustomHeartTrier({Key? key,
  //required count
  }) : super(key: key);

  final authC = Get.put(NewQuizController());

 // final int count=5;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewQuizController>(
        init: NewQuizController(),
      builder: (controller)  {
        return Row(
            children:  [
              Text('${controller.counter}',
                style:  TextStyle(
                  color: KprimarySupTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                 ),),
              const SizedBox(width: 6,),
              Icon(
                Icons.favorite,
                size: 30,
                color: controller.counter == 0?KprimarySupTextColor: Colors.red,
              ),
            ],
          );
      }
    );
  }
}
