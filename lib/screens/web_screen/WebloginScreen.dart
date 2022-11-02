import 'package:electronic_shop/screens/web_screen/web_main.dart';
import 'package:electronic_shop/services/Firebase_service.dart';
import 'package:electronic_shop/utils/styles.dart';
import 'package:electronic_shop/widgets/button.dart';
import 'package:electronic_shop/widgets/shop_dialogue.dart';
import 'package:electronic_shop/widgets/shoptextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class WebLoginScreen extends StatefulWidget {
  static const String id ="weblogin";
   WebLoginScreen({super.key});

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  TextEditingController Usernamec = TextEditingController();

  TextEditingController passwordc = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool formStateLoading = false;

  

  Submit(BuildContext context)async{
 if(formkey.currentState!.validate()){
  setState(() {
    formStateLoading = true;
  });
  FirebaseServices.adminSignIn(Usernamec.text).then((value)async{
    if(value['username'] == Usernamec.text && 
    value['password'] == passwordc.text){
      UserCredential user = await FirebaseAuth.instance.signInAnonymously();
      try{
        if(user != null){
         Navigator.pushReplacementNamed(context, WebMainScreen.id);
      }
      }catch(e) {
        setState(() {
          formStateLoading = false;
        });
        showDialog(context: context, builder: ((context) => ShopDialogue(title: e.toString(),)));

      }
      
    }
  });
 }
  
  
  

 
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 20.w,
            

          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 3),
              borderRadius: BorderRadius.circular(12)
              
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    Text('LOG IN YOUR ACCOUNT',
                    style: EcoStyle.boldStyle,),
                    ShopTextField(
                      //isPassword: true,
                      hintText:'Username',
                      controller: Usernamec,
                      // validate: (v) {
                      //             if (v!.isEmpty ||
                      //                 !v.contains("@") ||
                      //                 !v.contains(".com")) {
                      //               return "Please provide the valid email address";
                      //             } else {
                      //               return null;
                      //             }
                      //           },
                      ),
                    ShopTextField(hintText: "Password",
                    controller: passwordc,
                    isPassword: true,
                    validate: (v) {
                                  if (v!.isEmpty) {
                                    return "Password should not me empty";
                                  }else{
                                    return null;
                                  }
                                },
                    ),
                    ButtonDesign(isLoginButton: true,
                    isLoading: formStateLoading,
                    onPress: () => Submit(context),),
                  ],
                ),
              ),
            ),
          ),
        )),
    );
  }
}