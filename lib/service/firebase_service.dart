

import 'dart:math';

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

  String generateRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length, 
      (_) => characters.codeUnitAt(random.nextInt(characters.length))
    ));
  }

  void initAccount(String uid) async {
    try{
      await FirebaseFirestore.instance.collection("E_Farmer").doc(uid).get().then((snap){
        if(snap.exists){
          globalUserAccount = UserAccount(
            uid, 
            {
              Profile.dp: snap.get('profile')["dp"],
              Profile.emailaddress: snap.get('profile')["email"],
              Profile.name: snap.get('profile')["name"],
              Profile.mobile: snap.get('profile')['mobile'],
              Profile.address: snap.get('address'),
            }, 
            [], 
            [],
            snap.get('address'),
          );
        }
      });
    }catch(e){
      print(e);
    }
  }


  Future<Result> updateProfile(UserAccount account) async {
    try{

      await FirebaseFirestore.instance.collection("E_Farmer").doc(account.uid).update({
        'profile.dp': account.profile[Profile.dp],
        'profile.email': account.profile[Profile.emailaddress],
        'profile.name': account.profile[Profile.name],
      });

      return Result.sucess;
    }catch(e){
      return Result.fail;
    }
  }

  Future<UserAccount?> account(String uid) async {
    try{
      UserAccount account = UserAccount.emptyClass();
      await FirebaseFirestore.instance.collection("E_Farmer").doc(uid).get().then((snap){
        if(snap.exists){
          account = UserAccount(uid, {
            Profile.dp: snap.get('profile')["dp"],
            Profile.emailaddress: snap.get('profile')["email"],
            Profile.name: snap.get('profile')["name"]
          }, [], [],[]);
        }
      });
      // print(account.profile[Profile.emailaddress].toString());
      return account;
    }catch(e){
      print(e);
      //END
    }
    return null;
  }

  Future<Result> updateCart(Product prdouctData,{int ? qty}) async {
    try{

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      WriteBatch batch = firestore.batch();

      DocumentReference update1 = firestore.collection("E_Farmer").doc(globalUserAccount.uid).collection("user_cart").doc(prdouctData.productId);
      batch.update(update1, prdouctData.map(newQty: qty));

      await batch.commit();
      return Result.sucess;
    }catch(e){
      print(e);
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
      DocumentReference update1 = firestore.collection("E_Farmer").doc(globalUserAccount.uid).collection("user_cart").doc(product.productId);
      batch.set(update1, product.map());
      globalUserAccount.cartProductIds.add(product.productId);
      await batch.commit();
      return Result.sucess;
    }catch(e){
      print(e);
      return Result.fail;
    }
  }


  Future<Result> removeProductFromCart(String pid) async {
    try{
      await FirebaseFirestore.instance.collection("E_Farmer").doc(globalUserAccount.uid).collection("user_cart").doc(pid).delete();
      globalUserAccount.cartProductIds.remove(pid);
      return Result.sucess;
    }catch(e){
      print(e);
      return Result.fail;
    }
  }




  Future<Result> makeOrders(List<Product> product) async {
    try{

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      WriteBatch batch = firestore.batch();

      final Map<String,dynamic> iM = {
        "dp": globalUserAccount.profile[Profile.dp],
        "id": globalUserAccount.uid,
        "mobile": globalUserAccount.profile[Profile.mobile],
        "name": globalUserAccount.profile[Profile.name],
        "state": "Gujarat",
        "uid": null,
      };

      for(int i=0;i<product.length;i++){
        String oid = generateRandomString(18);
        Map<String,dynamic> data = product[i].map();
        DocumentReference up1 = firestore.collection("e_farmer_order").doc(oid);
        DocumentReference up2 = firestore.collection("e_farmer_admin").doc(product[i].cid).collection("summary").doc("dash_board");
        DocumentReference up3 = firestore.collection("E_Farmer").doc(globalUserAccount.uid).collection("user_cart").doc(product[i].productId);
        

        batch.set(up1, {
          "product": data,
          "order": {
            "oid": oid,
            "order_place_date": DateTime.now(),
            "order_status": "Processing",
            "payment_mode": "PayPal"
          },
          "customer": iM,
          "billing": {
            "billing_address": "Abc street road",
            "name": iM["name"],
            "total_pay": (product[i].buyQty * product[i].price["new"])
          },
          "shipping":{
            "address":"Abc street road",
            "delivery_charge": 0,
            "pin_code": 395001,
          },
          "cart":{},
          "sid": product[i].sid,
        });
        batch.update(up2, {
          "total_order": FieldValue.increment(1),
          "total_revenue": FieldValue.increment(product[i].price["new"]*product[i].buyQty),
          "balance": FieldValue.increment(product[i].price["new"]*product[i].buyQty),
        });
        batch.delete(up3);
      }

      await batch.commit();
          
      return Result.sucess;
    }catch(e){
      return Result.fail;
    }
  }

  Future<bool> cancelOrder({
    required String orderID,
    required String adminID,
    required double price,
    required int qty,
  }) async {
    try{

      await FirebaseFirestore.instance.collection("e_farmer_order").doc(orderID).delete();
      await FirebaseFirestore.instance.collection("e_farmer_admin").doc(adminID).collection("summary").doc("dash_board").update({
        'total_revenue': FieldValue.increment(-(price*qty)),
        'balance': FieldValue.increment(-(price*qty)),
        'total_order': FieldValue.increment(-1),
      });

      return true;
    }catch(e){
      //e
      return false;
    }
  }
  

}