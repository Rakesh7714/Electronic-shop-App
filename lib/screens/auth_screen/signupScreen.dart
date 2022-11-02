import 'package:electronic_shop/screens/auth_screen/login_screen.dart';
import 'package:electronic_shop/services/Firebase_service.dart';
import 'package:electronic_shop/utils/styles.dart';
import 'package:electronic_shop/widgets/button.dart';
import 'package:electronic_shop/widgets/shoptextfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPassword = true;
  bool isreTypepassword = true;
  bool formstateLoading = false;

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController retype = TextEditingController();
  FocusNode? passwordfocus;
  FocusNode? retypepasswordfocus;
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    retype.dispose();
    password.dispose();
    email.dispose();
    super.dispose();
  }

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
      if (password.text == retype.text) {
        setState(() {
          formstateLoading = true;
        });
        String? accountStatus =
            await FirebaseServices.CreateAccount(email.text, password.text);
        if (accountStatus != null) {
          shopDialogue(accountStatus);
          setState(() {
            formstateLoading = false;
          });
        } else {
          Navigator.pop(context);
        }
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => LoginScreen())));
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
                  'CREATE YOUR ACCOUNT',
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
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                              controller: email,
                              hintText: 'Enter your email',
                              icon: const Icon(Icons.email),
                            ),
                            ShopTextField(
                              validate: (v) {
                                if (v!.isEmpty) {
                                  return "Password should not me empty";
                                }
                              },
                              focusNode: passwordfocus,
                              inputAction: TextInputAction.next,
                              isPassword: isPassword,
                              controller: password,
                              inputType: TextInputType.visiblePassword,
                              hintText: 'Enter your password',
                              icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPassword = !isPassword;
                                  });
                                },
                                icon: isPassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                            ),
                            ShopTextField(
                              validate: (v) {
                                if (v!.isEmpty) {
                                  return "empty is not accepted";
                                }
                              },
                              isPassword: isreTypepassword,
                              controller: retype,
                              inputType: TextInputType.visiblePassword,
                              hintText: 'Retype your password',
                              icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isreTypepassword = !isreTypepassword;
                                  });
                                },
                                icon: isreTypepassword
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                            ),

                            //Calling the login button from the class of button,dart
                            ButtonDesign(
                              title: 'SIGNUP',
                              isLoginButton: true,
                              onPress: () {
                                submit();
                              },
                              isLoading: formstateLoading,
                            ),
                          ],
                        )),
                  ],
                ),
                ButtonDesign(
                  title: 'BACK TO LOGIN',
                  isLoginButton: false,
                  onPress: () => Navigator.pop(context),
                ),
              ]),
        ),
      ),
    );
  }
}
