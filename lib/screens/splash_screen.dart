import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:simple_quiz2/utility/card_details.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: KprimaryScafoldColor,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: Get.width * 0.75,
              height: Get.width * 0.75,
              child: Lottie.asset("assets/lottie/hello.json"),
            ),
          ),
        ),
      ),
    );
  }
}
