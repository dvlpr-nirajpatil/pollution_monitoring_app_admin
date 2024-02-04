import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:rsm/consts/consts.dart';
import 'package:rsm/consts/images.dart';
import 'package:rsm/consts/typography.dart';
import 'package:rsm/views/auth_screen/sign_in_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      FirebaseAuth.instance.userChanges().listen(
        (value) {
          if (value == null) {
            Get.off(
              () => SignInScreen(),
              transition: Transition.fadeIn,
              duration: Duration(milliseconds: 500),
            );
          } else {
            Get.offAll(() => Home());
          }
        },
      );
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 250,
              image: AssetImage(
                ig_logo,
              ),
            ),
            20.heightBox,
            "RSM\nPOLYTECHNIC"
                .text
                .size(18)
                .align(TextAlign.center)
                .fontFamily(semibold)
                .make()
          ],
        ),
      ),
    );
  }
}
