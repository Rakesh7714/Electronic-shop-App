import 'package:electronic_shop/utils/styles.dart';

import 'package:flutter/material.dart';
class CartItemScreen extends StatelessWidget {
  static const String id = "CartItems";
  const CartItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:const  Text('CARTITEM',style: EcoStyle.boldStyle,),
    );
  }
}