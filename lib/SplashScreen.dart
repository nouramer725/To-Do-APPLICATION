import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_application/Home_Layout.dart';
import 'package:todo_application/New_Screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'Montserrat',
      ),
      child: AnimatedSplashScreen(
        splash: Column(
          children: [
            Expanded(
              child: Center(
                child: Lottie.asset(
                  'assets/images/aaa.json',
                  animate: true,
                  repeat: true,
                  reverse: true,
                  fit: BoxFit.cover
                ),
              ),
            ),
          ],
        ),
        nextScreen: const HomeLayout(),
        splashIconSize: 350,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.scaleTransition,
      ),
    );
  }
}