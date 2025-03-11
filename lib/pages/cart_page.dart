import 'package:agriplant/data/products.dart';
import 'package:agriplant/models/product.dart';
import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:agriplant/widgets/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  
  final cartItems = products.take(4).toList();

  @override
  Widget build(BuildContext context) {
    
    // final total = cartItems.map((cartItem) => cartItem.price).reduce((value, element) => value + element).toStringAsFixed(2);
    double total = 0.0;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("E_Farmer").doc(globalUserAccount.profile[Profile.mobile]).collection("user_cart").snapshots(),
        builder: (context,snapshot) {

          if(snapshot.hasError){

            return Center(child: Text("Error: ${snapshot.error}"),);
          }

          if(!snapshot.hasData){

            return Center(child: CircularProgressIndicator(),);
          }

          List<DocumentSnapshot> productList = snapshot.data?.docs ?? [];

          

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...List.generate(
                  productList.length,
                  (index) {
                    
                    final cartItem = Product.fromSnap(productList[index]);
                    total += cartItem.price["new"];
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CartItem(cartItem: cartItem),
                    );
                  },
                ),
                // ...List.generate(
                //   cartItems.length,
                //   (index) {
                    
                //     final cartItem = cartItems[index];
                    
                //     return Padding(
                //       padding: const EdgeInsets.only(bottom: 5),
                //       child: CartItem(cartItem: cartItem),
                //     );
                //   },
                // ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total (${productList.length} items)"),
                    Text(
                      "\$$total",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {},
                    label: const Text("Proceed to Checkout"),
                    icon: const Icon(IconlyBold.arrowRight),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
