import 'dart:math';

import 'package:agriplant/atemp/temp.dart';
import 'package:agriplant/data/orders.dart';
import 'package:agriplant/widgets/order_item.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ["Processing", "Picking", "Shipping", "Delivered"];

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My orders"),
          actions: [
            
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Temp()));
            }, icon: Icon(Icons.science))

          ],
          bottom: TabBar(
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: List.generate(tabs.length, (index) {
              return Tab(
                text: "${tabs[index]} ${Random().nextInt(10)}",
              );
            }),
          ),
        ),
        // body: StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection("e_farmer_order").where('customer.mobile',isEqualTo: globalUserAccount.profile[Profile.mobile]).snapshots(), 
        //   builder: (context, snapshot) {
            
        //     if(!snapshot.hasData){

        //       return Center(child: CircularProgressIndicator(),);
        //     }

        //     OrdersList list = OrdersList(snapshot.data?.docs ?? []);
        //     return TempOrdersPage(ordersList: list);

        //   },
        // ),
        body: TabBarView(
          children: List.generate(
            tabs.length,
            (index) {


              return ListView(
                padding: const EdgeInsets.all(16),
                children: List.generate(
                  orders.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: OrderItem(order: orders[index]),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
