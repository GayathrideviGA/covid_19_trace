import 'package:animated_splash_screen/animated_splash_screen.dart';


import 'package:covid19_trace/screens/signin_screen.dart';
import 'package:covid19_trace/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid_19 Track',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png'), fit: BoxFit.contain)),
              ),
            ),
            nextScreen: Login(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.scale,
            backgroundColor: ColorConstants.primaryColor));
  }
}
