

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpolarProvider extends ChangeNotifier {

  bool isSearching = false;
  
  final TextEditingController search = TextEditingController();

  List<String> ? category;  
  RangeValues ? price;
  int ? rating;

  // Stream<QuerySnapshot<Map<String, dynamic>>> productQuery = FirebaseFirestore.instance.collection("e_farmer_product").snapshots();

  void switchMode({bool ? value}){
    isSearching = value ?? !isSearching;
    notifyListeners();
  }

  Stream get searchProductStream {

    if(category != null && price != null && rating != null){

      print("Try To Search Them");

      return FirebaseFirestore.instance.collection("e_farmer_product")
        .where('category',whereIn: category)
        // .where('price.new',isGreaterThanOrEqualTo: price!.start)
        // .where('price.new',isLessThanOrEqualTo: price!.end)
        // .where('rating',isGreaterThan: rating)
        .snapshots();
    }

    if(search.text.trim().isEmpty){

      return FirebaseFirestore.instance.collection("e_farmer_product").snapshots();
    }


    return FirebaseFirestore.instance.collection("e_farmer_product")
      .where('name',isGreaterThanOrEqualTo: search.text)
      .where('name',isLessThan: '${search.text}z')
      .snapshots();
  }

}