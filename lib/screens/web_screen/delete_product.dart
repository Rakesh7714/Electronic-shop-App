import 'package:electronic_shop/utils/styles.dart';

import 'package:flutter/material.dart';
class DeletProductScreen extends StatelessWidget {
  static const String id = "deleteproduct";
  const DeletProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:const  Text('DELETE',style: EcoStyle.boldStyle,),
    );
  }
}