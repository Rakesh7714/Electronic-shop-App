import 'package:electronic_shop/screens/Bottom_screen/bottom_page.dart';
//import 'package:electronic_shop/screens/auth_screen/signupScreen.dart';
//import 'package:electronic_shop/screens/homescreen.dart';
import 'package:electronic_shop/screens/auth_screen/login_screen.dart';
//import 'package:electronic_shop/screens/web_screen/web_main.dart';
import 'package:electronic_shop/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  //const LandingScreen({super.key});
  Future<FirebaseApp> initilize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initilize,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot streamsnapshot) {
                if (streamsnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("${snapshot.error}"),
                    ),
                  );
                }
                if (streamsnapshot.connectionState == ConnectionState.active) {
                  User? user = streamsnapshot.data;
                  if (user == null) {
                    return  LoginScreen();
                  } else {
                    return BottomPage();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Column(children: const [
                      Text(
                        "Checking Authentication ",
                        textAlign: TextAlign.center,
                        style: EcoStyle.boldStyle,
                      ),
                      CircularProgressIndicator(),
                    ]),
                  ),
                );
              });
        }
        return Scaffold(
          body: Center(
            child: Column(children: const [
              Text(
                "Initilazation",
                style: EcoStyle.boldStyle,
              ),
              CircularProgressIndicator(),
            ]),
          ),
        );
      },
    );
  }
}
