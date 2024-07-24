import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskpro_user/Utility/utilities.dart';

Utilities utilities = Utilities();

resetpassword() async {
  await FirebaseAuth.instance
      .sendPasswordResetEmail(email: utilities.mailcontroller.text);
}
