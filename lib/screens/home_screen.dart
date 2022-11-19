import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_quiz2/controllers/quiz_controller.dart';
import 'package:simple_quiz2/controllers/score_fire.dart';
import 'package:simple_quiz2/screens/loading_screen.dart';
import 'package:simple_quiz2/utility/card_details.dart';

import 'profile/views/profile_view.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? nameQuizScrean;

  final authC = Get.put(NewQuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KprimaryScafoldColor,
      body: SafeArea(
        child: GetBuilder<NewQuizController>(
            init: NewQuizController(),
            builder: (controller) {
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04,
                      left: 20,
                      right: 20,
                      bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(ProfileView());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: KprimaryScafoldColor,
                              width: 40,
                              height: 40,
                              child: CircleAvatar(
                                backgroundColor:KprimaryScafoldColor,
                                radius: 60,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: controller.user.value.photoUrl! ==
                                            "noimage"
                                        ? const Icon(Icons.person_pin)
                                        : Image.network(
                                            authC.user.value.photoUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'هيا نبدأ اللعب',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.08,
                              fontWeight: FontWeight.w900,
                              color: KprimaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ' ! كن الاول',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          color: KprimarySupTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ListView.builder(
                        itemCount: cardDetailList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 130,
                            child: GestureDetector(
                              onTap: () {

                                if (index == 0) {
                                  nameQuizScrean = 'sports';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoadingScreen(
                                              questions:
                                                  controller.questionsSports,
                                              nameIndex: nameQuizScrean!,
                                            )),
                                  );
                                } else if (index == 1) {
                                  nameQuizScrean = 'famous';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoadingScreen(
                                              questions:
                                                  controller.questionsFamous,
                                              nameIndex: nameQuizScrean!,
                                            )),
                                  );
                                } else if (index == 2) {
                                  nameQuizScrean = 'culture';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoadingScreen(
                                              questions:
                                                  controller.questionsCulture,
                                              nameIndex: nameQuizScrean!,
                                            )),
                                  );
                                } else if (index == 3) {
                                  nameQuizScrean = 'geography';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoadingScreen(
                                              questions:
                                                  controller.questionsGeography,
                                              nameIndex: nameQuizScrean!,
                                            )),
                                  );
                                } else {
                                  null;
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: cardDetailList[index].gradients,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(1, 3),
                                      blurRadius: 7,
                                      spreadRadius: 5,
                                      color: cardDetailList[index].shadowColor,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    const Spacer(),
                                    Text(
                                      cardDetailList[index].title,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    Image.asset(
                                      cardDetailList[index].iconAssetName,
                                      scale: 3,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
