// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:taskpro_user/Controller/appstatecontroller.dart';
// import 'package:taskpro_user/Model/modelclass.dart';
// import 'package:taskpro_user/Services/authservices.dart';
// import 'package:taskpro_user/Utility/consts.dart';
// import 'package:taskpro_user/Widget/showwidget.dart';
// import 'package:taskpro_user/Widget/simplewidgets.dart';

// class Profilescreen extends StatefulWidget {
//   const Profilescreen({super.key});

//   @override
//   State<Profilescreen> createState() => _ProfilescreenState();
// }

// class _ProfilescreenState extends State<Profilescreen> {
//   final Appstatecontroller appstatecontroller = Get.find<Appstatecontroller>();
//   final user = FirebaseAuth.instance.currentUser;
//   final namecontroller = TextEditingController();
//   final profileimagecontroller = TextEditingController();
//   final locationcontroller = TextEditingController();
//   Authservices authservices = Authservices();
//   @override
//   void initState() {
//     super.initState();
//     loaduser();
//   }

//   loaduser() async {
//     final userdata = await authservices.fetchuser();

//     appstatecontroller.setname(userdata.name);
//     appstatecontroller.setlocation(userdata.location);
//     appstatecontroller.setimage(userdata.profileimage);
//     namecontroller.text = userdata.name;
//     locationcontroller.text = userdata.location;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(children: [
//           SizedBox(
//               height: double.infinity,
//               width: double.infinity,
//               child: Obx(() {
//                 final imageUrl = appstatecontroller.image.value;
//                 return imageUrl.isNotEmpty
//                     ? Image.network(imageUrl, fit: BoxFit.cover)
//                     : Image.asset('lib/Asset/userprofile.png',
//                         fit: BoxFit.cover);
//               })),
//           Positioned.fill(
//               child: SingleChildScrollView(
//                   child: Column(children: [
//             const SizedBox(height: 360),
//             Container(
//                 height: 330,
//                 width: 330,
//                 decoration: const BoxDecoration(
//                     color: primarycolour,
//                     borderRadius: BorderRadius.only(
//                         bottomRight: Radius.circular(50),
//                         topLeft: Radius.circular(50))),
//                 child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Stack(children: [
//                                   Obx(() {
//                                     final imagefile =
//                                         appstatecontroller.imageFile.value;
//                                     final imageUrl =
//                                         appstatecontroller.image.value;
//                                     return CircleAvatar(
//                                         radius: 50,
//                                         backgroundImage: imagefile != null
//                                             ? FileImage(imagefile)
//                                             : imageUrl.isNotEmpty
//                                                 ? NetworkImage(imageUrl)
//                                                 : const AssetImage(
//                                                     'lib/Asset/userprofile.png'));
//                                   }),
//                                   Positioned(
//                                       top: 63,
//                                       left: 60,
//                                       child: Obx(() => appstatecontroller
//                                                   .iconvisible.value ==
//                                               true
                                          // ? const CustomImageButton()
//                                           : const SizedBox()))
//                                 ]),
//                                 const SizedBox(width: 20),
//                                 Expanded(
//                                     child: Obx(() => Customprofileformfeild(
//                                         onChanged: (value) {
//                                           appstatecontroller.setname(value);
//                                         },
//                                         readonly:
//                                             appstatecontroller.readonly.value,
//                                         namecontroller: namecontroller,
//                                         fontWeight: FontWeight.bold,
//                                         fontsize: 22)))
//                               ]),
//                           const SizedBox(height: 20),
//                           Obx(() => Customprofileformfeild(
//                               onChanged: (value) {
//                                 appstatecontroller.setlocation(value);
//                               },
//                               readonly: appstatecontroller.readonly.value,
//                               namecontroller: locationcontroller)),
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 const SizedBox(width: 11),
//                                 Customtext(
//                                     text: user!.email!, color: Colors.white),
//                                 const SizedBox(width: 15),
//                                 IconButton(
//                                     onPressed: () {
//                                       appstatecontroller.readonly.value = false;
//                                       appstatecontroller.iconvisible.value =
//                                           true;
//                                     },
//                                     icon: const Icon(Icons.edit,
//                                         color: Colors.white))
//                               ]),
//                           Obx(() => appstatecontroller.readonly.value == false
//                               ? Customsubmitbutton(
//                                   widget: const Text('save',
//                                       style: TextStyle(
//                                           color: primarycolour,
//                                           fontWeight: FontWeight.bold)),
//                                   size: const Size(300, 39),
//                                   color: Colors.white,
//                                   ontap: () {
//                                     updateuserdata();
//                                   })
//                               : const SizedBox())
//                         ])))
//           ])))
//         ]),
//         floatingActionButton: IconButton(
//             onPressed: () async {
//               alertboxforconfirmation(context, authservices.signout);
//             },
//             icon: const Icon(Icons.exit_to_app, color: Colors.white)));
//   }

//   updateuserdata() async {
//     String? imageUrl;
//     var userrmodel = Usermodel(namecontroller.text, locationcontroller.text,
//         appstatecontroller.image.value);
//     if (appstatecontroller.imageFile.value != null) {
//       imageUrl = await authservices.uploadprofileimage(
//           appstatecontroller.imageFile.value!, user!.uid);
//       if (imageUrl != null) {
//         userrmodel.profileimage = imageUrl;
//       }
//     }
//     authservices.updateuser(userrmodel);
//     appstatecontroller.setname(userrmodel.name);
//     appstatecontroller.setlocation(userrmodel.location);
//     appstatecontroller.setimage(userrmodel.profileimage!);
//     appstatecontroller.readonly.value = true;
//     appstatecontroller.iconvisible.value = false;
//   }
// }
