import 'package:cloud_firestore/cloud_firestore.dart';


class Products{
  String? category;
  String? productName;
  String? id;
  String? details;
  int? price;
  int? discountPrice;
  String? serialCode;
  List<dynamic>? imageUrls;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavourite;
  String? brand;
  Products({
    this.category,
     this.productName,
     this.id,
    this.details,
     this.discountPrice,
     this.price,
     this.imageUrls,
     this.isFavourite,
     this.isOnSale,
     this.isPopular,
     this.serialCode,
    this.brand
    });
    //CollectionReference db = FirebaseFirestore.instance.collection('products');

    //This is for the add products 
   static Future<void>addProduct(Products products)async{
     CollectionReference db = FirebaseFirestore.instance.collection('products');
      Map<String , dynamic> data = {
        'category':products.category,
        'productName':products.productName,
        'details':products.details,
        'discountPrice':products.discountPrice,
        'price':products.price,
        'imageUrls':products.imageUrls,
        'isFavourite':products.isFavourite,
        'isOnSale':products.isOnSale,
        'isPopular':products.isPopular,
        'serialCode':products.serialCode,
        'id':products.id,
        'brand':products.brand,
      };
      await db.add(data);
   
    }
    //This will be for the updateproducts
     static Future<void>updateProduct(String id ,Products updateProducts)async{
         CollectionReference db = FirebaseFirestore.instance.collection('products');
      Map<String , dynamic> data = {
        'category':updateProducts.category,
        'productName':updateProducts.productName,
        'details':updateProducts.details,
        'discountPrice':updateProducts.discountPrice,
        'price':updateProducts.price,
        'imageUrls':updateProducts.imageUrls,
        'isFavourite':updateProducts.isFavourite,
        'isOnSale':updateProducts.isOnSale,
        'isPopular':updateProducts.isPopular,
        'serialCode':updateProducts.serialCode,
        'id':updateProducts.id,
        'brand':updateProducts.brand
      };
      await db.doc(id).update(data);
   
    }

  //This is for the  delete products
   static Future<void>deleteProduct(String id)async{
     CollectionReference db = FirebaseFirestore.instance.collection('products');
     
      await db.doc(id).delete();
   
    } 

}