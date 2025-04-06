

import 'package:agriplant/models/product.dart';
import 'package:agriplant/service/firebase_service.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {

  Product product = Product.empty();  
  bool isQtyProcessing = false;

  void init(Product pd){
    product = pd;
  }


  void updateQuantity(){
    isQtyProcessing = false;
    FirebaseService.service.updateCart(product,qty: product.buyQty);
  }

  void updateQtyInUI(int newQty){
    if(newQty != 1 && newQty < 1) return;
    isQtyProcessing = true;
    product.buyQty = newQty;
    notifyListeners();
    if(isQtyProcessing){
      Future.delayed(const Duration(seconds: 1),updateQuantity);
    }
  }


  


}