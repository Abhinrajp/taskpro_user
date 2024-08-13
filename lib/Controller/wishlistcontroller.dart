import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Wishlistcontroller extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Stream<List<Map<String, dynamic>>> get wishliststream {
    if (user != null) {
      return firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('wishlist')
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => doc.data(),
                )
                .toList(),
          );
    } else {
      return const Stream.empty();
    }
  }

  Future<void> addtowishlist(Map<String, dynamic> worker) async {
    if (user != null) {
      await firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('wishlist')
          .doc(worker['id'])
          .set(worker);
    }
  }

  Future<void> removefromwishlist(Map<String, dynamic> worker) async {
    if (user != null) {
      await firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('wishlist')
          .doc(worker['id'])
          .delete();
    }
  }

  Future<bool> isInWishlist(Map<String, dynamic> worker) async {
    if (user != null) {
      DocumentSnapshot doc = await firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .collection('wishlist')
          .doc(worker['id'])
          .get();
      return doc.exists;
    }
    return false;
  }
}
