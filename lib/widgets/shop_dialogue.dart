import 'package:electronic_shop/widgets/button.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart'

class ShopDialogue extends StatelessWidget {
 final  String? title;
   ShopDialogue({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            title: Text(title!),
            actions: [
              ButtonDesign(
                title: 'CLOSE',
                onPress: (() {
                  Navigator.pop(context);
                }),
              )
            ],
          );
  }
}