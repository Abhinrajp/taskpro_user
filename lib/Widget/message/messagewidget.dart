import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:taskpro_user/Controller/schedulecontroller.dart';
import 'package:taskpro_user/Services/chatservices.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/Widget/Popups/alertwidget.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

import '../../Services/paymentservices.dart';

class Messagewidget {
  String? date;
  Schedulecontroller schedulecontroller = Get.find();
  final Alertmessages alertmessages = Alertmessages();
  final Paymentservices paymentservices = Paymentservices();
  // late Razorpay razorpay;
  final Chatservices chatservices = Chatservices();
  Widget textmessageitem(Map<String, dynamic> data, bool iscurrentuser) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Container(
            decoration: BoxDecoration(
                color: iscurrentuser
                    ? primarycolour.withOpacity(.8)
                    : Colors.grey.withOpacity(.5),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
                padding: const EdgeInsets.all(14),
                child: Customtext(
                    text: data['message'],
                    color: iscurrentuser ? Colors.white : Colors.black))));
  }

  Widget buttonmessageitem(
      BuildContext context,
      Razorpay razorpay,
      Map<String, dynamic> data,
      bool iscurrentuser,
      Map<String, dynamic> worker,
      String buttontype) {
    var name = worker['firstName'] + ' ' + worker['lastName'];
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Container(
            width: 290,
            decoration: BoxDecoration(
                color: buttontype == 'payment'
                    ? Colors.green.withOpacity(.3)
                    : Colors.blue.withOpacity(.3),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(children: [
                  buttontype == 'payment'
                      ? Customtext(
                          text: '$name have a payment of',
                          fontWeight: FontWeight.bold,
                          fontsize: 14,
                        )
                      : Customtext(
                          text: '$name Scheduled work on',
                          fontWeight: FontWeight.bold,
                          fontsize: 14,
                        ),
                  const SizedBox(height: 10),
                  buttontype == 'payment'
                      ? Customtext(
                          text: '₹ ${data['message']}',
                          fontWeight: FontWeight.w900,
                          fontsize: 16)
                      : Customtext(
                          text: data['message'],
                          fontWeight: FontWeight.w900,
                          fontsize: 16),
                  const SizedBox(height: 10),
                  const Divider(height: 0, color: Colors.black),
                  const SizedBox(height: 5),
                  SizedBox(
                      height: 40,
                      child: buttontype == 'payment'
                          ? TextButton(
                              onPressed: () {
                                paymentservices.opencheout(
                                    context, razorpay, data['message']);
                              },
                              child: const Customtext(
                                  text: 'Pay now',
                                  fontWeight: FontWeight.bold,
                                  fontsize: 17))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                  TextButton(
                                      onPressed: () {
                                        log('buttonpressed');
                                      },
                                      child: const Customtext(
                                          text: 'Cancel',
                                          fontWeight: FontWeight.bold,
                                          fontsize: 16)),
                                  TextButton(
                                      onPressed: () {
                                        date = data['message'];
                                        log('buttonpressed');
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                    backgroundColor:
                                                        primarycolour
                                                            .withOpacity(.9),
                                                    title: const Customtext(
                                                        text:
                                                            'Do you want to confirm this work',
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontsize: 14),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Customtext(
                                                                  text: 'No',
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontsize:
                                                                      14)),
                                                      TextButton(
                                                          onPressed: () {
                                                            schedulecontroller
                                                                .addtoschedule(
                                                                    worker,
                                                                    date!);
                                                            Navigator.pop(
                                                                context);
                                                            alertmessages
                                                                .alertsmsg(
                                                              context,
                                                              QuickAlertType
                                                                  .success,
                                                              'Work scheduled Successfully',
                                                              () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            );
                                                          },
                                                          child:
                                                              const Customtext(
                                                                  text: 'Yes',
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontsize: 14))
                                                    ]));
                                      },
                                      child: const Customtext(
                                          text: 'Confirm',
                                          fontWeight: FontWeight.bold,
                                          fontsize: 16))
                                ]))
                ]))));
  }

  Widget messageitem(BuildContext context, Razorpay razorpay,
      DocumentSnapshot doc, Map<String, dynamic> worker) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool iscurrentuser =
        data['senderid'] == FirebaseAuth.instance.currentUser!.uid;
    String buttontype = data['type'];
    return Column(
        crossAxisAlignment:
            iscurrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          data['type'] == 'text'
              ? textmessageitem(data, iscurrentuser)
              : buttonmessageitem(
                  context, razorpay, data, iscurrentuser, worker, buttontype)
        ]);
  }

  Widget inputmessage(
      TextEditingController messagecontroller, void Function()? sendmessage) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
              child: TextFormField(
            minLines: 1,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            controller: messagecontroller,
            decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 13),
                filled: true,
                fillColor: Colors.grey.withOpacity(.2),
                hintText: 'Type something ...',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
                    borderRadius: const BorderRadius.all(Radius.circular(50)))),
          )),
          const SizedBox(width: 8),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primarycolour),
                  minimumSize: WidgetStatePropertyAll(Size(10, 60))),
              onPressed: sendmessage,
              child:
                  const Icon(Icons.send_rounded, size: 28, color: Colors.white))
        ]));
  }

  Widget messagelist(Map<String, dynamic> worker, Razorpay razorpay) {
    String semderid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: chatservices.getmessages(worker['id'], semderid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Customtext(text: snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
              children: snapshot.data!.docs
                  .map((doc) => messageitem(context, razorpay, doc, worker))
                  .toList());
        });
  }
}
