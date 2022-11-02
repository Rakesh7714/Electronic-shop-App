import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/models/products_model.dart';
import 'package:electronic_shop/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsScreen extends StatefulWidget {
  String? id;

  ProductDetailsScreen({super.key, this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<Products> allProducts = [];
  getData() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs
          .where((element) => element['id'] == widget.id)
          .forEach((e) {
        if (e.exists) {
          for (var item in e['imageUrls']) {
            if (item.isNotEmpty) {
              setState(() {
                allProducts.add(Products(
                    id: e['id'],
                    productName: e['productName'],
                    imageUrls: e['imageUrls'],
                    details: e['details']));
              });
            }
          }
        }
      });
    });
  }

  addToFavourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .add({"pid": allProducts.first.id});
    // FirebaseFirestore.instance
    //     .collection('favourite')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection('items')
    //     .add(({}));
  }
  removeToFavourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .doc(id).delete();
    // FirebaseFirestore.instance
    //     .collection('favourite')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection('items')
    //     .add(({}));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  int SelectedIndex = 0;
  bool isfvrt = false;

  @override
  Widget build(BuildContext context) {
    return allProducts.isEmpty
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ))
        : Scaffold(
            appBar: PreferredSize(
              child: Header(
                title: "${allProducts.first.productName}",
              ),
              preferredSize: Size.fromHeight(8.h),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Image.network(
                  allProducts[0].imageUrls![SelectedIndex],
                  height: 35.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                          allProducts[0].imageUrls!.length,
                          (index) => InkWell(
                                onTap: (() {
                                  setState(() {
                                    SelectedIndex = index;
                                  });
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 12.h,
                                    width: 12.w,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Image.network(
                                        allProducts[index].imageUrls![index]),
                                  ),
                                ),
                              ))
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('favourite')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('items').where('pid',isEqualTo:allProducts.first.id)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.data==null){
                        return Text('');
                      }
                      return IconButton(
                          onPressed: () {
                            snapshot.data!.docs.length==0?addToFavourite():removeToFavourite(snapshot.data!.docs.first.id);
                            
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: snapshot.data!.docs.length==0?  Colors.black : Colors.red,
                            size: 43.0,
                          ));
                    }),
                // Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     height:7.h ,
                //     width: 20.h,
                //     decoration: BoxDecoration(color: Colors.black,
                //     borderRadius: BorderRadius.circular(3)),
                //     child: Center(child: Text('Rs 5000',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20.0,color: Colors.white),)),
                //   ),
                // ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  constraints: BoxConstraints(
                      minHeight: 30.h, minWidth: double.infinity),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      allProducts.first.details!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  child: Row(children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.exposure_minus_1),
                      color: Colors.blueAccent,
                    ),
                    Text('01'),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.exposure_plus_1)),
                  ]),
                ),
                SizedBox(
                  height: 40.h,
                )
              ]),
            ),
          );
  }
}
