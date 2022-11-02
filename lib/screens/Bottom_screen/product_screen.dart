import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/models/products_model.dart';
import 'package:electronic_shop/screens/products_detail_screen.dart';
import 'package:electronic_shop/utils/styles.dart';
import 'package:electronic_shop/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductScreen extends StatefulWidget {
  String? category;
  ProductScreen({super.key, this.category});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController Sc = TextEditingController();
  List<Products> allProducts = [];

  getData() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot? snapshot) {
      if (widget.category == null) {
        snapshot!.docs.forEach((e) {
          if (e.exists) {
            for (var item in e['imageUrls']) {
              if (item.isNotEmpty) {
                setState(() {
                  allProducts.add(Products(
                      id: e['id'],
                      productName: e['productName'],
                      imageUrls: e['imageUrls']));
                });
              }
            }
          }
        });
      } else {
        snapshot!.docs
            .where((element) => element['category'] == widget.category)
            .forEach((e) {
          if (e.exists) {
            for (var item in e['imageUrls']) {
              if (item.isNotEmpty) {
                setState(() {
                  allProducts.add(Products(
                      id: e['id'],
                      productName: e['productName'],
                      imageUrls: e['imageUrls']));
                });
              }
            }
          }
        });
      }
    });
    
  }

  List<Products> totalItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    Future.delayed(Duration(seconds: 1), (() {
      totalItems.addAll(allProducts);
    }));
  }

  filterData(String query) {
    List<Products> dummySearchData = [];
    dummySearchData.addAll(allProducts);

    if (query.isNotEmpty) {
      List<Products> dummyData = [];
      dummySearchData.forEach((element) {
        if (element.productName!.toLowerCase().contains(query.toLowerCase())) {
          dummyData.add(element);
        }
      });
      setState(() {
        allProducts.clear();
        allProducts.addAll(dummyData);
      });
      return;
    } else {
      allProducts.clear();
      allProducts.addAll(totalItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Header(
          title: "${widget.category ?? "All products"}",
        ),
        preferredSize: Size.fromHeight(5.h),
      ), //Header(widget: widget),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: Sc,
              onChanged: ((value) {
                filterData(Sc.text);
              }),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search products items',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: allProducts.length,
                itemBuilder: ((BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              id:allProducts[index].id,
                          )));
                    },
                    child: Container(
                      child: Column(children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12)),
                            child: Image.network(
                              allProducts[index].imageUrls!.last,
                              height: 100,
                              fit: BoxFit.cover,
                            )),
                        Expanded(
                            child: Text(
                          allProducts[index].productName!,
                          textAlign: TextAlign.center,
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ))
                      ]),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}

// class Header extends StatelessWidget {
//   const Header({
//     Key? key,
//     required this.widget,
//   }) : super(key: key);

//   final ProductScreen widget;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(widget.category ??"All Products",style: TextStyle(fontWeight: FontWeight.bold),),
//       centerTitle: true,
//     );
//   }
// }