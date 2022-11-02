import 'package:electronic_shop/screens/Bottom_screen/cart_screen.dart';
import 'package:electronic_shop/screens/Bottom_screen/favourite_screen.dart';
import 'package:electronic_shop/screens/Bottom_screen/product_screen.dart';
import 'package:electronic_shop/screens/Bottom_screen/profile_screen.dart';
import 'package:electronic_shop/screens/homescreen.dart';
import 'package:electronic_shop/screens/web_screen/cart_item.dart';
import 'package:electronic_shop/widgets/categories_home_boxes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatelessWidget {
  const BottomPage({super.key});

  @override
  Widget build(BuildContext context) {
   return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.home)),
      BottomNavigationBarItem(icon: Icon(Icons.shop)),
      BottomNavigationBarItem(icon: Icon(Icons.favorite)),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart)),
      BottomNavigationBarItem(icon: Icon(Icons.person)),
    ]), 
    tabBuilder:(context, index) {
      switch(index){
        case 0:
         return CupertinoTabView(
          builder: ((context) {
            return CupertinoPageScaffold(child:HomeScreen());
          }
          ),
         );
          case 1:
         return CupertinoTabView(
          builder: ((context) {
            return CupertinoPageScaffold(child:ProductScreen());
          }
          ),
         );
         
         case 2:
         return CupertinoTabView(
          builder: ((context) {
            return CupertinoPageScaffold(child:FavouriteScreen());
          }
          ),
         );
         case 3:
         return CupertinoTabView(
          builder: ((context) {
            return CupertinoPageScaffold(child:CartScreen());
          }
          ),
         );
         case 4:
         return CupertinoTabView(
          builder: ((context) {
            return CupertinoPageScaffold(child:profileScreen());
          }
         ));
      }
      return HomeScreen();
      
    }
    );
      
}
}