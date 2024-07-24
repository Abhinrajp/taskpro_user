import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taskpro_user/View/Authentication/singnupscreen.dart';
import 'package:taskpro_user/View/onboard/onboardfirstscreen.dart';
import 'package:taskpro_user/View/onboard/onboardscreenfour.dart';
import 'package:taskpro_user/View/onboard/onboardsecondscreen.dart';
import 'package:taskpro_user/View/onboard/onboardthirdscreen.dart';
import 'package:taskpro_user/Utility/consts.dart';

class Onboardscreen extends StatefulWidget {
  const Onboardscreen({super.key});

  @override
  State<Onboardscreen> createState() => _OnboardscreenState();
}

class _OnboardscreenState extends State<Onboardscreen> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 50),
        child: PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                isLastPage = value == 3;
              });
            },
            children: const [
              Onboardfirstscreen(),
              Onboardsecondscreen(),
              Onboardthirdscreen(),
              Onboardscreenfour()
            ]),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: 50,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: const WormEffect(
                  dotColor: Colors.grey,
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: primarycolour),
              onDotClicked: (index) => controller.animateToPage(index,
                  duration: const Duration(seconds: 1), curve: Curves.linear),
            ),
            isLastPage
                ? GestureDetector(
                    child: const Text('Sign up >'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Singnupscreen(),
                          ),
                          (route) => false);
                    },
                  )
                : GestureDetector(
                    child: const Text('Got it >'),
                    onTap: () {
                      controller.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                  )
          ],
        ),
      ),
    );
  }
}
