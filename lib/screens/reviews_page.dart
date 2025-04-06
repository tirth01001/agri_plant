


import 'package:agriplant/models/review_model.dart';
import 'package:agriplant/widgets/review_card.dart';
import 'package:agriplant/widgets/review_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  
  final String productId;
  const ReviewsPage({super.key,required this.productId});

  @override
  Widget build(BuildContext context) {

    Query<ReviewModel> jobQueyr = FirebaseFirestore.instance.collection("e_farmer_product_rating").doc(productId).collection("user_rating").withConverter<ReviewModel>(
      fromFirestore: (snap,_) => ReviewModel.fromFirestore(snap), 
      toFirestore: (model,_) => model.map,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews"),
        leading: IconButton(onPressed: (){

          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: FirestoreListView<ReviewModel>(
        query: jobQueyr,
        itemBuilder: (context, doc) {

          final rmodel = doc.data();
          
          return UserReviewCard(
            profileImage: rmodel.userDp, 
            userName: rmodel.userName, 
            userId: rmodel.userId, 
            reviewTime: rmodel.timeStamp.toDate().toString(), 
            reviewTitle: rmodel.commentTitle, 
            reviewText: rmodel.comment, 
            rating: rmodel.rating
          );
        }, 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          showDialog(
            context: context, 
            builder: (context) {
              
              return AddReviewDialog(productId: productId,);
            },
          );

        },
        child: Icon(Icons.reviews),
      ),
    );
  }
}