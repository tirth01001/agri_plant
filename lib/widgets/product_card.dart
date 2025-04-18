import 'package:agriplant/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../pages/product_details_page.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final VoidCallback ? onTapAddToCart;
  final VoidCallback ? onTapAddToBookMark;
  final double ? height,width;
  const ProductCard({super.key,this.height,this.width,this.onTapAddToBookMark,this.onTapAddToCart, required this.product});

  String shortenString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input; // Agar string chhoti ya barabar ho maxLength ke, to original string return kare
    }
    return '${input.substring(0, maxLength)}...'; // Shorten kare aur '...' add kare
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () {
      
      
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => ProductDetailsPage(product: product)),
          );
      
      
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          elevation: 0.1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                // constraints: BoxConstraints(
                //   minHeight: 170,
                //   maxHeight: 200
                // ),
                alignment: Alignment.topRight,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      product.image[0]
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton.filledTonal(
                    padding: EdgeInsets.zero,
                    onPressed: onTapAddToBookMark,
                    iconSize: 18,
                    icon: const Icon(IconlyLight.bookmark),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        shortenString(product.name,23),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Rs.${product.price["new"]}",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              TextSpan(
                                  text: "/${product.unit}",
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton.filled(
                            padding: EdgeInsets.zero,
                            onPressed: onTapAddToCart,
                            iconSize: 18,
                            icon: const Icon(Icons.add),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // const SizedBox(height: 300,),
            ],
          ),
        ),
      ),
    );
  }
}
