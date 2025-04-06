


import 'package:agriplant/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionOrder {

  final String orderId;
  final String orderStatus;
  final String orderPlaceDate;
  final double ammount;
  final String paymentMethod;
  final List<String> productPurchase;
  // final String productId;
  // final String productName;
  // final int qty;

  TransactionOrder({
    required this.orderId,
    required this.orderPlaceDate,
    required this.orderStatus,
    required this.ammount,
    required this.paymentMethod,
    required this.productPurchase,
    // required this.productId,
    // required this.productName,
    // required this.qty,
  });

  factory TransactionOrder.fromFirebase(DocumentSnapshot snap) => TransactionOrder(
    orderId: snap.get('order.oid'), 
    orderPlaceDate: snap.get('order.order_place_date'), 
    orderStatus: snap.get('order.order_status'), 
    ammount: snap.get('billing.total_pay'), 
    paymentMethod: snap.get('order.payment_mode'), 
    productPurchase: []
  );


}