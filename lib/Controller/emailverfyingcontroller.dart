import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/View/Home/homebottomnavigationbar.dart';
import 'package:taskpro_user/Widget/Popups/showwidget.dart';

class Emailverfyingcontroller extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Timer? timer;
  bool verficationchecked = false;
  @override
  void onInit() {
    super.onInit();
    startemailverificationcheck();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void startemailverificationcheck() {
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        if (!verficationchecked) {
          await checkemailverification();
        }
      },
    );
  }

  Future<void> sendemail() async {
    User? user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      showCustomSnackBar(
          title: 'Verification Email Sent',
          msg: 'Please check your email for verification.');
    }
  }

  Future<void> checkemailverification() async {
    User? user = auth.currentUser;
    if (user != null) {
      await user.reload();
      user = auth.currentUser;
      if (user!.emailVerified) {
        if (!verficationchecked) {
          verficationchecked = true;
          showCustomSnackBar(
              msg: 'Account created successfully.', title: 'Account created');

          Get.offAll(const Homebottomnavigationbar());
        }
      }
    }
  }
}
