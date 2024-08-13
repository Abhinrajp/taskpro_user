import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Controller/themecontroller.dart';
import 'package:taskpro_user/View/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Themecontroller themecontroller = Get.put(Themecontroller());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        title: 'taskpro user',
        theme: themecontroller.currentthemdata,
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
      );
    });
  }
}
