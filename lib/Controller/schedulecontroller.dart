import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Schedulecontroller extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Stream<List<Map<String, dynamic>>> get schedulestream {
    if (user != null) {
      log('entered to the get schedule of users');
      return firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('schedule')
          .snapshots()
          .map((snapshot) {
        final DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
        String formattedNow = dateFormat.format(DateTime.now());
        DateTime currentDate = dateFormat.parse(formattedNow);
        return snapshot.docs.map((doc) => doc.data()).where((schedule) {
          log(schedule['date']);
          DateTime scheduledate = dateFormat.parse(schedule['date']);
          return scheduledate.isAtSameMomentAs(currentDate) ||
              scheduledate.isAfter(currentDate);
        }).toList();
      });
    } else {
      return const Stream.empty();
    }
  }

  Future<void> addtoschedule(Map<String, dynamic> worker, String date) async {
    if (user != null) {
      DocumentSnapshot userDoc =
          await firebaseFirestore.collection('users').doc(user!.uid).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      worker['date'] = date;

      log('entered to the schedule of users');
      await firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('schedule')
          .doc(worker['id'])
          .set({
        ...worker,
        'date': date,
      });
      await firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('history')
          .doc(worker['id'])
          .set({
        ...worker,
        'date': date,
      });
      log('entered to the schedule of workers');
      await firebaseFirestore
          .collection('workers')
          .doc(worker['id'])
          .collection('schedule')
          .doc(user!.uid)
          .set({
        ...userData,
        'date': date,
      });
      await firebaseFirestore
          .collection('workers')
          .doc(worker['id'])
          .collection('history')
          .doc(user!.uid)
          .set({
        ...userData,
        'date': date,
      });
    }
  }

  Future<void> removefromschdeule(Map<String, dynamic> worker) async {
    if (user != null) {
      await firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('wishlist')
          .doc(worker['id'])
          .delete();
    }
  }

  RxString currentdate = DateTime.now().toString().obs;
  String get getcurrentindex => currentdate.value;
  void setcurrentindex(String index) {
    currentdate.value = index;
  }
}
