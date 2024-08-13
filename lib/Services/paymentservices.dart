import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskpro_user/Widget/Popups/alertwidget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:taskpro_user/Widget/Rating/rating.dart';

class Paymentservices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Ratingofworker ratingofworker = Ratingofworker();
  final Alertmessages alertmessages = Alertmessages();
  paymentsucess(BuildContext context, PaymentSuccessResponse responce,
      Map<String, dynamic> worker) async {
    int works = int.parse(worker['totalwork']);
    int totalworks = works + 1;
    await firestore
        .collection('workers')
        .doc(worker['id'])
        .update({'totalwork': totalworks.toString()});
    alertmessages.alertsmsg(
      context,
      QuickAlertType.success,
      'Payment Success',
      () {
        Navigator.pop(context);
        ratingofworker.ratingbox(context, worker);
      },
    );
  }

  paymentfailed(BuildContext context, PaymentFailureResponse responce) {
    alertmessages.alertsmsg(
      context,
      QuickAlertType.error,
      'Payment Failed',
      () {
        Navigator.pop(context);
      },
    );
  }

  externalwaller(BuildContext context, ExternalWalletResponse responce) {
    alertmessages
        .alertsmsg(context, QuickAlertType.confirm, 'Open External wallet', () {
      Navigator.pop(context);
    });
  }

  opencheout(BuildContext context, Razorpay razorpay, String amount) async {
    String total = (int.parse(amount) * 100).toString();
    log(total);
    var option = {
      'key': 'rzp_test_gRX7zwlpkIDTGl',
      'amount': total,
      'name': 'taskpro',
      'description': 'Payment of schedule work',
      'prefill': {
        'contact': '8592943588',
        'email': 'abhinraj8086@gmail.com',
      }
    };
    try {
      razorpay.open(option);
    } catch (e) {
      log(e.toString());
      alertmessages.alertsmsg(
          context, QuickAlertType.error, 'Error opening Razorpay', () {
        Navigator.pop(context);
      });
    }
  }
}
