import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:simple_quiz2/controllers/quiz_controller.dart';
import 'package:simple_quiz2/models/questionModel.dart';
import 'package:simple_quiz2/screens/quiz_screen.dart';
import 'package:simple_quiz2/utility/card_details.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    Key? key,
    required this.questions,
    required this.nameIndex,
  }) : super(key: key);

  final List<questionModel> questions;
  final String nameIndex;
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  final authC = Get.put(NewQuizController());

  var score;

  getData(String namePage){
    FirebaseFirestore.instance
        .collection('score').doc(namePage).collection(authC.user.value.email!).
    orderBy('score', descending: true).limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          score = doc["score"] ?? '';
        });

      });
    }).catchError((onEroor) {
      print(onEroor.toString());
    });

  }
  @override
  void initState() {
    super.initState();
    getData(widget.nameIndex);
    score ??= 0;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 1), () {
        getQuestions();
      });
    });


  }

  Future<bool> checkConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  void getQuestions() async {
    bool result = await checkConnectivity();
    if (result) {
      // ignore: use_build_context_synchronously
      Get.to(
          QuizScreen(
        questions: widget.questions,
        nameIndex: widget.nameIndex,
            score: score!,
      ));

    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'خطأ',
        text: 'الرجاء قم بالاتصال بالانترنت واعادة المحاولة لاحقا',
          onConfirmBtnTap: (){
            Navigator.pop(context);
            Navigator.pop(context);
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:KprimaryScafoldColor,
      body: SafeArea(
        child: Center(
          child: LoadingAnimationWidget.halfTriangleDot(
            color: KprimaryColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}