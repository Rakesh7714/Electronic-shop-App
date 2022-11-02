import 'package:electronic_shop/screens/Bottom_screen/product_screen.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  String? title;
   Header({
    this.title,
    
    
  }) ;

  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!,style: TextStyle(fontWeight: FontWeight.bold),),
      centerTitle: true,
    );
  }
}