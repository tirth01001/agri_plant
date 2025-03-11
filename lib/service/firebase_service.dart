

import 'package:agriplant/data/products.dart';
import 'package:agriplant/models/product.dart';
import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Result {
  fail,
  sucess,
  nothing,
}


class FirebaseService {

  static FirebaseService service = FirebaseService();


  // Future<bool> _isAlreadyInCart(Product product) async {
  //   try{

      

  //   }catch(e){
  //     //
  //   }
  // }

  Future<Result> updateCart(Product prdouctData,{int ? qty}) async {
    try{

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      WriteBatch batch = firestore.batch();

      DocumentReference update1 = firestore.collection("E_Farmer").doc(globalUserAccount.profile[Profile.mobile]).collection("user_cart").doc(prdouctData.productId);
      batch.update(update1, prdouctData.map(newQty: qty));

      await batch.commit();
      return Result.sucess;
    }catch(e){
      return Result.fail;
    }
  }

  Future<Result> addProductToCart(Product product) async {
    try{
      //Check user already add product in Cart
      if(globalUserAccount.isProductInCart(product.productId)){
        //Update Cart
        updateCart(product);
        return Result.sucess;
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      WriteBatch batch = firestore.batch();
      DocumentReference update1 = firestore.collection("E_Farmer").doc(globalUserAccount.profile[Profile.mobile]).collection("user_cart").doc(product.productId);
      batch.set(update1, product.map());
      globalUserAccount.cartProductIds.add(product.productId);
      await batch.commit();
      return Result.sucess;
    }catch(e){
      return Result.fail;
    }
  }
  

}