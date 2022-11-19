import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:simple_quiz2/controllers/quiz_controller.dart';
import 'package:simple_quiz2/utility/card_details.dart';
import 'package:simple_quiz2/widgets/close_button.dart';
import 'package:simple_quiz2/widgets/custom_button_profile.dart';


class ProfileView extends GetView<NewQuizController> {
  ProfileView({Key? key}) : super(key: key);

  final authC = Get.put(NewQuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KprimaryScafoldColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: CustomCloseButton(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Obx(
                      () =>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                color: KprimaryScafoldColor,
                                width: 175,
                                height: 175,
                                child: CircleAvatar(
                                  radius: 60,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child:  ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: authC.user.value.photoUrl! == "noimage"
                                          ? Image.asset(
                                        "assets/logo/noimage.png",
                                        fit: BoxFit.cover,
                                      )
                                          : Image.network(
                                        authC.user.value.photoUrl!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    ),
                    Obx(
                      () => Text(
                        authC.user.value.name!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      authC.user.value.email!,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Expanded(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0,bottom: 12),
                      child: Divider(height: 1,color: Colors.black54,),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15),
                        child: InkWell(
                          onTap: (){
                            Share.share('Check My Flutter App://example.com', subject: 'Look what I made!');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:  const [
                              Text('مشاركة التطبيق'),
                              Spacer(),
                              Icon(Icons.share),
                            ],),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0,bottom: 12),
                      child: Divider(height: 1,color: Colors.black54,),
                    ),
                  ],
                ),
              ),
              CustomButtonProfile(
                  onPressed: () {
                     authC.logout();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
