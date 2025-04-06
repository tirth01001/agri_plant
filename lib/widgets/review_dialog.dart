import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddReviewDialog extends StatefulWidget {

  final String productId;
  const AddReviewDialog({super.key,required this.productId});

  @override
  _AddReviewDialogState createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double _rating = 4.0; // Default rating

  void _submitReview() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));

    // Firestore me save karna
    await FirebaseFirestore.instance.collection('e_farmer_product_rating').doc(widget.productId).collection("user_rating").doc(globalUserAccount.uid).set({
      'user_name': globalUserAccount.profile[Profile.name],
      'user_id': globalUserAccount.uid,
      'user_dp': globalUserAccount.profile[Profile.dp],
      'timestamp': DateTime.now(),
      'comment_title': _titleController.text,
      'comment': _descriptionController.text,
      'rating': _rating,
    });

    

    await FirebaseFirestore.instance.collection('e_farmer_product_rating').doc(widget.productId).update({
      'total_review': FieldValue.increment(1),
      'star_${_rating.toInt()}_count': FieldValue.increment(1),
    });

    Navigator.pop(context); // Dialog close karna
    Navigator.pop(context); // Dialog close karna
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text("Write a Review"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(hintText: "Review Title"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(hintText: "Your Review"),
            maxLines: 3,
          ),
          SizedBox(height: 15),
          Text("Rate this App", style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          // ⭐ Interactive Rating Input
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _rating = index + 1.0;
                    print(_rating);
                  });
                },
                child: Icon(
                  Icons.star,
                  color: index < _rating ? Colors.orange : Colors.grey[300],
                  size: 32,
                ),
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        ElevatedButton(onPressed: _submitReview, child: Text("Submit")),
      ],
    );
  }
}
