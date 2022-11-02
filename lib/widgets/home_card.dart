import 'package:flutter/material.dart';

import '../utils/styles.dart';
class HomeCard extends StatelessWidget {
 final  String? title;
   HomeCard({
    Key? key,
    this.title,
  }) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                  
                  colors:[
                   Colors.blueAccent.shade400.withOpacity(0.8),
                    Colors.redAccent.shade400.withOpacity(0.8),
                    Colors.greenAccent.shade400.withOpacity(0.8),
                ])),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text(title??'Title',style: EcoStyle.boldStyle.copyWith(color: Colors.white),)),
        ),
      ),
    );
  }
}