import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskpro_user/Controller/appstatecontroller.dart';
import 'package:taskpro_user/Model/modelclass.dart';
import 'package:taskpro_user/Services/authservices.dart';
import 'package:taskpro_user/Utility/consts.dart';
import 'package:taskpro_user/View/Home/Profile/Settings/settings.dart';
import 'package:taskpro_user/Widget/Popups/showwidget.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class CustomDrawer extends StatelessWidget {
  final Appstatecontroller appstatecontroller = Get.find<Appstatecontroller>();
  final Authservices authservices = Authservices();
  final TextEditingController nameController = TextEditingController();

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser!.email;
    return Drawer(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(() {
            final profileImage = appstatecontroller.image.value;
            Widget profileWidget;
            if (profileImage.length == 1) {
              profileWidget = CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: Text(
                  profileImage,
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
              );
            } else if (profileImage.isEmpty) {
              profileWidget = const CircleAvatar(backgroundColor: Colors.grey);
            } else {
              profileWidget = Image.network(
                profileImage,
                height: 100.0,
                width: 100,
                fit: BoxFit.cover,
              );
            }
            return Stack(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Customtext(
                    text: appstatecontroller.name.value,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontsize: 13,
                  ),
                  accountEmail: Customtext(
                    text: email!,
                    color: Colors.white.withOpacity(.9),
                    fontWeight: FontWeight.w400,
                    fontsize: 12,
                  ),
                  currentAccountPicture:
                      CircleAvatar(child: ClipOval(child: profileWidget)),
                  decoration: const BoxDecoration(
                    color: primarycolour,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('lib/Asset/user-bg.jpg'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 250,
                  child: IconButton(
                    onPressed: () {
                      showEditProfileDialog(context);
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ],
            );
          }),
          const ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Customtext(text: 'Privacy'),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settingsscreen(),
                ),
              );
            },
            leading: const Icon(Icons.settings),
            title: const Customtext(
              text: 'Settings',
            ),
          ),
          const ListTile(
            leading: Icon(Icons.share),
            title: Customtext(text: 'Share'),
          ),
          ListTile(
            leading: const Icon(Icons.light_mode_outlined),
            title: const Customtext(text: 'Dark mode'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.toggle_off_outlined),
            ),
          ),
          const SizedBox(height: 180),
          ListTile(
            onTap: () {
              authservices.signout(context);
            },
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Customtext(text: 'Logout'),
          ),
        ],
      ),
    );
  }

  void showEditProfileDialog(BuildContext context) {
    nameController.text = appstatecontroller.name.value;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Customtext(
              text: 'Edit profile',
              fontWeight: FontWeight.bold,
              fontsize: 16,
              color: Colors.white,
            ),
            Icon(Icons.edit_attributes, color: Colors.white),
          ],
        ),
        content: SizedBox(
          height: 280,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Obx(() {
                  final imagefile = appstatecontroller.imageFile.value;
                  final imageUrl = appstatecontroller.image.value;
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: imagefile != null
                            ? FileImage(imagefile)
                            : imageUrl.isNotEmpty
                                ? NetworkImage(imageUrl) as ImageProvider
                                : const AssetImage(
                                    'lib/Asset/userprofile.png',
                                  ),
                      ),
                      const Positioned(
                        top: 65,
                        left: 63,
                        child: CustomImageButton(),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                Customprofileformfeild(
                  namecontroller: nameController,
                  onChanged: (value) {
                    appstatecontroller.setname(value);
                  },
                  fontWeight: FontWeight.bold,
                  fontsize: 16,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    updateuserdata(context);
                  },
                  child: const Customtext(
                    text: 'Done',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black.withOpacity(.7),
      ),
    );
  }

  void updateuserdata(BuildContext context) async {
    log('Update entered to drawer function');
    final user = FirebaseAuth.instance.currentUser;
    String? imageUrl;

    var usermodel = Usermodel(
      nameController.text,
      appstatecontroller.image.value,
    );

    if (appstatecontroller.imageFile.value != null) {
      log('Image file is not null');
      imageUrl = await authservices.uploadprofileimage(
        appstatecontroller.imageFile.value!,
        user!.uid,
      );
      if (imageUrl != null) {
        log('Image URL is not null');
        usermodel.profileimage = imageUrl;
      }
      log('Image URL: $imageUrl');
    }

    authservices.updateuser(usermodel);
    appstatecontroller.setname(usermodel.name);
    appstatecontroller.setimage(usermodel.profileimage);
    Navigator.pop(context);
  }
}
