import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/models/categoriesModal.dart';
import 'package:electronic_shop/models/products_model.dart';
import 'package:electronic_shop/screens/homescreen.dart';
import 'package:electronic_shop/utils/styles.dart';
import 'package:electronic_shop/widgets/button.dart';
import 'package:electronic_shop/widgets/home_card.dart';
import 'package:electronic_shop/widgets/shoptextfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid.dart';
class AddProductScreen extends StatefulWidget {
  static const String id = "Addproduct";
  
   AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController detailsC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  TextEditingController brandc = TextEditingController();
  bool isOnSale =false;
  bool isFavourite =false;
  bool isPopular =false;


  String? selectedValue ;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageUrls =[];
  bool isSaving = false;
  bool isUploading = false;
  var uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child:Center(
       child: Padding(
         padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
         child: Column(
            children: [
               const Text('ADDPRODUCT',style: EcoStyle.boldStyle,),
               Container(
               margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
                 child: DropdownButtonFormField(
                  hint:const  Text('Choose categories '),
                  decoration:const  InputDecoration(border: InputBorder.none),
                  validator: (value) {
                    if(value == null){
                      return "please selecte any items from the list";
                    }else{
                      return null;
                    }
                  },
                  value: selectedValue,
                  //Here titlecard is the items list of the glocesory itmes
                  items: categories.map((e) => DropdownMenuItem<String>(
                  value: e.title,
                  child: Text(e.title!))).toList(),
                  onChanged:(value){
                    setState(() {
                      selectedValue = value.toString();
                    });
                  } ,),
               ),
                 ShopTextField(
                  hintText: 'Enter the productsName',
                  controller: productNameC,
                  validate: (v){
                    if(v!.isEmpty){
                      return "ProductName can't be empty";
                    }else{
                      return null;
                    }
                  },
                ),
                  ShopTextField(
                  hintText: 'Enter the products Brand',
                  controller: brandc,
                  validate: (v){
                    if(v!.isEmpty){
                      return "Product brand can't be empty";
                    }else{
                      return null;
                    }
                  },
                ),
                ShopTextField(
                //  maxLines: 20,
                  hintText: 'Enter the details of the products',
                  controller: detailsC,
                  validate: (v){
                    if(v!.isEmpty){
                      return "details can't be empty";
                    }else{
                      return null;
                    }
                  },
                ),
                ShopTextField(
                  hintText: 'Enter the product price',
                  controller: priceC,
                  validate: (v){
                    if(v!.isEmpty){
                      return "Price can't be empty";
                    }else{
                      return null;
                    }
                  },
                ),
                ShopTextField(
                  hintText: 'Enter the discountPrice',
                  controller: discountPriceC,
                  validate: (v){
                    if(v!.isEmpty){
                      return "discountPrice can't be empty";
                    }else{
                      return null;
                    }
                  },
                ),
                ShopTextField(
                  hintText: 'Enter the product serialcode',
                  controller: serialCodeC,
                  validate: (v){
                    if(v!.isEmpty){
                      return "serialCode can't be empty";
                    }else{
                      return null;
                    }
                  },
                ),
                
                ButtonDesign(
                  isLoginButton: true,
                  title: 'Pick Image',
                  onPress: (() {
                    setState(() {
                      pickImage();
                    });
    
                  }),
                ),
                ButtonDesign(
                  isLoginButton: true,
                  title: 'Upload Image',
                  isLoading: isUploading,
                  onPress: () {
                    setState(() {
                      uploadImages();
                    });
                    
                  },
                ),
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(20),
                    color: Colors.amber.withOpacity(0.2)
                     ),
                     child: GridView.builder(
                      gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                      itemCount: images.length,
                       itemBuilder: ((BuildContext context, int index) {
                         return Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Stack(
                             children: [
                               Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                 child: Image.network(File(images[index].path).path,
                                 height: 200,
                                 width: 200,
                                 fit: BoxFit.cover,
                                 ),
                               ),
                               IconButton(onPressed: (){
                                setState(() {
                                  images.removeAt(index);
                                });
                                
                               }, icon:const  Icon(Icons.cancel,color: Colors.white,))
                               
                             ],
                             
                           ),
                         );
                       }),
                )
                ),
               

                SwitchListTile(value: isOnSale,
                title: const Text('Is this product on sale?'),
                 onChanged: (v){setState(() {
                  isOnSale = !isOnSale;
                });}),

                SwitchListTile(value: isPopular,
                title: const Text('Is this product popular?'),
                 onChanged: (v){setState(() {
                   isPopular = ! isPopular;
                });
                 }),
                ButtonDesign(
                  title: 'SAVE',
                  onPress: () {
                    save();
                  },
                  isLoading: isSaving,
                ),
            ],
          ),
       )),
      ),
    );
  }

  save()async{
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await  Products.addProduct(Products(category: selectedValue,
     productName: productNameC.text, 
     id:uuid.v4(),
      discountPrice:int.parse(discountPriceC.text),
        price:int.parse(priceC.text) ,
        imageUrls: imageUrls,
         isFavourite: isFavourite,
          isOnSale: isOnSale,
           isPopular: isPopular, 
           serialCode: serialCodeC.text,
           brand: brandc.text,
           details: detailsC.text,
           )).whenComplete((){
             setState(() {
               isSaving =false;
               imageUrls.clear();
               images.clear();
               clearFielsd();
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ADDED SUCESSFULLY')));
             });
           });
  //  await FirebaseFirestore.instance.collection("products").add({"images":imageUrls}).whenComplete((){
  //     setState(() {
  //       isSaving = false;
  //       imageUrls.clear();
  //       images.clear();
  //     });
  //   });

  }
  clearFielsd(){
    setState(() {
      //selectedValue ;
      priceC.clear();
      discountPriceC.clear();
      detailsC.clear();
      productNameC.clear();
      idC.clear();
      serialCodeC.clear();
      brandc.clear();
      
    });
  }

  pickImage()async{
    final List<XFile>? pickImage = await imagePicker.pickMultiImage();
    if(pickImage != null){
      setState(() {
        images.addAll(pickImage);
      });
    }else{
      print('Image is not selected');
    }
  }


  Future postImages(XFile? imageFile)async{
    setState(() {
      isUploading=true;
    });
    String urls;
 Reference ref = FirebaseStorage.instance.ref().child('images').child(imageFile!.name);
 if(kIsWeb){
  await ref.putData(await imageFile.readAsBytes());
  SettableMetadata(contentType:" image/jpeg");
  urls= await ref.getDownloadURL();
  setState(() {
    isUploading =false;
  });
  return urls;
 }
 
  }
  uploadImages()async{
    
    for( var image in images){
      await postImages(image).then((downLoadUrl) =>imageUrls.add(downLoadUrl));
    }
  }
}