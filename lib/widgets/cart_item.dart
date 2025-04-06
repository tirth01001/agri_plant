import 'dart:async';
import 'package:agriplant/models/product.dart';
import 'package:agriplant/provider/cart_provider.dart';
import 'package:agriplant/service/firebase_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {

  final Product cartItem;
  final void Function(int qty) ? onQtyChane;
  const CartItem({super.key, required this.cartItem,this.onQtyChane});



  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => CartProvider()..init(cartItem),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          child: const Icon(
            IconlyLight.delete,
            color: Colors.white,
            size: 25,
          ),
        ),
        confirmDismiss: (DismissDirection direction) async {
          final completer = Completer<bool>();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: "Keep",
                onPressed: () {
                  completer.complete(false);
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  //Give Change TO Take back from Cart

                },
              ),
              content: const Text(
                "Remove from cart?",
              ),
            ),

          );
          Timer(const Duration(seconds: 3), () {
            if (!completer.isCompleted) {
              completer.complete(true);
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              //Remove From Cart
              FirebaseService.service.removeProductFromCart(cartItem.productId);
              
              // Loading loading = Loading(
              //   context, 
              //   process: FirebaseService.service.removeProductFromCart(cartItem.productId),
              //   onSucess: (data) => Navigator.pop(context),
              // );
              // loading.executeProcess();

            }
          });
      
          return await completer.future;
        },
        child: SizedBox(
          height: 125,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            elevation: 0.1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: 90,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(cartItem.image[0]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartItem.name,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 2),
                        Text(
                          cartItem.description,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs.${cartItem.price["new"]}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            Consumer<CartProvider>(
                              builder: (context,provider,child) {
                                return SizedBox(
                                  height: 30,
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(99),
                                    constraints: const BoxConstraints(
                                      minHeight: 30,
                                      minWidth: 30,
                                    ),
                                    selectedColor:
                                        Theme.of(context).colorScheme.primary,
                                    isSelected: const [
                                      true,
                                      false,
                                      true,
                                    ],
                                    children: [
                                      const Icon(
                                        Icons.remove,
                                        size: 20,
                                      ),
                                      Text("${provider.product.buyQty}"),
                                      const Icon(
                                        Icons.add,
                                        size: 20,
                                      ),
                                    ],
                                    onPressed: (int index) {
                                      if (index == 0) {
                                        // decrease quantity

                                        provider.updateQtyInUI(provider.product.buyQty-1);
                                      
                                      } else if (index == 2) {
                                        // increase quantity
                                        provider.updateQtyInUI(provider.product.buyQty+1);
                                      }
                                      if(onQtyChane != null) onQtyChane!(provider.product.buyQty);
                                    },
                                  ),
                                );
                              }
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
