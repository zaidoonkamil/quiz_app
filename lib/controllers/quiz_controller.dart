import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_quiz2/controllers/score_fire.dart';
import 'package:simple_quiz2/models/questionModel.dart';
import 'package:simple_quiz2/models/users_model.dart';
import 'package:simple_quiz2/screens/auth/login/views/login_view.dart';
import 'package:simple_quiz2/screens/home_screen.dart';
int? lengthQuestionsArt;

class NewQuizController extends GetxController {
  int? lengthQuestionsTv;
  int? lengthQuestionsSport;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  UserCredential? userCredential;

  var isAuth = false.obs;
  var counter = 3.obs;

  var user = UsersModel().obs;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;


  @override
  void onInit() {
    quizQuestionSports();
    lengthQuestionsArt=questionsSports.length;
    lengthQuestionsTv=questionsFamous.length;
    lengthQuestionsSport=questionsCulture.length;
    super.onInit();
  }

  List<questionModel> questionsSports = [];
  List<questionModel> questionsFamous = [];
  List<questionModel> questionsCulture = [];
  List<questionModel> questionsGeography = [];

  quizQuestionSports() {

    getAllQuestionsSports().then((value) {
      questionsSports = value;
      lengthQuestionsArt=questionsSports.length;
      update();
    });

    getAllQuestionsFamous().then((value) {
      questionsFamous = value;
      update();
    });

    getAllQuestionsCulture().then((value) {
      questionsCulture = value;
      update();
    });

    getAllQuestionsGeography().then((value) {
      questionsGeography = value;
      update();
    });
  }

  static Future<List<questionModel>> getAllQuestionsSports() async {
    final questionsRef = FirebaseFirestore.instance.collection('sports');
    final questionDoc = await questionsRef.get();

    return questionDoc.docs
        .map((e) => questionModel.fromQueryDocumentSnapshot(e))
        .toList();
  }

  static Future<List<questionModel>> getAllQuestionsFamous() async {
    final questionsRef = FirebaseFirestore.instance.collection('famous');
    final questionDoc = await questionsRef.get();

    return questionDoc.docs
        .map((e) => questionModel.fromQueryDocumentSnapshot(e))
        .toList();
  }

  static Future<List<questionModel>> getAllQuestionsCulture() async {
    final questionsRef = FirebaseFirestore.instance.collection('culture');
    final questionDoc = await questionsRef.get();

    return questionDoc.docs
        .map((e) => questionModel.fromQueryDocumentSnapshot(e))
        .toList();
  }
  static Future<List<questionModel>> getAllQuestionsGeography() async {
    final questionsRef = FirebaseFirestore.instance.collection('geography');
    final questionDoc = await questionsRef.get();

    return questionDoc.docs
        .map((e) => questionModel.fromQueryDocumentSnapshot(e))
        .toList();
  }

  Future<void> login(c) async {
      bool result = await InternetConnectionChecker().hasConnection;
    if(result){
    try {
      // Ini untuk handle kebocoran data user sebelum login
      await _googleSignIn.signOut();

      // Ini digunakan untuk mendapatkan google account
      await _googleSignIn.signIn().then((value) =>
      _currentUser = value);

      // ini untuk mengecek status login user
      final isSignIn = await _googleSignIn.isSignedIn();

      if (isSignIn) {
        // kondisi login berhasil
        print("SUDAH BERHASIL LOGIN DENGAN AKUN : ");
        print(_currentUser);

        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("USER CREDENTIAL");
        print(userCredential);

        final box = GetStorage();
        box.write('skipIntro', true);

        // masukan data ke firebase...
        CollectionReference users = fireStore.collection('users');

        final checkuser = await users.doc(_currentUser!.email).get();

        if (checkuser.data() == null) {
          await users.doc(_currentUser!.email).set({
            "uid": userCredential!.user!.uid,
            "name": _currentUser!.displayName,
            "keyName": _currentUser!.displayName!.substring(0, 1).toUpperCase(),
            "email": _currentUser!.email,
            "photoUrl": _currentUser!.photoUrl ?? "noimage",
            "creationTime":
            userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedTime": DateTime.now().toIso8601String(),
          });

          users.doc(_currentUser!.email).collection("chats");
        } else {
          await users.doc(_currentUser!.email).update({
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        user(UsersModel.fromJson(currUserData));

        user.refresh();

        final listChats =
        await users.doc(_currentUser!.email).collection("chats").get();

        if (listChats.docs.isNotEmpty) {
          List<ChatUser> dataListChats = [];
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          });

          user.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          user.update((user) {
            user!.chats = [];
          });
        }

        user.refresh();

        isAuth.value = true;
        Get.offAll(HomeScreen());
      } else {
        print("====================");
        print("TIDAK BERHASIL LOGIN");
      }
    } catch (error) {
      print(error);
    }
  }else{
      QuickAlert.show(
          context: c,
          type: QuickAlertType.error,
          title: 'خطأ',
          text: 'الرجاء قم بالاتصال بالانترنت واعادة المحاولة لاحقا',
          onConfirmBtnTap: (){
            Navigator.pop(c);
          }
      );
    }
  }

  Future<bool> autoLogin() async {
    // kita akan mengubah isAuth => true => autoLogin
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        await _googleSignIn
            .signInSilently()
            .then((value) => _currentUser = value);
        final googleAuth = await _currentUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        print("USER CREDENTIAL");
        print(userCredential);

        // masukan data ke firebase...
        CollectionReference users = fireStore.collection('users');

        await users.doc(_currentUser!.email).update({
          "lastSignInTime":
          userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        final currUser = await users.doc(_currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        user(UsersModel.fromJson(currUserData));

        user.refresh();

        final listChats =
        await users.doc(_currentUser!.email).collection("chats").get();

        if (listChats.docs.length != 0) {
          List<ChatUser> dataListChats = [];
          listChats.docs.forEach((element) {
            var dataDocChat = element.data();
            var dataDocChatId = element.id;
            dataListChats.add(ChatUser(
              chatId: dataDocChatId,
              connection: dataDocChat["connection"],
              lastTime: dataDocChat["lastTime"],
              total_unread: dataDocChat["total_unread"],
            ));
          });

          user.update((user) {
            user!.chats = dataListChats;
          });
        } else {
          user.update((user) {
            user!.chats = [];
          });
        }

        user.refresh();

        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAll(LoginView());
  }

  void startAgain() {
    Get.offAll(HomeScreen());
  }


}
