import 'package:electronic_shop/utils/styles.dart';

import 'package:flutter/material.dart';
class DashBoardScreen extends StatelessWidget {
  static const String id = "dashboard";
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(child: const  Text('DASHBOARD',style: EcoStyle.boldStyle,)),
    );
  }
}