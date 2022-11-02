import 'package:electronic_shop/screens/Landing_screen.dart';
import 'package:electronic_shop/screens/web_screen/WebloginScreen.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains){
        if(constrains.minWidth > 600){
          return WebLoginScreen();
        }else {
          return LandingScreen();
        }
      },
    );
  }
}