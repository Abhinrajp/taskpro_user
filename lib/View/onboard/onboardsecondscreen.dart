import 'package:flutter/material.dart';
import 'package:taskpro_user/Utility/consts.dart';

class Onboardsecondscreen extends StatelessWidget {
  const Onboardsecondscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 120, left: 140),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'taskpro',
                  style: TextStyle(
                      color: primarycolour, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 80),
                  child: Text('skip >', style: TextStyle(fontSize: 11)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Trusted support for everything on your',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const Text(
            'task list',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
                height: 170, child: Image.asset('lib/Asset/eletrician.png')),
            SizedBox(height: 170, child: Image.asset('lib/Asset/painter.png')),
          ]),
          SizedBox(height: 170, child: Image.asset('lib/Asset/plumber.png'))
        ],
      ),
    );
  }
}
