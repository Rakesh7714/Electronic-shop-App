import 'package:electronic_shop/screens/web_screen/add_product.dart';
import 'package:electronic_shop/screens/web_screen/cart_item.dart';
import 'package:electronic_shop/screens/web_screen/dashboard_screen.dart';
import 'package:electronic_shop/screens/web_screen/delete_product.dart';
import 'package:electronic_shop/screens/web_screen/update_producte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:electronic_shop/main.dart';

class WebMainScreen extends StatefulWidget {
  static const String id ="webmain";
  
  
   const WebMainScreen({super.key});

  @override
  State<WebMainScreen> createState() => _WebMainScreenState();
  
}

class _WebMainScreenState extends State<WebMainScreen> {
   Widget selectedScreen = const DashBoardScreen();

   chooseScreens(item){
    switch(item){
      case DashBoardScreen.id :
      setState(() {
        selectedScreen = const DashBoardScreen();
      });
      break;

       case AddProductScreen.id :
      setState(() {
        selectedScreen =  AddProductScreen();
      });
      break;

       case DeletProductScreen.id :
      setState(() {
        selectedScreen = const DeletProductScreen();
      });
      break;

       case CartItemScreen.id :
      setState(() {
        selectedScreen = const CartItemScreen();
      });
      break;
       case UpdateProductScreen.id :
      setState(() {
        selectedScreen =const  UpdateProductScreen();
      });
      break;
      default:
      
    }
   }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold
    (
      appBar: AppBar(title: const Text('ADMIN PANEL'),backgroundColor: Colors.blueAccent,),
      sideBar:  SideBar(
       onSelected:(item){
        chooseScreens(item.route);
        },
       
        items:const  [
          AdminMenuItem(title: 'DASHBOARD',icon: Icons.dashboard,route: DashBoardScreen.id),
          AdminMenuItem(title: 'ADD PRODUCT',icon:Icons.add,route:AddProductScreen.id),
          AdminMenuItem(title: 'UPDATE',icon:Icons.update,route: UpdateProductScreen.id),
          AdminMenuItem(title: 'DELETE',icon:Icons.delete,route:DeletProductScreen.id),
          AdminMenuItem(title: 'CART ITEM',icon:Icons.card_travel,route: CartItemScreen.id),
        ],
        selectedRoute:WebMainScreen.id,) ,
      body:selectedScreen,
      );
      
  }
}