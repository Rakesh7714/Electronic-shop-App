import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/models/products_model.dart';
import 'package:electronic_shop/screens/web_screen/updateComplete_screen.dart';
import 'package:electronic_shop/utils/styles.dart';

import 'package:flutter/material.dart';
class UpdateProductScreen extends StatefulWidget {
  static const String id = "updateproduct";
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
           const   Text(
              'UPDATE',style: EcoStyle.boldStyle,
              ),
            StreamBuilder<QuerySnapshot>(
              
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder:((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
               if(!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
               }
               if(snapshot.data == null){
                return const Center(child: Text('There is not data exists'),

                );

               }
               
                 final data = snapshot.data!.docs;
                return Expanded( 
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context ,int index){
                    return Container(
                      
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){},
                          child: ListTile(
                            tileColor: Colors.blueAccent,
                            leading: Text(data[index]['serialCode'].toString()),
                            title: Text(data[index]['productName'] ),
                          trailing: Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(icon: const Icon(Icons.delete_forever),
                                onPressed: (() {
                                 setState(() {
                                  Products.deleteProduct(data[index].id);
                                 });
                                 
                                }),),
                                IconButton(icon: const Icon(Icons.edit),
                                
                                onPressed: (() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCompleteScreen(
                                    
                                    products: Products(
                                     category: data[index]['category'],
                                     productName: data[index]['productName'],
                                      id:data[index].id, 
                                      discountPrice: data[index]['discountPrice'],
                                       price:data[index]['price'], 
                                       imageUrls: data[index]['imageUrls'],
                                        isFavourite: data[index]['isFavourite'], 
                                        isOnSale: data[index]['isOnSale'], 
                                        isPopular: data[index]['isPopular'],
                                         serialCode: data[index]['serialCode'],
                                         details: data[index]['details'],
                                         brand: data[index]['brand']
                                         ),
                                  ),));
                                }),)
                              
                              ],
                            ),
                          ),
                                            ),
                        ),
                      ),);
                  }),
                );
               

              }))
          ],
        ),
      ),
    );
  }
}