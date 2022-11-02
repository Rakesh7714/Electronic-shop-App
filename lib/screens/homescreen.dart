import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
//import 'package:electronic_shop/services/Firebase_service.dart';
import 'package:electronic_shop/utils/styles.dart';
import 'package:electronic_shop/widgets/categories_home_boxes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/home_card.dart';

//titlecard is list of the categories----------
// final List<String> titlecard = [
//     "Grocery Items",
//     "Wires Items",
//     "Fan Items", 
//     "Plumbers Items",
//     "Coolers",
  
//   ];

class HomeScreen extends StatefulWidget {
 const  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  

  //list of the images
  final List<String> images = [
    "assets1/coolerw.jpg",
    "assets1/btfan.jpg",
    "assets1/coolerw.jpg",
    "assets1/meterwire.jpg",
    //"asstes1/cfan.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: categoriesHomeBoxes(images: images),
      ),
    );
  }
}

// class categoriesHomeBoxes extends StatelessWidget {
//   const categoriesHomeBoxes({
//     Key? key,
//     required this.images,
//   }) : super(key: key);

//   final List<String> images;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                ...List.generate(titlecard.length,((index) =>  Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Container(
//                     height: 18.h,
//                     width: 18.w,
//                     child: Container(
//                       child: Center(
//                         child: Text(titlecard[index],
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),
//                       )),
//                       decoration:  BoxDecoration(
//                         boxShadow: [BoxShadow(blurRadius: 5,spreadRadius: 3,color: Colors.black)],
//                         shape: BoxShape.circle,
//                         color: Colors.primaries[Random().nextInt(titlecard.length)]
//                       ),
//                     ),
//                   ),
//                ) ))
              
//               ],
//             ),
//           ),
//           CarouselSlider(
    
//               items: images
//                   .map((e) => Stack(
//                     children:[ 
//                       Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset(e,fit: BoxFit.fill,height: 200,width: double.infinity,)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
                        
    
//                         height: 200,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           gradient: LinearGradient(
                          
//                           colors:[
//                            Colors.blueAccent.shade400.withOpacity(0.1),
//                             Colors.redAccent.shade400.withOpacity(0.1),
//                         ])),
                        
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 20,
//                       left: 22,
//                       child: Container(
                      
//                         color: Colors.black.withOpacity(0.4),
//                         child:const Padding(
//                           padding:  EdgeInsets.all(8.0),
//                           child: Text('TITLE',style: TextStyle(fontSize: 20,color: Colors.white),),
//                         )),
//                     )
//                    ]
//                   ),
                  
//                   )
//                       .toList(),
                  
//               options: CarouselOptions(height: 200, autoPlay: true),
              
//               ),
//               // HomeCard(title: titlecard[0],),
//               // HomeCard(title: titlecard[1],),
//               // HomeCard(title: titlecard[2],),
//               // HomeCard(title: titlecard[3],),
//               // HomeCard(title: titlecard[4],),
//               // HomeCard(title: titlecard[5],),
          
//               //HomeCard(title: titlecard[4],),
//         ],
//       ),
//     );
//   }
// }


