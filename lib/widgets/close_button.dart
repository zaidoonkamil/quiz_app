import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_quiz2/screens/home_screen.dart';
import 'package:simple_quiz2/utility/card_details.dart';

// ignore: must_be_immutable
class CustomCloseButton extends StatelessWidget {
   const CustomCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: KprimarySupTextColor),
          ),
          child: InkWell(
            onTap: () {
             Get.offAll(HomeScreen());
            },
            child:  Icon(
              Icons.close_rounded,
              color: KprimarySupTextColor ,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
