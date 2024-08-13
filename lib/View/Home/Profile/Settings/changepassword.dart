import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro_user/Controller/appstatecontroller.dart';
import 'package:taskpro_user/Services/authservices.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/Widget/Popups/showwidget.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';
import 'package:taskpro_user/Widget/validation/validationforsign.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

final formkey = GlobalKey<FormState>();
final Authservices authservices = Authservices();
final oldpasscontroller = TextEditingController();
final newpasscontroller = TextEditingController();
final newpassconfirmcontroller = TextEditingController();
final Appstatecontroller appstatecontroller = Get.find();

class _ChangepasswordState extends State<Changepassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          primarycolour,
          Colors.white,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar(context),
            body: body(context)));
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white)),
      backgroundColor: Colors.transparent,
      title: const Text('Change Password',
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
      centerTitle: true);
}

Widget body(BuildContext context) {
  return SingleChildScrollView(
      child: Form(
          key: formkey,
          child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(children: [
                const SizedBox(height: 70),
                SizedBox(
                    height: 170,
                    child:
                        LottieBuilder.asset('lib/Asset/resetanimation2.json')),
                const SizedBox(height: 50),
                Obx(() {
                  return Visibility(
                      visible: appstatecontroller.visifi.value,
                      child: Customformfield(
                          controller: oldpasscontroller,
                          validator: validateforpassword,
                          hintext: 'Old password',
                          keybordtype: TextInputType.name,
                          icon: const Icon(Icons.lock_outline)));
                }),
                Obx(() {
                  return Visibility(
                      visible: appstatecontroller.visi.value,
                      child: Column(children: [
                        const Row(children: [
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Customtext(
                                  text: 'Add new password',
                                  fontWeight: FontWeight.bold,
                                  fontsize: 13,
                                  color: Colors.black87))
                        ]),
                        const SizedBox(height: 10),
                        Customformfield(
                          controller: newpasscontroller,
                          validator: validateforpassword,
                          hintext: 'New password',
                          keybordtype: TextInputType.name,
                          icon: const Icon(Icons.lock_outline),
                        ),
                        const SizedBox(height: 10),
                        Customformfield(
                            controller: newpassconfirmcontroller,
                            validator: validateforpassword,
                            hintext: 'Confirm new password',
                            keybordtype: TextInputType.name,
                            icon: const Icon(Icons.lock_outline))
                      ]));
                }),
                const SizedBox(height: 30),
                TextButton(
                    onPressed: () async {
                      var pass = await authservices.fetchuserpass();
                      if (oldpasscontroller.text.isNotEmpty &&
                          oldpasscontroller.text == pass) {
                        appstatecontroller.setvisib(true, false);
                        log(pass);
                        if (newpasscontroller.text.isNotEmpty &&
                            newpassconfirmcontroller.text.isNotEmpty &&
                            newpasscontroller.text ==
                                newpassconfirmcontroller.text) {
                          await changepass(context, pass);
                          oldpasscontroller.clear();
                          newpasscontroller.clear();
                          newpassconfirmcontroller.clear();
                          appstatecontroller.setvisib(false, true);
                        } else {
                          showCustomSnackBar(
                              bgcolor: primarycolour,
                              title: 'Notmatching ',
                              msg: 'Enterd the new password is not match');
                        }
                      } else {
                        log('old pass is empty');
                        showCustomSnackBar(
                            bgcolor: primarycolour,
                            title: 'Wrong password',
                            msg: 'You enterd the wrong password');
                      }
                    },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primarycolour),
                        fixedSize: WidgetStatePropertyAll(Size(350, 60))),
                    child: const Text('Change',
                        style: TextStyle(color: Colors.white))),
                const SizedBox(height: 10)
              ]))));
}

changepass(BuildContext context, String pass) async {
  await authservices.changepassword(
      context, newpassconfirmcontroller.text, pass);
}
