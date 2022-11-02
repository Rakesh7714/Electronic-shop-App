import 'dart:ui';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ButtonDesign extends StatelessWidget {
  String? title;
  bool? isLoginButton;
  VoidCallback? onPress;
  bool? isLoading;
  ButtonDesign(
      {super.key,
      this.title,
      this.isLoginButton = false,
      this.onPress,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        height: 50,
        decoration: BoxDecoration(
            color: isLoginButton == false ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isLoginButton == false ? Colors.black : Colors.black)),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading! ? false : true,
              child: Center(
                  child: Text(
                title ?? "Button",
                style: TextStyle(
                    color:
                        isLoginButton == false ? Colors.black : Colors.white),
              )),
            ),
            Visibility(
              visible: isLoading!,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
