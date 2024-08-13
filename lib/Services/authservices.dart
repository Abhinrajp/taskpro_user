import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskpro_user/Model/modelclass.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/Authentication/login/loginscreen.dart';
import 'package:taskpro_user/View/Authentication/signup/verifyemailscreen.dart';
import 'package:taskpro_user/View/Home/homebottomnavigationbar.dart';
import 'package:taskpro_user/Widget/Popups/showwidget.dart';

class Authservices {
  signout(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser!.email;
    await FirebaseAuth.instance.signOut();
    showCustomSnackBar(
        title: 'Logout', msg: 'Logout from $user', bgcolor: Colors.red);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Loginscreen(),
      ),
      (route) => false,
    );
  }

  updateuser(Usermodel usermodel) async {
    log('upadate enterd');
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
      'profileimage': usermodel.profileimage,
      'name': usermodel.name,
    });
    log('upadate success');
  }

  resetpass(String email) async {
    if (email.isEmpty) {
      showCustomSnackBar(
          msg: 'Please provide the An mail', title: 'Unable to send Email');
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        showCustomSnackBar(
            msg: 'A Link has been sent to your mail', title: 'Email sended');
      } catch (e) {
        showCustomSnackBar(
            msg: 'Failed to send reset email. Please try again.',
            title: 'Failed to send',
            bgcolor: Colors.red);
      }
    }
  }

  Future<Usermodel> fetchuser() async {
    final user = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    final userdata = Usermodel(data['name'], data['profileimage']);
    return userdata;
  }

  Future<String> fetchuserpass() async {
    final user = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    final pass = data['password'];
    return pass;
  }

  Future<String?> uploadprofileimage(File imageFile, String userId) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profiles/$userId.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  googlesignin(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleaccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleauth =
          await googleaccount?.authentication;
      final credental = GoogleAuthProvider.credential(
          accessToken: googleauth?.accessToken, idToken: googleauth?.idToken);
      await FirebaseAuth.instance.signInWithCredential(credental);
      showCustomSnackBar(
          bgcolor: primarycolour,
          title: 'Account created',
          msg: 'Account created successfully');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const Homebottomnavigationbar()),
          (route) => false);
    } catch (e) {
      log(e.toString());
      showCustomSnackBar(
          bgcolor: primarycolour, title: 'Error', msg: e.toString());
    }
  }

  sigup(String email, String password, BuildContext context) async {
    log(email);
    log(password);

    String username = email.split('@')[0];
    String firstLetter = email[0].toUpperCase();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      log(username);
      log(firstLetter);
      User? user = userCredential.user;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'id': user?.uid,
        'name': username,
        'profileimage': firstLetter,
        'password': password
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Verifyemailscreen()),
        (route) => false,
      );
    } catch (e) {
      showCustomSnackBar(
          bgcolor: primarycolour, title: 'Error', msg: e.toString());
    }
  }

  changepassword(BuildContext context, String newpass, String pass) async {
    log(newpass);
    try {
      log('entered to try');
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        AuthCredential credential =
            EmailAuthProvider.credential(email: user.email!, password: pass);
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newpass);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'password': newpass});

        showCustomSnackBar(
            bgcolor: primarycolour,
            title: 'Password changed',
            msg: 'Password changed successfully Login again');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Loginscreen(),
          ),
          (route) => false,
        );
        await FirebaseAuth.instance.signOut();
      } else {
        log('user not found');
      }
    } catch (e) {
      log(e.toString());
      showCustomSnackBar(
          bgcolor: primarycolour, msg: e.toString(), title: 'Error');
    }
  }
}
