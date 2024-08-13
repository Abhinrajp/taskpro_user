import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Theme/themes.dart';

class Themecontroller extends GetxController {
  Rx<ThemeData> themeData = lightmode.obs;

  ThemeData get currentthemdata => themeData.value;

  void settheme(ThemeData theme) {
    themeData.value = theme;
  }

  void toggeltheme() {
    if (themeData.value.brightness == Brightness.light) {
      settheme(darkmode);
    } else {
      settheme(lightmode);
    }
  }
}
