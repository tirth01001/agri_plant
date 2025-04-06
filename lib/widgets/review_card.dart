
import 'package:flutter/material.dart';



class UserReviewCard extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String userId;
  final String reviewTime;
  final String reviewTitle;
  final String reviewText;
  final double rating;

  UserReviewCard({
    required this.profileImage,
    required this.userName,
    required this.userId,
    required this.reviewTime,
    required this.reviewTitle,
    required this.reviewText,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              children: [
                // User Profile Image
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                  radius: 25,
                ),
                SizedBox(width: 12),
                // Name & ID
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    // Text(userId,
                    //     style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ],
                ),
                Spacer(),
                // Time
                Text(reviewTime,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
            SizedBox(height: 12),
            // Review Title
            Text(reviewTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            // Review Text
            Text(reviewText, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
            SizedBox(height: 10),
            // Star Rating
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < rating ? Colors.orange : Colors.grey[300],
                  size: 20,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
