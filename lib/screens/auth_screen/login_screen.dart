import 'package:electronic_shop/screens/homescreen.dart';
import 'package:electronic_shop/screens/auth_screen/signupScreen.dart';
import 'package:electronic_shop/utils/styles.dart';
import 'package:electronic_shop/widgets/button.dart';
import 'package:electronic_shop/widgets/shoptextfield.dart';
import 'package:flutter/material.dart';
import 'package:electronic_shop/services/Firebase_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  bool isPassword = true;
  bool isreTypepassword = true;
  bool formstateLoading = false;
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  // TextEditingController retype = TextEditingController();

  Future<void> shopDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              ButtonDesign(
                title: 'CLOSE',
                onPress: (() {
                  Navigator.pop(context);
                }),
              )
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formstateLoading = true;
      });
      String? accountStatus =
          await FirebaseServices.signInAccount(email.text, password.text);
      if (accountStatus != null) {
        shopDialogue(accountStatus);
        setState(() {
          formstateLoading = false;
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => HomeScreen())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'WELCOME \n HIMANI ELECTRONIC SHOP',
                  style: EcoStyle.boldStyle,
                  textAlign: TextAlign.center,
                ),
                Column(
                  children: [
                    Form(
                        key: formkey,
                        child: Column(
                          children: [
                            ShopTextField(
                              validate: (v) {
                                if (v!.isEmpty ||
                                    !v.contains("@") ||
                                    !v.contains(".com")) {
                                  return "Please provide the valid email address";
                                } else {
                                  return null;
                                }
                              },
                              controller: email,
                              hintText: 'Enter your email',
                              icon: Icon(Icons.email),
                            ),
                            ShopTextField(
                              validate: (v) {
                                if (v!.isEmpty) {
                                  return "Password should not me empty";
                                }
                              },
                              controller: password,
                              hintText: 'Enter your password',
                              icon: Icon(
                                Icons.visibility_off,
                              ),
                            ),

                            //Calling the login button from the class of button,dart
                            ButtonDesign(
                              title: 'LOGIN',
                              isLoginButton: true,
                              onPress: (() => submit()),
                              isLoading: formstateLoading,
                            ),
                            // ButtonDesign(
                            //   title: 'CREATE NEW ACCOUNT',
                            //   isLoginButton: false,
                            // ),
                          ],
                        )),
                  ],
                ),
                ButtonDesign(
                  title: 'CREATE NEW ACCOUNT',
                  isLoginButton: false,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => SignupScreen())));
                  },
                ),
              ]),
        ),
      ),
    );
  }

  // static Future<String?> signInAccount(String email, String password) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     return null;
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
}
