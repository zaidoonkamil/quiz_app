import 'package:flutter/material.dart';
import 'package:simple_quiz2/utility/card_details.dart';


class CustomButtonProfile extends StatelessWidget {
  const CustomButtonProfile({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function() onPressed;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: FloatingActionButton.extended(
        backgroundColor: KprimaryColor,
        label: Text(
          'تسجيل خروج',
          style: TextStyle(color: KprimaryScafoldColor),
        ),
        icon:  Icon(
          Icons.exit_to_app,
          color: KprimaryScafoldColor,
          size: 30,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
