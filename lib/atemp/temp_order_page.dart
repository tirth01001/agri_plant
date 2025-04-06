
import 'package:agriplant/atemp/temp_order_item.dart';
import 'package:agriplant/models/order.dart';
import 'package:agriplant/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int _ctabIndex = 0;
class TempOrdersPage extends StatelessWidget {
  
  final OrderProvider orderProvider;
  final OrdersList ordersList;
  const TempOrdersPage({super.key,required this.orderProvider,required this.ordersList});

  @override
  Widget build(BuildContext context) {

    final tabs = ["Processing", "Picking", "Shipping", "Delivered"];
    final List<DateTime> keys = ordersList.filteredOrder.keys.toList();

    // print("Rebuild Order PGAE ${keys.length}");
    // final List<DateTime> keys = ordersList.listOfOrders.keys.toList();
    
    return ChangeNotifierProvider.value(
      value: orderProvider,
      child: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My orders"),
            bottom: TabBar(
              onTap: (idx){
                
                _ctabIndex = idx;
                ordersList.filterOrder(filter: orderProvider.filters[idx]);
                // ordersList.consolePrint();
                orderProvider.changeStatus(orderProvider.filters[idx]);

              },
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: List.generate(tabs.length, (index) {

                String count = _ctabIndex == index ? keys.length.toString() : "";

                return Tab(
                  text: "${tabs[index]} $count ",
                );
              }),
            ),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: List.generate(tabs.length,(index) {

              // print(index);
          
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: List.generate(keys.length,(index) {
          
                    // print(keys[index].toString());
          
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TempOrderItem(
                          date: keys[index],
                          order: ordersList.filteredOrder[keys[index]]??[]
                        ),
                      );
                    },
                  ),
                );
          
              },
          
            ),
          ),
        ),
      ),
    );
  }
}
