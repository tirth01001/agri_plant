import 'package:agriplant/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final List<Product> products;
  final DateTime date;
  
  OrderModel({
    required this.id,
    required this.products,
    required this.date,
  });
}



class Order {

  final String orderId,sid;
  final Map<String,dynamic> billing;
  final Map<String,dynamic> cart,customer,shipping,product,order;

  Order({
    this.billing=const{},
    this.cart=const{},
    this.customer=const{},
    this.order=const{},
    this.orderId="",
    this.product=const{},
    this.shipping=const{},
    this.sid=""
  });
  
  factory Order.fromSnap(DocumentSnapshot fromSnap) => Order(
    billing: fromSnap.get('billing'),
    cart: fromSnap.get('cart'),
    customer: fromSnap.get('customer'),
    order: fromSnap.get('order'),
    product: fromSnap.get('product'),
    shipping: fromSnap.get('shipping'),
    orderId: fromSnap.get('order')['oid'],
    sid: fromSnap.get('sid'),
  );

}

enum FilterStatus {
  processing, //Processing
  shipped, // Picking
  outofDelivery, // Out of Delivery mean Shipping,
  delivered // Delivered 
}

class OrdersList {

  Map<DateTime,List<Order>> listOfOrders = {};
  Map<DateTime,List<Order>> filteredOrder = {};
  final Map<FilterStatus,String> actualName ={
    FilterStatus.processing: "Processing",
    FilterStatus.delivered: "Delivered",
    FilterStatus.outofDelivery: "Out of Delivery",
    FilterStatus.shipped: "Shipped",
  };

  int countOfProcessingOurder = 0;
  int countOfPickingOrder = 0;
  int countOfShippedOrder = 0;
  int countOfDeliveredOrder = 0;

  OrdersList(List<DocumentSnapshot> userOrders,{FilterStatus status=FilterStatus.processing}){
    for(int i=0;i<userOrders.length;i++){
      Order order = Order.fromSnap(userOrders[i]);
      Timestamp dt = order.order["order_place_date"];
      DateTime dateTime = dt.toDate();
      DateTime dateOnly = DateTime(dateTime.year,dateTime.month,dateTime.day);
      
      if(listOfOrders[dateOnly] != null){
        // print("Add TO${order.orderId}");
        listOfOrders[dateOnly]!.add(order);
        // if(order.order["order_status"] == actualName[status]){
        // }

      }else{
        listOfOrders[dateOnly] = [order];
        // if(order.order["order_status"] == actualName[status]){
        // }
      }
    }
  }


  void filterOrder({FilterStatus filter=FilterStatus.processing}){
    filteredOrder = {};
    List<DateTime> keys = listOfOrders.keys.toList();
    for(int i=0;i<keys.length;i++){
      for(int j=0;j<listOfOrders[keys[i]]!.length;j++){
        if(listOfOrders[keys[i]]![j].order["order_status"] == actualName[filter]){
          if(filteredOrder.containsKey(keys[i])){
            filteredOrder[keys[i]]!.add(listOfOrders[keys[i]]![j]);
          }else{
            filteredOrder[keys[i]] = [listOfOrders[keys[i]]![j]];
          }
        }
      }
    }
  }

  void consolePrint(){
    filteredOrder.forEach((key,value){
      print("Value On $key");
      for(int i=0;i<value.length;i++){
        print("\t${value[i].orderId}");
        print("\t${value[i].order["order_status"]}");
        // print("\t${value[i].orderId}");
      }
    });
  }

}
