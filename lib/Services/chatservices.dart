import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taskpro_user/Controller/wishlistcontroller.dart';
import 'package:taskpro_user/Model/messagemodel.dart';

class Chatservices {
  final Wishlistcontroller wishlistcontroller = Get.put(Wishlistcontroller());
  sendmessage(String reciverid, String sendernme, message, type) async {
    final String senderid = FirebaseAuth.instance.currentUser!.uid;
    final String sendername = sendernme;
    final Timestamp timestamp = Timestamp.now();

    Messagemodel messagemodel = Messagemodel(
        senderid: senderid,
        sendername: sendername,
        reciverid: reciverid,
        message: message,
        timestamp: timestamp,
        type: type);

    List<String> ids = [senderid, reciverid];
    ids.sort();
    String chatroomid = ids.join('_');

    DocumentReference chatroomreerence =
        FirebaseFirestore.instance.collection('chat_rooms').doc(chatroomid);

    chatroomreerence.set({
      'participants': ids,
      'message': message,
      'timestamp': timestamp,
    }, SetOptions(merge: true));

    await chatroomreerence.collection('messages').add(messagemodel.tomap());
  }

  Stream<QuerySnapshot> getmessages(String userid, otheruserid) {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join('_');
    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatroomid)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<DocumentSnapshot?> getlastmessage(
      String userid, String otheruserid) async {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join('_');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatroomid)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }
}
