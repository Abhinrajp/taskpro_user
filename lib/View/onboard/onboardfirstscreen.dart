import 'package:flutter/material.dart';
import 'package:taskpro_user/View/Authentication/signup/singnupscreen.dart';

class Onboardfirstscreen extends StatelessWidget {
  const Onboardfirstscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(17)),
                        child: Image.asset(
                          'lib/Asset/logoimaget.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Daily life',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        )),
                    const Text('made easy',
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      child: const Text(
                        'Get Started >',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Singnupscreen(),
                            ),
                            (route) => false);
                      },
                    )
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
