
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/models/categoriesModal.dart';
import 'package:electronic_shop/models/products_model.dart';
import 'package:electronic_shop/screens/Bottom_screen/product_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class categoriesHomeBoxes extends StatefulWidget {
  categoriesHomeBoxes({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  State<categoriesHomeBoxes> createState() => _categoriesHomeBoxesState();
}

class _categoriesHomeBoxesState extends State<categoriesHomeBoxes> {
  List<Products> allProducts = [];

  getData() async{
   await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
        if (e.exists) {
          for (var item in e['imageUrls']) {
             if(item.isNotEmpty){
              setState(() {
             allProducts.add(Products(
              category: e['category'],
              productName: e['productName'],
              // id:e.id,
              discountPrice: e['discountPrice'],
              price: e['price'],
              imageUrls: e['imageUrls'],
              isFavourite: e['isFavourite'],
              isOnSale: e['isOnSale'],
              isPopular: e['isPopular'],
              serialCode: e['serialCode'],
              details: e['details'],
              brand: e['brand']));
          });

             }
          }
          
         
        }
      });
    });
   // print(allProducts);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              child: RichText(
            text: const TextSpan(children: [
              TextSpan(
                  text: 'Electronics',
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
              TextSpan(
                  text: ' Items',
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ]),
          )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                    categories.length,
                    ((index) => Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(
                                    category:categories[index].title!,
                                  ),));
                                }),
                                child: Container(
                                  height: 10.h,
                                  width: 17.w,
                                  child: Container(
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    )),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                '${categories[index].image}')),
                                        // boxShadow: const [
                                        // BoxShadow(blurRadius: 5,spreadRadius: 3,color: Colors.black
                                        // ),
                              
                                        // ],
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .grey, //primaries[Random().nextInt(categories.length)]
                                        border: Border.all(
                                            color: Colors.yellowAccent)),
                                  ),
                                ),
                              ),
                              Text(
                                categories[index].title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )))
              ],
            ),
          ),
          carousel(images: widget.images),
          Text(
            'Popular Items',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),
          ),
          
          allProducts.length == 0? CircularProgressIndicator() :
          popularItems(allProducts: allProducts),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
              Expanded(
                child: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.orange
                  ),
                  child: Center(child: Text('Top Sales',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600))),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.greenAccent
                  ),
                  child: Center(child: Text('New Arrivals',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
                ),
              )
            ],
            ),
          ),
          Text(
            'Top Brands',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600),
              ),
              BrandsItems(allProducts: allProducts)

          
        ],
      ),
    );
  }
}
  


class BrandsItems extends StatelessWidget {
  const BrandsItems({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
          .map((e) => Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
             // width: 20.w,
              child: Container(
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: 20.w,
                          
                            //height: 10.h,
                            decoration: BoxDecoration(
                                       
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.primaries[Random().nextInt(8)]
                                      ),
                            child: Center(
                              child: Text(e.brand![0],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                              ),
                            ),
                          ),
                          Text(e.brand!)
                        ],
                      ),
                    ),
                  ),
            ),
          )).toList()
        
      ),
    );
  }
}





class popularItems extends StatelessWidget {
  const popularItems({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
     
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: 
          allProducts.where((element) => element.isPopular == true)
          .map((e) => Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              // height: 8.h,
               width: 15.h,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.black),
              //   borderRadius: BorderRadius.circular(10)
              // ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)
              ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        e.imageUrls![0],height: 80,width: 80,),
                    ),
                  ),
                  Expanded(child: Text(e.productName!))
                ],
              ),
            ),
          )).toList()
        
      ),
    );
  }
}



class carousel extends StatelessWidget {
  const carousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map(
            (e) => Stack(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      e,
                      fit: BoxFit.fill,
                      height: 200,
                      width: double.infinity,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.blueAccent.shade400.withOpacity(0.1),
                        Colors.redAccent.shade400.withOpacity(0.1),
                      ])),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 22,
                child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'diwali offer 50% off',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
              )
            ]),
          )
          .toList(),
      options: CarouselOptions(height: 200, autoPlay: true),
    );
  }
}
