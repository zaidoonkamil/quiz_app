import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:simple_quiz2/controllers/quiz_controller.dart';

class ScoreFire {

  final authC = Get.put(NewQuizController());

  Future<void> addScore(int score,String namePage) {
    CollectionReference score = FirebaseFirestore.instance.
    collection('score').doc(namePage).collection(authC.user.value.email!);

    // Call the user's CollectionReference to add a new user
    return score
        .add({
      'score': score,
    }).then((value) => print("score Added"))
        .catchError((error) => print("Failed to add score: $error"));
  }

    getData(String namePage){
     FirebaseFirestore.instance
          .collection('score').doc(namePage).collection(authC.user.value.email!).
      orderBy('score', descending: true).limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          final score = doc["score"] ?? '';
        });
      }).catchError((onEroor) {
        print(onEroor.toString());
      });
}

}
