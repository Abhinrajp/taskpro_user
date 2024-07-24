import 'package:get/get.dart';

class Appstatecontroller extends GetxController {
  var currentindex = 0.obs;
  int get getcurrentindex => currentindex.value;
  void setcurrentindex(int index) {
    currentindex.value = index;
  }
}
