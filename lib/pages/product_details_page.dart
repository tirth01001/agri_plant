
import 'package:agriplant/main.dart';
import 'package:agriplant/screens/reviews_page.dart';
import 'package:agriplant/service/firebase_service.dart';
import 'package:agriplant/service/loading.dart';
import 'package:agriplant/widgets/product_card.dart';
import 'package:agriplant/widgets/reviews_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../models/product.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {


  late TapGestureRecognizer readMoreGestureRecognizer;
  bool showMore = false;

  @override
  void initState() {
    super.initState();
    readMoreGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showMore = !showMore;
        });
      };
  }

  @override
  void dispose() {
    super.dispose();
    readMoreGestureRecognizer.dispose();
  }


  Future<Map<String,dynamic>> fetchReviewData() async {
    try{
      DocumentSnapshot<Map<String,dynamic>> snap = await FirebaseFirestore.instance.collection("e_farmer_product_rating").doc(widget.product.productId).get();
      Map<String,dynamic> reviews = snap.data() ?? {};
      return reviews;
    }catch(e){
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyLight.bookmark),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 350,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.product.image[0]),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            widget.product.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Available in stock",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Rs.${widget.product.price["new"]}",
                        style: Theme.of(context).textTheme.titleLarge),
                    TextSpan(
                        text: "/${widget.product.unit}",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: Colors.yellow.shade800,
              ),
              Text(
                "${widget.product.rating} (${widget.product.ratedBy.length})",
              ),
              const Spacer(),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton.filledTonal(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if(widget.product.buyQty != 0 || widget.product.buyQty < 0) return;
                    setState(() {
                      widget.product.buyQty--;
                    });
                  },
                  iconSize: 18,
                  icon: const Icon(Icons.remove),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "${widget.product.buyQty} ${widget.product.unit}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton.filledTonal(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      widget.product.buyQty++;
                    });
                  },
                  iconSize: 18,
                  icon: const Icon(Icons.add),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text("Size: ${widget.product.size["p_size"]} ${widget.product.size["size_in"]}",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          const SizedBox(height: 20),
          Text("Description",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: showMore
                      ? widget.product.description
                      : '${widget.product.description.substring(0, widget.product.description.length - 100)}...',
                ),
                TextSpan(
                  recognizer: readMoreGestureRecognizer,
                  text: showMore ? " Read less" : " Read more",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text("Description",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          FutureBuilder(
            future: fetchReviewData(), 
            builder: (context, snapshot) {
              
              if(!snapshot.hasData){

                return Center(child: CircularProgressIndicator(),);
              }

              if(snapshot.data!.isEmpty){

                return Center(
                  child: Text("There is not reviews yet !"),
                );
              }

              List<dynamic> reviewsCount = [
                snapshot.data?["star_1_count"]??0,
                snapshot.data?["star_2_count"]??0,
                snapshot.data?["star_3_count"]??0,
                snapshot.data?["star_4_count"]??0,
                snapshot.data?["star_5_count"]??0,
              ];

              List<int> sumOfAll = reviewsCount.cast<int>();
              int maxValue = sumOfAll.reduce((a,b) => a > b ? a : b);
              int atIndex = sumOfAll.indexWhere((ele) => ele == maxValue);
              return ReviewBox(
                starCounts: sumOfAll,
                totalReviews: snapshot.data?['total_review'],
                // averageRating: snapshot.data?['avg_review'],
                averageRating: atIndex == 0 ? 1.5 : atIndex == 1 ? 2.5 : atIndex == 2 ? 3.5 : atIndex == 3 ? 4.5 : 5,
              );
            },
          ),
          const SizedBox(height: 20),
          Container(
            height: 40,
            width: maxW-40,
            // margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsPage(productId: widget.product.productId)));
              }, 
              child: Center(child: Text("View reviews"))
            ),
          ),
          // ReviewBox(),
          const SizedBox(height: 20),
          Text(
            "Similar Products",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),



          //Display Similar Product Mean similar Category Product 
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("e_farmer_product")
            .where('category',isEqualTo: widget.product.category)
            .snapshots(), 
            builder: (context, snapshot) {
              
              if(!snapshot.hasData){

                return Center(child: CircularProgressIndicator(),);
              }

              List<DocumentSnapshot> snap = snapshot.data?.docs ?? [];

              return Container(
                height: 230,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    
                    return ProductCard(
                      width: 200,
                      // height: 120,
                      product: Product.fromSnap(snap[index]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    
                    return SizedBox(width: 10,);
                  }, 
                  itemCount: snap.length
                ),
              );
            },
          ),

          // SizedBox(
          //   height: 90,
          //   child: ListView.separated(
          //     physics: const BouncingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         height: 90,
          //         width: 80,
          //         margin: const EdgeInsets.only(bottom: 16),
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: AssetImage(products[index].image[0]),
          //             fit: BoxFit.cover,
          //           ),
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //       );
          //     },
          //     separatorBuilder: (__, _) => const SizedBox(
          //       width: 10,
          //     ),
          //     itemCount: products.length,
          //   ),
          // ),
          const SizedBox(height: 20),
          FilledButton.icon( 
            onPressed: () {

              Loading loading = Loading<Result>(
                context, 
                process: FirebaseService.service.addProductToCart(widget.product),
                onSucess: (data) {
                  // print(data.toString());
                  showDialog(context: context, builder: (context) => AlertDialog(
                    content: SizedBox(
                      height: 100,
                      child: Center(child: Text("Product Added Into Cart !"),)
                    )
                  ));
                },
              );

              loading.executeProcess();

            },
            icon: const Icon(IconlyLight.bag2),
            label: const Text("Add to cart")
          )
        ],
      ),
    );
  }
}
