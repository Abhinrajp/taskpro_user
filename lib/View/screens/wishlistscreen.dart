import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskpro_user/Controller/wishlistcontroller.dart';
import 'package:taskpro_user/View/Home/workerproflle.dart';
import 'package:taskpro_user/Widget/Popups/showwidget.dart';
import 'package:taskpro_user/Widget/simplewidgets.dart';

class Wishlistscreen extends StatefulWidget {
  const Wishlistscreen({super.key});

  @override
  State<Wishlistscreen> createState() => _WishlistscreenState();
}

class _WishlistscreenState extends State<Wishlistscreen> {
  final Wishlistcontroller wishlistcontroller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(child: body(wishlistcontroller)),
    );
  }
}

AppBar appBar() {
  return AppBar(
    title: const Customtext(
      text: 'Favourite',
      fontWeight: FontWeight.bold,
      fontsize: 20,
    ),
    centerTitle: true,
  );
}

Widget body(Wishlistcontroller wishlistcontroller) {
  return StreamBuilder(
      stream: wishlistcontroller.wishliststream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                height: 220,
                width: 220,
                child: Image.asset('lib/Asset/Emptyfav.png')),
            const Customtext(
                text: 'No favourite worker',
                fontWeight: FontWeight.bold,
                fontsize: 17),
            const Customtext(
                text: 'Try to add someone',
                fontWeight: FontWeight.bold,
                fontsize: 12)
          ]);
        }
        var wislist = snapshot.data;
        return ListView.builder(
            itemBuilder: (context, index) {
              var worker = wislist[index];
              return ListTile(
                  minLeadingWidth: 35,
                  leading: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(worker['profileImageUrl'])),
                  title: Customtext(
                      text: '${worker['firstName']} ${worker['lastName']}',
                      fontWeight: FontWeight.bold,
                      fontsize: 14),
                  subtitle: Customtext(
                      text: worker['workType'],
                      color: Colors.grey,
                      fontsize: 12),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Workerproflle(worker: worker)));
                  },
                  trailing: IconButton(
                      onPressed: () {
                        wishlistcontroller.removefromwishlist(worker);
                        showCustomSnackBar(
                            title: 'Removed from favourite',
                            msg: 'Worker removed from favourite');
                      },
                      icon: const Icon(Icons.favorite)));
            },
            itemCount: wislist!.length);
      });
}
