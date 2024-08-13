import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Controller/themecontroller.dart';
import 'package:taskpro_user/View/Home/Profile/Settings/changepassword.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Settingsscreen extends StatelessWidget {
  Settingsscreen({super.key});
  final Themecontroller themecontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar(),
      body: body(themecontroller, context),
    );
  }
}

AppBar appBar() {
  return AppBar(
      title: const Customtext(
          text: 'Settings', fontWeight: FontWeight.bold, fontsize: 16),
      centerTitle: true);
}

Widget body(Themecontroller themecontroller, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.all(13),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        GestureDetector(
            onTap: () {
              themecontroller.toggeltheme();
            },
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.black12),
                height: 250,
                child: Column(children: [
                  SizedBox(
                      height: 150,
                      child: Image.asset('lib/Asset/darktheme.png')),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Customtext(text: 'Dark mode'),
                        Icon(Icons.light_mode),
                        Customtext(text: 'Ligth mode')
                      ])
                ]))),
        const SizedBox(height: 35),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Changepassword(),
                  ));
            },
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.black12),
                height: 250,
                width: 350,
                child: Column(children: [
                  SizedBox(
                      height: 200,
                      child: Image.asset('lib/Asset/changepass.png')),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Customtext(text: 'Change'),
                        Icon(Icons.lock_reset_outlined),
                        Customtext(text: 'password')
                      ])
                ])))
      ]));
}
