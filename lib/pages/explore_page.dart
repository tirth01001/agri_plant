
import 'package:agriplant/models/product.dart';
import 'package:agriplant/pages/components/search_filter.dart';
import 'package:agriplant/provider/expolar_provider.dart';
import 'package:agriplant/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

// final _jobQuery = FirebaseFirestore.instance.collection("e_farmer_product").withConverter(
//     fromFirestore: (snap,_) => Product.fromSnap(snap),
//     toFirestore: (product,_) => product.map
// );
 

class ExplorePage extends StatelessWidget {

  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
  
    final ExpolarProvider expolarProvider = ExpolarProvider();

    return ChangeNotifierProvider.value(
      value: expolarProvider,
      child: Scaffold(
      
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expolarProvider.search,
                      onSubmitted: (value) {
                        if(value.isEmpty){
                          expolarProvider.switchMode(value: false);
                        }else{
                          expolarProvider.switchMode(value: true);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Search here...",
                        isDense: true,
                        contentPadding: const EdgeInsets.all(12.0),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(99),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(99),
                          ),
                        ),
                        prefixIcon: const Icon(IconlyLight.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: IconButton.filled(onPressed: () {
      
                      //Filter Icon Button Here
                      showModalBottomSheet(
                        context: context, 
                        isScrollControlled: true,
                        builder: (context) {
                          
                          return SearchFilter(
                            provider: expolarProvider,
                          );
                          // return FractionallySizedBox(
                          //   heightFactor: 0.66,
                          //   child: SearchFilter()
                          // );
                        },
                      );
      
                    }, icon: const Icon(IconlyLight.filter)),
                  ),

                  Consumer<ExpolarProvider>(
                    builder: (context, value, child) {

                      if(!value.isSearching){

                        return const SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: IconButton.filled(onPressed: (){

                          expolarProvider.category=null;
                          expolarProvider.price=null;
                          expolarProvider.rating=null;
                          expolarProvider.search.text = "";
                          expolarProvider.switchMode(value: false);

                        }, icon: Icon(IconlyBold.closeSquare,color: Colors.white,)),
                      );
                    },
                  ),
                    
                ],
              ),
            ),

            Consumer<ExpolarProvider>(
              builder: (context,provider,child) {

                if(provider.isSearching){

                  return SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: SizedBox(
                    height: 170,
                    child: Card(
                      color: Colors.green.shade50,
                      elevation: 0.1,
                      shadowColor: Colors.green.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Free consultation",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                          color: Colors.green.shade700,
                                        ),
                                  ),
                                  const Text("Get free support from our customer service"),
                                  FilledButton(
                                    onPressed: () {},
                                    child: const Text("Call now"),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'assets/contact_us.png',
                              width: 140,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
            Consumer<ExpolarProvider>(
              builder: (context,provider,child) {

                if(provider.isSearching){

                  return SizedBox();
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Featured Products",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("See all"),
                    ),
                  ],
                );
              }
            ),
      
      
            Consumer<ExpolarProvider>(
              builder: (context,provider,child) {

                return StreamBuilder(
                    // stream: FirebaseFirestore.instance.collection("e_farmer_product").snapshots(),
                    // stream: expolarProvider.searchProductStream,
                    stream: provider.searchProductStream,
                    builder: (context,snapshot){
                
                      // print("Rabuild");

                      if(snapshot.connectionState == ConnectionState.waiting){

                        return Center(child: CircularProgressIndicator(),);
                      }
                      
                      if(!snapshot.hasData){
                      
                        return Center(child: CircularProgressIndicator(),);
                      }
                      
                      List<DocumentSnapshot> snap = snapshot.data?.docs ??  [];

                      
                      return GridView.builder(
                        itemCount: snap.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {

                          // print(snap[index].data().toString());
                          // Product product = Product.fromSnap(snap[index],forCart: true)
                      
                          return ProductCard(
                            product: Product.fromSnap(snap[index],forCart: true),
                          );
                        },
                      );
                  },
                );
              }
            )
      
            // GridView.builder(
            //   itemCount: products.length,
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: 0.9,
            //     crossAxisSpacing: 16,
            //     mainAxisSpacing: 16,
            //   ),
            //   itemBuilder: (context, index) {
            //     return ProductCard(product: products[index]);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
