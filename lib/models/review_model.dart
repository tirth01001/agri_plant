


import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {

  final String reviewId;
  final String comment;
  final String commentTitle;
  final double rating;
  final Timestamp timeStamp;
  final String userId;
  final String userDp;
  final String userName;

  ReviewModel({
    this.reviewId="",
    this.comment="",
    this.commentTitle="",
    this.rating=0.0,
    required this.timeStamp,
    this.userDp="",
    this.userId="",
    this.userName=""
  });


  factory ReviewModel.fromFirestore(DocumentSnapshot snap) => ReviewModel(
    reviewId: snap.id,
    comment: snap.get('comment'),
    commentTitle: snap.get('comment_title'),
    rating: snap.get('rating'),
    timeStamp: snap.get('timestamp'),
    userDp: snap.get('user_dp'),
    userId: snap.get('user_id'),
    userName: snap.get('user_name')
  );

  Map<String,dynamic> get map => {
    'user_id': reviewId,
    'user_name': userName,
    'user_dp': userDp,
    'comment_title': commentTitle,
    'comment': comment,
    'rating': rating,
    'timestamp': timeStamp,
  };

}
