import 'package:electronic_shop/screens/Bottom_screen/bottom_page.dart';
import 'package:electronic_shop/screens/Landing_screen.dart';
import 'package:electronic_shop/screens/layoutScreen.dart';
import 'package:electronic_shop/screens/web_screen/WebloginScreen.dart';
import 'package:electronic_shop/screens/web_screen/add_product.dart';
import 'package:electronic_shop/screens/web_screen/cart_item.dart';
import 'package:electronic_shop/screens/web_screen/dashboard_screen.dart';
import 'package:electronic_shop/screens/web_screen/delete_product.dart';
import 'package:electronic_shop/screens/web_screen/update_producte.dart';
import 'package:electronic_shop/screens/web_screen/web_main.dart';

import 'package:flutter/foundation.dart';
//import 'package:electronic_shop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';  
import 'package:sizer/sizer.dart';       

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options:const  FirebaseOptions(
       apiKey: "AIzaSyAEv3QBLvTu_cSLbSPOr3rOu46VsyKjIWg",
       authDomain: "electronic-shop-c7b59.firebaseapp.com",
       projectId: "electronic-shop-c7b59",
       storageBucket: "electronic-shop-c7b59.appspot.com",
       messagingSenderId: "1069703036216",
       appId: "1:1069703036216:web:61b8d303211e1dff3995cd"));
  }else{
    Firebase.initializeApp();
  }

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) => MaterialApp(
      title: 'New Himani electronic shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white
      ),
      home:  LayoutScreen(),// BottomPage(),

      routes:{
        WebLoginScreen.id:(context) => WebLoginScreen(),
        WebMainScreen.id:(context) => const WebMainScreen(),
        DashBoardScreen.id:(context) => const DashBoardScreen(),
        DeletProductScreen.id:(context) => const DeletProductScreen(),
        UpdateProductScreen.id:(context) => const UpdateProductScreen(),
        AddProductScreen.id:(context) => AddProductScreen(),
        CartItemScreen.id:(context) => const CartItemScreen()


      }
      
    )
    )
    );
  }
}



//  routes:{
//         //defining the routes for the different screens
        
//          WebLoginScreen.id:(context)=>WebLoginScreen(),
//           WebMainScreen.id:(context) =>const  WebMainScreen(),
//           DashBoardScreen.id:(context) =>const DashBoardScreen(),
//          DeletProductScreen.id:(context) =>const DeletProductScreen(),
//          UpdateProductScreen.id:(context) =>const UpdateProductScreen(),
//          AddProductScreen.id:(context) =>const  AddProductScreen(),
//          CartItemScreen.id :(context) =>const  CartItemScreen(),
        
         
        
