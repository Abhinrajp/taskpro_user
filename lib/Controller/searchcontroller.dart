import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Searchcontroller extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Stream<List<Map<String, dynamic>>> get searchstream {
    return firebaseFirestore.collection('workers').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => doc.data(),
              )
              .toList(),
        );
  }
}
