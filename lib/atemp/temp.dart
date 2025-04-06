



import 'package:agriplant/atemp/temp_order_page.dart';
import 'package:agriplant/models/order.dart';
import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/onboarding_page.dart';
import 'package:agriplant/provider/order_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final OrderProvider _provider = OrderProvider();

class Temp extends StatelessWidget {

  const Temp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        body: Consumer<OrderProvider>(
          builder: (context,provider,child) {
      
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("e_farmer_order").where('customer.id',isEqualTo: globalUserAccount.uid).snapshots(), 
              builder: (context, snapshot) {

                // print("Recall");
                
                if(!snapshot.hasData){
            
                  return Center(child: CircularProgressIndicator(),);
                }
            
                OrdersList ordersList = OrdersList(snapshot.data?.docs ?? []);
                ordersList.filterOrder(
                  filter: provider.orderFilterStatus
                );
                // print(provider.orderFilterStatus.toString());

                return TempOrdersPage(
                  ordersList: ordersList,
                  orderProvider: provider,
                );

                
              },
            );
          }
        ),
      ),
    );
  }
}