import 'dart:io';
import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';

class Appstatecontroller extends GetxController {
  var currentindex = 0.obs;
  int get getcurrentindex => currentindex.value;
  void setcurrentindex(int index) {
    currentindex.value = index;
  }

  RxBool visi = false.obs;
  RxBool visifi = true.obs;

  void setvisib(bool val, valfi) {
    visi.value = val;
    visifi.value = valfi;
  }

  var name = ''.obs;
  var location = ''.obs;
  var image = ''.obs;
  var imageFile = Rxn<File>();

  void setImageFile(File file) {
    imageFile.value = file;
  }

  setname(String nam) {
    name.value = nam;
  }

  setlocation(String loc) {
    location.value = loc;
  }

  setimage(String img) {
    image.value = img;
  }
}
