import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'taskpro user',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primarycolour),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Wrapper(),
    );
  }
}
