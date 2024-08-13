import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:taskpro_user/Utility/consts.dart';

class Alertmessages {
  alertsmsg(BuildContext context, QuickAlertType type, String msg,
      void Function()? onConfirmBtnTap) {
    QuickAlert.show(
      context: context,
      type: type,
      text: msg,
      confirmBtnColor: primarycolour,
      onConfirmBtnTap: onConfirmBtnTap,
    );
  }
}
